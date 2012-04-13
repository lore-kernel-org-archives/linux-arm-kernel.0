From: lee.jones@linaro.org (Lee Jones)
Date: Fri, 13 Apr 2012 15:05:02 +0100
Subject: [PATCH 0/7 v2] Next round of DT enablement for ux500/Snowball
Message-ID: <1334325909-5779-1-git-send-email-lee.jones@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

In this patch-set we change a couple of DT compatible entries
to something less cumbersome. Then we have a second stab at 
enabling DT for mmci. Only this time keeping it simple and 
continuing to use current DMA initialisation code. We'll 
change that once the generic bindings for DMA have been 
mainlined. Finally we enable Snowball's GPIO controller.

.../devicetree/bindings/gpio/gpio-nmk.txt          |   29 ++++++++++
 Documentation/devicetree/bindings/mmc/mmci.txt     |   19 +++++++
 arch/arm/boot/dts/db8500.dtsi                      |   46 +++++++++++-----
 arch/arm/boot/dts/snowball.dts                     |   39 +++++++++----
 arch/arm/mach-ux500/board-mop500-sdi.c             |    4 +-
 arch/arm/mach-ux500/board-mop500.c                 |   15 +++++-
 arch/arm/mach-ux500/board-mop500.h                 |    4 ++
 drivers/gpio/gpio-nomadik.c                        |   41 +++++++++++++-
 drivers/mmc/host/mmci.c                            |   58 ++++++++++++++++++--
 9 files changed, 219 insertions(+), 36 deletions(-)
