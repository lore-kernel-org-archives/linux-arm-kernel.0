From: sfr@canb.auug.org.au (Stephen Rothwell)
Date: Wed, 14 Mar 2012 17:06:28 +1100
Subject: linux-next: manual merge of the arm-soc tree with the sound-asoc tree
Message-ID: <20120314170628.4b0b5688441624a7a080d7cd@canb.auug.org.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi all,

Today's linux-next merge of the arm-soc tree got a conflict in
arch/arm/mach-imx/mach-imx27_visstrim_m10.c between commit 5ec65ee589fd
("ASoC: mx27vis-aic32x4: Convert it to platform driver") from the
sound-asoc tree and commit f52f5a5503b5 ("i.MX27: visstrim_m10: Add video
support") from the arm-soc tree.

I fixed it up (see below) and can carry the fix as necessary.
-- 
Cheers,
Stephen Rothwell                    sfr at canb.auug.org.au

diff --cc arch/arm/mach-imx/mach-imx27_visstrim_m10.c
index 428459f,0a1643c..0000000
--- a/arch/arm/mach-imx/mach-imx27_visstrim_m10.c
+++ b/arch/arm/mach-imx/mach-imx27_visstrim_m10.c
@@@ -263,7 -393,10 +393,11 @@@ static void __init visstrim_m10_board_i
  	imx27_add_fec(NULL);
  	imx_add_gpio_keys(&visstrim_gpio_keys_platform_data);
  	platform_add_devices(platform_devices, ARRAY_SIZE(platform_devices));
+ 	platform_device_register_resndata(NULL, "soc-camera-pdrv", 0, NULL, 0,
+ 				      &iclink_tvp5150, sizeof(iclink_tvp5150));
+ 	gpio_led_register_device(0, &visstrim_m10_led_data);
+ 	visstrim_camera_init();
 +	imx_add_platform_device("mx27vis", 0, NULL, 0, NULL, 0);
  }
  
  static void __init visstrim_m10_timer_init(void)
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 836 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120314/01e70bc7/attachment.sig>
