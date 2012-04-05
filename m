From: lee.jones@linaro.org (Lee Jones)
Date: Thu,  5 Apr 2012 10:55:41 +0100
Subject: [0/7] Next round of DT enablement for ux500/Snowball
Message-ID: <1333619748-16126-1-git-send-email-lee.jones@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch-set lays some simple foundations which will ease
the DT enablement process for future one-by-one device
enablement. Then we have a second stab at enabling DT for
mmci. Only this time keeping it simple and continuing to use
current DMA initialisation code. We'll change that once the
generic bindings for DMA have been mainlined. Finally we 
enable Snowball's GPIO controller.

 .../devicetree/bindings/gpio/gpio-nmk.txt          |   29 ++++++++++
 Documentation/devicetree/bindings/mmc/mmci.txt     |   19 +++++++
 arch/arm/boot/dts/db8500.dtsi                      |   18 ++++++
 arch/arm/boot/dts/snowball.dts                     |   39 +++++++++----
 arch/arm/mach-ux500/board-mop500-sdi.c             |    4 +-
 arch/arm/mach-ux500/board-mop500.c                 |   35 +++++++++++--
 arch/arm/mach-ux500/board-mop500.h                 |    4 ++
 arch/arm/mach-ux500/cpu-db8500.c                   |   22 ++++++++
 arch/arm/mach-ux500/include/mach/setup.h           |    3 +
 drivers/gpio/gpio-nomadik.c                        |   41 +++++++++++++-
 drivers/mmc/host/mmci.c                            |   58 ++++++++++++++++++--
 11 files changed, 247 insertions(+), 25 deletions(-)
