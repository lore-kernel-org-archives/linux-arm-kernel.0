From: sfr@canb.auug.org.au (Stephen Rothwell)
Date: Tue, 3 Apr 2018 12:00:00 +1000
Subject: linux-next: manual merge of the pci tree with the arm-soc tree
Message-ID: <20180403120000.4ff083a0@canb.auug.org.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi all,

Today's linux-next merge of the pci tree got a conflict in:

  drivers/bus/Makefile

between commit:

  1888d3ddc3d6 ("drivers/bus: Move Arm CCN PMU driver")

from the arm-soc tree and commit:

  38e3446c5d06 ("HISI LPC: Support the LPC host on Hip06/Hip07 with DT bindings")

from the pci tree.

I fixed it up (see below) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

-- 
Cheers,
Stephen Rothwell

diff --cc drivers/bus/Makefile
index 3d473b8adeac,50bb12a971a0..000000000000
--- a/drivers/bus/Makefile
+++ b/drivers/bus/Makefile
@@@ -5,11 -5,10 +5,13 @@@
  
  # Interconnect bus drivers for ARM platforms
  obj-$(CONFIG_ARM_CCI)		+= arm-cci.o
 -obj-$(CONFIG_ARM_CCN)		+= arm-ccn.o
+ 
+ obj-$(CONFIG_HISILICON_LPC)	+= hisi_lpc.o
  obj-$(CONFIG_BRCMSTB_GISB_ARB)	+= brcmstb_gisb.o
 +
 +# DPAA2 fsl-mc bus
 +obj-$(CONFIG_FSL_MC_BUS)	+= fsl-mc/
 +
  obj-$(CONFIG_IMX_WEIM)		+= imx-weim.o
  obj-$(CONFIG_MIPS_CDMM)		+= mips_cdmm.o
  obj-$(CONFIG_MVEBU_MBUS) 	+= mvebu-mbus.o
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 488 bytes
Desc: OpenPGP digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180403/1485cf80/attachment.sig>
