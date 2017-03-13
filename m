From: rafal@milecki.pl (=?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?=)
Date: Mon, 13 Mar 2017 19:48:26 +0100
Subject: [PATCH] ARM: dts: BCM5301X: Add support for TP-LINK Archer C5 V2
In-Reply-To: <20170312171032.GK15842@lunn.ch>
References: <20170311121453.18534-1-zajec5@gmail.com>
 <20170312171032.GK15842@lunn.ch>
Message-ID: <437d898d-b0f4-a4b5-cb51-8ea88ba7a35a@milecki.pl>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 03/12/2017 06:10 PM, Andrew Lunn wrote:
>> +	chosen {
>> +		bootargs = "console=ttyS0,115200 earlycon";
>
> Using bootargs to pass the serial settings has been deprecated for a
> while. Please use stdout-path instead.

I tried following patch with my SR400ac (I put Archer C5 aside for now).

While serial console seems to work:
1) I keep seeing boot log messages after:
[    0.402309] 18000300.serial: ttyS0 at MMIO 0x18000300 (irq = 18, base_baud = 6250000) is a 16550
2) Typed chars come back to my serial console

I can't log in. I press ENTER but I'm not getting prompt for entering user name.

Do you know why this change could have such an effect?


diff --git a/arch/arm/boot/dts/bcm4708-smartrg-sr400ac.dts b/arch/arm/boot/dts/bcm4708-smartrg-sr400ac.dts
index 36b628b..a5442a9 100644
--- a/arch/arm/boot/dts/bcm4708-smartrg-sr400ac.dts
+++ b/arch/arm/boot/dts/bcm4708-smartrg-sr400ac.dts
@@ -17,7 +17,7 @@
  	model = "SmartRG SR400ac";

  	chosen {
-		bootargs = "console=ttyS0,115200 earlycon";
+		bootargs = "earlycon";
  	};

  	memory {
diff --git a/arch/arm/boot/dts/bcm5301x.dtsi b/arch/arm/boot/dts/bcm5301x.dtsi
index 4fbb089..66c6d2a 100644
--- a/arch/arm/boot/dts/bcm5301x.dtsi
+++ b/arch/arm/boot/dts/bcm5301x.dtsi
@@ -19,7 +19,7 @@
  	interrupt-parent = <&gic>;

  	chosen {
-		stdout-path = &uart0;
+		stdout-path = "/chipcommonA/serial at 0300:115200";
  	};

  	chipcommonA {
