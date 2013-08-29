From: sfr@canb.auug.org.au (Stephen Rothwell)
Date: Thu, 29 Aug 2013 17:47:17 +1000
Subject: linux-next: manual merge of the arm-soc tree with the v4l-dvb tree
Message-ID: <20130829174717.0c3a263e468c307849507aba@canb.auug.org.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi all,

Today's linux-next merge of the arm-soc tree got a conflict in
arch/arm/mach-shmobile/include/mach/r8a7778.h between commit 803c2df21752
("[media] ARM: shmobile: r8a7778: add VIN support") from the v4l-dvb tree
and commits cfa66a81621d ("ARM: shmobile: bockw: add DT reference"),
a66c9744574c ("ARM: shmobile: r8a7778: cleanup registration of mmcif")
and 044e2121466a ("ARM: shmobile: r8a7778: cleanup registration of usb
phy") from the arm-soc tree.

I fixed it up (see below) and can carry the fix as necessary (no action
is required).

-- 
Cheers,
Stephen Rothwell                    sfr at canb.auug.org.au

diff --cc arch/arm/mach-shmobile/include/mach/r8a7778.h
index a7c6d15,41fd6da..0000000
--- a/arch/arm/mach-shmobile/include/mach/r8a7778.h
+++ b/arch/arm/mach-shmobile/include/mach/r8a7778.h
@@@ -18,21 -18,12 +18,15 @@@
  #ifndef __ASM_R8A7778_H__
  #define __ASM_R8A7778_H__
  
- #include <linux/mmc/sh_mmcif.h>
- #include <linux/mmc/sh_mobile_sdhi.h>
  #include <linux/sh_eth.h>
- #include <linux/platform_data/usb-rcar-phy.h>
 +#include <linux/platform_data/camera-rcar.h>
  
  extern void r8a7778_add_standard_devices(void);
  extern void r8a7778_add_standard_devices_dt(void);
  extern void r8a7778_add_ether_device(struct sh_eth_plat_data *pdata);
- extern void r8a7778_add_usb_phy_device(struct rcar_phy_platform_data *pdata);
- extern void r8a7778_add_i2c_device(int id);
- extern void r8a7778_add_hspi_device(int id);
- extern void r8a7778_add_mmc_device(struct sh_mmcif_plat_data *info);
 +extern void r8a7778_add_vin_device(int id,
 +				   struct rcar_vin_platform_data *pdata);
+ extern void r8a7778_add_dt_devices(void);
  
  extern void r8a7778_init_late(void);
  extern void r8a7778_init_delay(void);
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 836 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130829/77100446/attachment.sig>
