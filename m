From: heiko@sntech.de (Heiko =?ISO-8859-1?Q?St=FCbner?=)
Date: Wed, 27 Aug 2014 00:05:50 +0200
Subject: [PATCH RESEND] MAINTAINERS: catch special Rockchip code locations
Message-ID: <3644024.F4LLe7dWA4@diego>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add some more locations that aren't catched by the general wildcard.
This includes the devicetree files, clock directory, rk3x i2c driver,
everything in a third layer under drivers like iio/adc/rockchip_saradc.c
and the i2s driver.

Signed-off-by: Heiko Stuebner <heiko@sntech.de>
---
Main reason behind this, is that I only accidentially stumbled over the
clock api refactoring series [0] from Toneu Vizoso, wheras with the
better matching it should've been automatic.

[0] https://lkml.org/lkml/2014/8/18/481

This could either go into 3.17 as fix, or could be queued for 3.18

[resent, as I forgot the linux-rockchip list, sorry for the noise]

 MAINTAINERS | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index c2ecffb..2f66c46 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1279,8 +1279,13 @@ M:	Heiko Stuebner <heiko@sntech.de>
 L:	linux-arm-kernel at lists.infradead.org (moderated for non-subscribers)
 L:	linux-rockchip at lists.infradead.org
 S:	Maintained
+F:	arch/arm/boot/dts/rk3*
 F:	arch/arm/mach-rockchip/
+F:	drivers/clk/rockchip/
+F:	drivers/i2c/busses/i2c-rk3x.c
 F:	drivers/*/*rockchip*
+F:	drivers/*/*/*rockchip*
+F:	sound/soc/rockchip/
 
 ARM/SAMSUNG ARM ARCHITECTURES
 M:	Ben Dooks <ben-linux@fluff.org>
-- 
2.0.1
