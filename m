From: sfr@canb.auug.org.au (Stephen Rothwell)
Date: Mon, 16 Jun 2014 09:59:28 +1000
Subject: linux-next: manual merge of the imx-mxs tree with the  tree
Message-ID: <20140616095928.1f21f8af@canb.auug.org.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Shawn,

Today's linux-next merge of the imx-mxs tree got a conflict in
arch/arm/mach-imx/Kconfig between commit e49d9b375628 ("ARM: Remove
ARCH_HAS_CPUFREQ config option") from the arm-soc tree and commit
7de46855b1e7 ("ARM: imx5: move SOC_IMX5 and SOC_IMX51 into 'Device tree
only'") from the imx-mxs tree.

I fixed it up (see below) and can carry the fix as necessary (no action
is required).

-- 
Cheers,
Stephen Rothwell                    sfr at canb.auug.org.au

diff --cc arch/arm/mach-imx/Kconfig
index 28fa2fa49e5d,3b2a5c58cf91..000000000000
--- a/arch/arm/mach-imx/Kconfig
+++ b/arch/arm/mach-imx/Kconfig
@@@ -700,9 -691,15 +688,14 @@@ if ARCH_MULTI_V
  
  comment "Device tree only"
  
+ config SOC_IMX5
+ 	bool
 -	select ARCH_HAS_CPUFREQ
+ 	select ARCH_HAS_OPP
+ 	select HAVE_IMX_SRC
+ 	select MXC_TZIC
+ 
  config	SOC_IMX50
  	bool "i.MX50 support"
- 	select HAVE_IMX_SRC
  	select PINCTRL_IMX50
  	select SOC_IMX5
  
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140616/d8a413c9/attachment.sig>
