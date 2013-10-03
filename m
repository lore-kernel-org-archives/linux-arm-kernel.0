From: jason@lakedaemon.net (Jason Cooper)
Date: Thu, 3 Oct 2013 08:57:28 -0400
Subject: [PATCH] arm: kirkwood: ib62x0: add u-boot environment partition
In-Reply-To: <1380769605-2067-1-git-send-email-luka@openwrt.org>
References: <1380769605-2067-1-git-send-email-luka@openwrt.org>
Message-ID: <20131003125728.GW31178@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Luka,

On Thu, Oct 03, 2013 at 05:06:45AM +0200, Luka Perkov wrote:
> Also, add some trivial cosmetic fixes.
> 
> Signed-off-by: Luka Perkov <luka@openwrt.org>
> ---
>  arch/arm/boot/dts/kirkwood-ib62x0.dts | 16 +++++++++++-----
>  1 file changed, 11 insertions(+), 5 deletions(-)

Thanks for the patch, but don't forget to Cc the maintainers.  I almost
missed this one.  ;-)

I reworded this slightly, s/arm/ARM/, s/cosmetic fixes/whitespace
cleanup/.  Also, it conflicted with:

  7045ff5 ARM: kirkwood: Move the nand node under the mbus node

currently in mvebu/dt, so I've attached the final version below.

Applied to mvebu/dt

thx,

Jason.

--->8----------------
commit 148c274ea64448673c4294e32cfd0d60b524ca9a
Author: Luka Perkov <luka@openwrt.org>
Date:   Thu Oct 3 05:06:45 2013 +0200

    ARM: kirkwood: ib62x0: add u-boot environment partition
    
    Also, add some trivial whitespace cleanup.
    
    Signed-off-by: Luka Perkov <luka@openwrt.org>
    Signed-off-by: Jason Cooper <jason@lakedaemon.net>

diff --git a/arch/arm/boot/dts/kirkwood-ib62x0.dts b/arch/arm/boot/dts/kirkwood-ib62x0.dts
index 066f40f..c5fb02f 100644
--- a/arch/arm/boot/dts/kirkwood-ib62x0.dts
+++ b/arch/arm/boot/dts/kirkwood-ib62x0.dts
@@ -5,7 +5,7 @@
 
 / {
 	model = "RaidSonic ICY BOX IB-NAS62x0 (Rev B)";
-	compatible = "raidsonic,ib-nas6210-b", "raidsonic,ib-nas6220-b", "raidsonic,ib-nas6210", "raidsonic,ib-nas6220", "raidsonic,ib-nas62x0",  "marvell,kirkwood-88f6281", "marvell,kirkwood";
+	compatible = "raidsonic,ib-nas6210-b", "raidsonic,ib-nas6220-b", "raidsonic,ib-nas6210", "raidsonic,ib-nas6220", "raidsonic,ib-nas62x0", "marvell,kirkwood-88f6281", "marvell,kirkwood";
 
 	memory {
 		device_type = "memory";
@@ -43,6 +43,7 @@
 				marvell,function = "gpio";
 			};
 		};
+
 		serial at 12000 {
 			status = "okay";
 		};
@@ -71,6 +72,7 @@
 			gpios = <&gpio0 28 1>;
 		};
 	};
+
 	gpio-leds {
 		compatible = "gpio-leds";
 		pinctrl-0 = <&pmx_led_os_red &pmx_led_os_green
@@ -91,14 +93,13 @@
 			gpios = <&gpio0 27 0>;
 		};
 	};
+
 	gpio_poweroff {
 		compatible = "gpio-poweroff";
 		pinctrl-0 = <&pmx_power_off>;
 		pinctrl-names = "default";
 		gpios = <&gpio0 24 0>;
 	};
-
-
 };
 
 &nand {
@@ -108,7 +109,12 @@
 
 	partition at 0 {
 		label = "u-boot";
-		reg = <0x0000000 0x100000>;
+		reg = <0x0000000 0xe0000>;
+	};
+
+	partition at e0000 {
+		label = "u-boot environment";
+		reg = <0xe0000 0x100000>;
 	};
 
 	partition at 100000 {
@@ -134,6 +140,7 @@
 
 &eth0 {
 	status = "okay";
+
 	ethernet0-port at 0 {
 		phy-handle = <&ethphy0>;
 	};
