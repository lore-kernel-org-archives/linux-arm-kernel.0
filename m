From: sfr@canb.auug.org.au (Stephen Rothwell)
Date: Thu, 25 Feb 2016 09:07:02 +1100
Subject: linux-next: manual merge of the renesas tree with the arm-soc tree
Message-ID: <20160225090702.6f090bcf@canb.auug.org.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Simon,

Today's linux-next merge of the renesas tree got a conflict in:

  arch/arm64/configs/defconfig

between commit:

  efdda175c07f ("arm64: defconfig: add spmi and usb related configs")

from the arm-soc tree and commit:

  a9c42f02387c ("arm64: defconfig: Add Renesas R-Car Gen3 USB 2.0 phy driver support")

from the renesas tree.

I fixed it up (see below) and can carry the fix as necessary (no action
is required).

-- 
Cheers,
Stephen Rothwell

diff --cc arch/arm64/configs/defconfig
index 7fddb2188f5c,eaf738a59927..000000000000
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@@ -230,7 -213,7 +230,8 @@@ CONFIG_QCOM_SMD_RPM=
  CONFIG_ARCH_TEGRA_132_SOC=y
  CONFIG_ARCH_TEGRA_210_SOC=y
  CONFIG_HISILICON_IRQ_MBIGEN=y
 +CONFIG_EXTCON_USB_GPIO=y
+ CONFIG_PHY_RCAR_GEN3_USB2=y
  CONFIG_PHY_XGENE=y
  CONFIG_EXT2_FS=y
  CONFIG_EXT3_FS=y
