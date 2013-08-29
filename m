From: sfr@canb.auug.org.au (Stephen Rothwell)
Date: Thu, 29 Aug 2013 17:50:12 +1000
Subject: linux-next: manual merge of the arm-soc tree with the v4l-dvb tree
Message-ID: <20130829175012.2380fdebfa8a5f57695e5467@canb.auug.org.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi all,

Today's linux-next merge of the arm-soc tree got a conflict in
arch/arm/mach-shmobile/include/mach/r8a7779.h between commit 4714a0255eee
("[media] ARM: shmobile: r8a7779: add VIN support") from the v4l-dvb tree
and commit fee529df76ff ("ARM: shmobile: r8a7779: cleanup registration of
usb phy") from the arm-soc tree.

I fixed it up (see below) and can carry the fix as necessary (no action
is required).

-- 
Cheers,
Stephen Rothwell                    sfr at canb.auug.org.au

diff --cc arch/arm/mach-shmobile/include/mach/r8a7779.h
index 6d2b641,f08d6ec..0000000
--- a/arch/arm/mach-shmobile/include/mach/r8a7779.h
+++ b/arch/arm/mach-shmobile/include/mach/r8a7779.h
@@@ -4,8 -4,6 +4,7 @@@
  #include <linux/sh_clk.h>
  #include <linux/pm_domain.h>
  #include <linux/sh_eth.h>
- #include <linux/platform_data/usb-rcar-phy.h>
 +#include <linux/platform_data/camera-rcar.h>
  
  struct platform_device;
  
@@@ -35,9 -32,6 +33,8 @@@ extern void r8a7779_add_early_devices(v
  extern void r8a7779_add_standard_devices(void);
  extern void r8a7779_add_standard_devices_dt(void);
  extern void r8a7779_add_ether_device(struct sh_eth_plat_data *pdata);
- extern void r8a7779_add_usb_phy_device(struct rcar_phy_platform_data *pdata);
 +extern void r8a7779_add_vin_device(int idx,
 +				   struct rcar_vin_platform_data *pdata);
  extern void r8a7779_init_late(void);
  extern void r8a7779_clock_init(void);
  extern void r8a7779_pinmux_init(void);
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 836 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130829/34b200e4/attachment.sig>
