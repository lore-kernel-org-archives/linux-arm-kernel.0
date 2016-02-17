From: sfr@canb.auug.org.au (Stephen Rothwell)
Date: Thu, 18 Feb 2016 10:33:03 +1100
Subject: linux-next: manual merge of the mvebu tree with the arm-soc tree
Message-ID: <20160218103303.4cc2d25e@canb.auug.org.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi all,

Today's linux-next merge of the mvebu tree got a conflict in:

  arch/arm64/configs/defconfig

between commit:

  efdda175c07f ("arm64: defconfig: add spmi and usb related configs")

from the arm-soc tree and commit:

  e772ca05cceb ("arm64: defconfig: enable Armada 3700 related config")

from the mvebu tree.

I fixed it up (see below) and can carry the fix as necessary (no action
is required).

-- 
Cheers,
Stephen Rothwell

diff --cc arch/arm64/configs/defconfig
index 91ae2634cae9,00a49b4e61c1..000000000000
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@@ -170,9 -169,9 +173,11 @@@ CONFIG_SND_SOC=
  CONFIG_SND_SOC_RCAR=y
  CONFIG_SND_SOC_AK4613=y
  CONFIG_USB=y
 +CONFIG_USB_OTG=y
+ CONFIG_USB_XHCI_HCD=y
+ CONFIG_USB_XHCI_PLATFORM=y
  CONFIG_USB_EHCI_HCD=y
 +CONFIG_USB_EHCI_MSM=y
  CONFIG_USB_EHCI_HCD_PLATFORM=y
  CONFIG_USB_OHCI_HCD=y
  CONFIG_USB_OHCI_HCD_PLATFORM=y
