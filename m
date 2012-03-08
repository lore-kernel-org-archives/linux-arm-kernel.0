From: olof@lixom.net (Olof Johansson)
Date: Thu, 8 Mar 2012 07:16:59 -0800
Subject: [GIT PULL] Samsung Cleanup EXYNOS clock for v3.4
In-Reply-To: <4F589474.8050609@samsung.com>
References: <4F589474.8050609@samsung.com>
Message-ID: <CAOesGMiWOChuMjLQTK1pGys+oXCc4A=HO-2_=37rh3M6pgUP_g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Thu, Mar 8, 2012 at 3:13 AM, Kukjin Kim <kgene.kim@samsung.com> wrote:

> Kukjin Kim (2):
> ? ? ?ARM: EXYNOS: cleanup clock part for new EXYNOS SoCs

This is one large commit that does many things in one change. As the
patch message says:

ARM: EXYNOS: cleanup clock part for new EXYNOS SoCs

- the prefix of clk register replace S5P_ with EXYNOS4_
- move mach-exynos/clock.c to mach-exynos/clock-exynos4.c
- according to moving clock-exynos4.c,
  move <mach/exynos4-clock.h> to "clock-exynos4.h"
- add prefix exynos4_ on clk declaration

It makes it hard to review, especially when you combine a move with
other changes. It's better to do the move in a separate commit that
doesn't change code (or only changes very very little) and then do the
other changes in separate commits later.


-Olof
