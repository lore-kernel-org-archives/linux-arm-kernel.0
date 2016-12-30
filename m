From: linus.walleij@linaro.org (Linus Walleij)
Date: Fri, 30 Dec 2016 10:19:23 +0100
Subject: [PATCH 5/9] pinctrl: samsung: Move retention control from
 mach-exynos to the pinctrl driver
In-Reply-To: <1482495889-6201-6-git-send-email-m.szyprowski@samsung.com>
References: <CGME20161223122531epcas1p4b8fad6664dad3408acb7a1b9f140884a@epcas1p4.samsung.com>
 <1482495889-6201-1-git-send-email-m.szyprowski@samsung.com>
 <1482495889-6201-6-git-send-email-m.szyprowski@samsung.com>
Message-ID: <CACRpkdYHxCmvtnCRD3E2+Ct7yzUeg6tkEKr46nK8ATJPqfPcjg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Dec 23, 2016 at 1:24 PM, Marek Szyprowski
<m.szyprowski@samsung.com> wrote:

> Pad retention control after suspend/resume cycle should be done from pin
> controller driver instead of PMU (power management unit) driver to avoid
> possible ordering and logical dependencies. Till now it worked fine only
> because PMU driver registered its sys_ops after pin controller.
>
> This patch moves pad retention control from PMU driver to Exynos pin
> controller driver. This is a preparation for adding new features to Exynos
> pin controller driver, like runtime power management and suspending
> individual pin controllers, which might be a part of some power domain.
>
> Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>

Clear and elegant.

I will need an ACK from some ARM SoC person on this so they are
aware that we rip code out of mach-* to pinctrl.

Yours,
Linus Walleij
