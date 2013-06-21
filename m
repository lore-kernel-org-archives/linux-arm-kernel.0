From: sfr@canb.auug.org.au (Stephen Rothwell)
Date: Fri, 21 Jun 2013 17:36:18 +1000
Subject: linux-next: manual merge of the akpm tree with the arm-soc tree
Message-ID: <20130621173618.5e86932305b15b0fe4af6b8b@canb.auug.org.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Andrew,

Today's linux-next merge of the akpm tree got a conflict in
arch/arm/mach-davinci/include/mach/tnetv107x.h between commit
b464e3cb2945 ("ARM: davinci: remove __init atrribute from function
declaration") from the arm-soc tree and commit "reboot: arm: change
reboot_mode to use enum reboot_mode" from the akpm tree.

I fixed it up (see below) and can carry the fix as necessary (no action
is required).

-- 
Cheers,
Stephen Rothwell                    sfr at canb.auug.org.au

diff --cc arch/arm/mach-davinci/include/mach/tnetv107x.h
index 366e975,bc9479d..0000000
--- a/arch/arm/mach-davinci/include/mach/tnetv107x.h
+++ b/arch/arm/mach-davinci/include/mach/tnetv107x.h
@@@ -51,10 -52,10 +52,10 @@@ struct tnetv107x_device_info 
  extern struct platform_device tnetv107x_wdt_device;
  extern struct platform_device tnetv107x_serial_device;
  
 -extern void __init tnetv107x_init(void);
 -extern void __init tnetv107x_devices_init(struct tnetv107x_device_info *);
 -extern void __init tnetv107x_irq_init(void);
 +extern void tnetv107x_init(void);
 +extern void tnetv107x_devices_init(struct tnetv107x_device_info *);
 +extern void tnetv107x_irq_init(void);
- void tnetv107x_restart(char mode, const char *cmd);
+ void tnetv107x_restart(enum reboot_mode mode, const char *cmd);
  
  #endif
  
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 836 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130621/0840a9fa/attachment.sig>
