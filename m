From: sfr@canb.auug.org.au (Stephen Rothwell)
Date: Mon, 3 Mar 2014 18:13:37 +1100
Subject: linux-next: manual merge of the usb tree with the arm-soc tree
Message-ID: <20140303181337.186b799feeb9ca132a7579a1@canb.auug.org.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Greg,

Today's linux-next merge of the usb tree got a conflict in
arch/arm/mach-tegra/Kconfig between commit ddb902cc3459 ("ARM: centralize
common multi-platform kconfig options") from the arm-soc tree and commit
f6723b569a67 ("usb: host: remove selects of USB_ARCH_HAS_?HCI") from the
usb tree.

I fixed it up (see below) and can carry the fix as necessary (no action
is required).

-- 
Cheers,
Stephen Rothwell                    sfr at canb.auug.org.au

diff --cc arch/arm/mach-tegra/Kconfig
index f61cd5b9f103,4926bd11f190..000000000000
--- a/arch/arm/mach-tegra/Kconfig
+++ b/arch/arm/mach-tegra/Kconfig
@@@ -12,9 -18,10 +12,8 @@@ config ARCH_TEGR
  	select ARCH_HAS_RESET_CONTROLLER
  	select RESET_CONTROLLER
  	select SOC_BUS
- 	select USB_ARCH_HAS_EHCI if USB_SUPPORT
 -	select SPARSE_IRQ
  	select USB_ULPI if USB_PHY
  	select USB_ULPI_VIEWPORT if USB_PHY
 -	select USE_OF
  	help
  	  This enables support for NVIDIA Tegra based systems.
  
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 836 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140303/c62d0b98/attachment.sig>
