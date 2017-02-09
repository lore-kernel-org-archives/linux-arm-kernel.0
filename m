From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Thu,  9 Feb 2017 17:39:14 +0100
Subject: [PATCH 0/8] ARM: sun8i: a33: Mali improvements
Message-ID: <cover.7101c7323e6f22e281ad70b93488cf44caca4ca0.1486655917.git-series.maxime.ripard@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

This serie is building on the recently merged bindings for the ARM Mali
Utgard GPU.

The two features that are supported with this serie are DVFS and the fbdev
support. The first one uses devfreq and is pretty standard, the only
addition being the generic OPP mechanism we have, plus some DT and Kconfig
patches.

Running on framebuffer is a bit more tedious, since we need to access the
CMA memory region size and base. This is quite trivial to do as well
through the memory-region bindings, but require to export a few symbols
along the way to make sure our module builds properly.

Let me know what you think,
Maxime

Maxime Ripard (8):
  ARM: sun8i: Fix the mali clock rate
  dt-bindings: gpu: mali: Add optional memory-region
  mm: cma: Export a few symbols
  drm/sun4i: Grab reserved memory region
  ARM: sun8i: a33: Add shared display memory pool
  dt-bindings: gpu: mali: Add optional OPPs
  ARM: sunxi: Select PM_OPP
  ARM: sun8i: a33: Add the Mali OPPs

 Documentation/devicetree/bindings/gpu/arm,mali-utgard.txt |  8 ++-
 arch/arm/boot/dts/sun8i-a23-a33.dtsi                      |  2 +-
 arch/arm/boot/dts/sun8i-a33.dtsi                          | 34 ++++++++-
 arch/arm/mach-sunxi/Kconfig                               |  1 +-
 drivers/base/dma-contiguous.c                             |  1 +-
 drivers/gpu/drm/sun4i/sun4i_drv.c                         | 19 ++--
 mm/cma.c                                                  |  2 +-
 7 files changed, 61 insertions(+), 6 deletions(-)

base-commit: a2138ce584d59571dd18a6cf3417cb90be7625d8
-- 
git-series 0.8.11
