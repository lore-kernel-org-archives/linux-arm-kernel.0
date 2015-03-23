From: sfr@canb.auug.org.au (Stephen Rothwell)
Date: Mon, 23 Mar 2015 12:03:14 +1100
Subject: linux-next: manual merge of the mips tree with the arm-soc tree
Message-ID: <20150323120314.3631211a@canb.auug.org.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Ralf,

Today's linux-next merge of the mips tree got a conflict in
drivers/bus/Makefile between commit 6320c41198c7 ("drivers: bus: Sort
Makefile entries alphabetically") from the arm-soc tree and commit
cd46cf20d04a ("MIPS: Add CDMM bus support") from the mips tree.

I fixed it up (see below) and can carry the fix as necessary (no action
is required).

-- 
Cheers,
Stephen Rothwell                    sfr at canb.auug.org.au

diff --cc drivers/bus/Makefile
index e023a2bec664,807dd17ef2f8..000000000000
--- a/drivers/bus/Makefile
+++ b/drivers/bus/Makefile
@@@ -2,13 -2,11 +2,14 @@@
  # Makefile for the bus drivers.
  #
  
 +# Interconnect bus drivers for ARM platforms
 +obj-$(CONFIG_ARM_CCI)		+= arm-cci.o
 +obj-$(CONFIG_ARM_CCN)		+= arm-ccn.o
 +
  obj-$(CONFIG_BRCMSTB_GISB_ARB)	+= brcmstb_gisb.o
 -obj-$(CONFIG_IMX_WEIM)	+= imx-weim.o
 +obj-$(CONFIG_IMX_WEIM)		+= imx-weim.o
+ obj-$(CONFIG_MIPS_CDMM) += mips_cdmm.o
 -obj-$(CONFIG_MVEBU_MBUS) += mvebu-mbus.o
 -obj-$(CONFIG_OMAP_OCP2SCP)	+= omap-ocp2scp.o
 +obj-$(CONFIG_MVEBU_MBUS) 	+= mvebu-mbus.o
  
  # Interconnect bus driver for OMAP SoCs.
  obj-$(CONFIG_OMAP_INTERCONNECT)	+= omap_l3_smx.o omap_l3_noc.o
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 819 bytes
Desc: OpenPGP digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150323/adc78331/attachment.sig>
