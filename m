From: olof@lixom.net (Olof Johansson)
Date: Wed, 2 Oct 2013 14:07:49 -0700
Subject: [PATCH 0/5] Add some missing bits for exynos5250-snow
In-Reply-To: <1380670860-17621-1-git-send-email-seanpaul@chromium.org>
References: <1380670860-17621-1-git-send-email-seanpaul@chromium.org>
Message-ID: <CAOesGMijLSoKz9DTmSLr3YY-8=NoB97brhC-rSPj1x8zs1NXKQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Tue, Oct 1, 2013 at 4:40 PM, Sean Paul <seanpaul@chromium.org> wrote:
> This set adds some missing devicetree nodes to the exynos5250-snow file as well
> as adds a drm_bridge driver for the ptn3460 DP-LVDS chip. This chip is used in
> the exynos5250-snow board.
>
> Sean
>
>
> Sean Paul (5):
>  ARM: dts: Add fimd display-timings for exynos5250-snow
>  ARM: dts: Add dp-controller node to exynos5250-snow
>  drm/bridge: Add PTN3460 bridge driver
>  drm/exynos: Initialize ptn3460 if present
>  ARM: dts: Add ptn3460 to exynos5250-snow
>
> Documentation/devicetree/bindings/drm/bridge/ptn3460.txt |  27 +++++++++++++++++++++++++
> arch/arm/boot/dts/exynos5250-snow.dts                    |  48 ++++++++++++++++++++++++++++++++++++++++++++

This should go in through Kukjin and the arm-soc tree, not through DRM
(Looking at the actual patch shortly).

> drivers/gpu/drm/Kconfig                                  |   2 ++
> drivers/gpu/drm/Makefile                                 |   1 +
> drivers/gpu/drm/bridge/Kconfig                           |   4 ++++
> drivers/gpu/drm/bridge/Makefile                          |   3 +++
> drivers/gpu/drm/bridge/ptn3460.c                         | 349 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

Tip: When you generate the diffstat, redirect to a file or size your
window to something less than, oh, 300 characters wide or so. Maybe
even down to 80. :)


-Olof
