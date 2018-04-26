From: icenowy@aosc.io (Icenowy Zheng)
Date: Thu, 26 Apr 2018 22:07:25 +0800
Subject: [PATCH 0/3] Enable basic MMC support on Allwinner H6
Message-ID: <20180426140728.43155-1-icenowy@aosc.io>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Allwinner H6 features 3 SD/MMC controllers. The first and second ones
are similar to the ones on the Allwinner A64/H5 SoCs, and the third one
adds the function to use EMCE (EMbedded Crypto Engine) on the Allwinner
H6 chip to do full-disk encryption.

Enable basic MMC support on Allwinner H6. Higher speed bins are not
supported, similar to A64/H5. EMCE is also not supported, and keeps its
bypassed status by default.

Icenowy Zheng (3):
  mmc: sunxi: add support for the MMC controller on H6
  arm64: allwinner: h6: add device tree nodes for MMC controllers
  arm64: allwinner: h6: enable MMC0/2 on Pine H64

 .../devicetree/bindings/mmc/sunxi-mmc.txt          |  2 +
 .../boot/dts/allwinner/sun50i-h6-pine-h64.dts      | 32 +++++++++++++
 arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi       | 56 ++++++++++++++++++++++
 drivers/mmc/host/sunxi-mmc.c                       | 16 +++++++
 4 files changed, 106 insertions(+)

-- 
2.15.1
