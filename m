From: sfr@canb.auug.org.au (Stephen Rothwell)
Date: Mon, 26 Nov 2012 20:56:15 +1100
Subject: linux-next: manual merge of the arm-soc tree with the arm-soc and
 pincrtl trees
Message-ID: <20121126205615.cda9cfaa998ce6972937d4aa@canb.auug.org.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi all,

Today's linux-next merge of the arm-soc tree got a conflict in
arch/arm/boot/dts/at91sam9g45.dtsi between various commits from the
arm-soc and pincrtl trees and commit 7492e7ca0f95 ("ARM: at91/dts: add
at91sam9_wdt driver to at91sam926x, at91sam9g45") from the arm-soc tree.

I fixed it up (see below) and can carry the fix as necessary (no action
is required).

-- 
Cheers,
Stephen Rothwell                    sfr at canb.auug.org.au

diff --cc arch/arm/boot/dts/at91sam9g45.dtsi
index 4212991,a98c00a..0000000
--- a/arch/arm/boot/dts/at91sam9g45.dtsi
+++ b/arch/arm/boot/dts/at91sam9g45.dtsi
@@@ -472,22 -263,10 +472,28 @@@
  				};
  			};
  
 +			mmc0: mmc at fff80000 {
 +				compatible = "atmel,hsmci";
 +				reg = <0xfff80000 0x600>;
 +				interrupts = <11 4 0>;
 +				#address-cells = <1>;
 +				#size-cells = <0>;
 +				status = "disabled";
 +			};
 +
 +			mmc1: mmc at fffd0000 {
 +				compatible = "atmel,hsmci";
 +				reg = <0xfffd0000 0x600>;
 +				interrupts = <29 4 0>;
 +				#address-cells = <1>;
 +				#size-cells = <0>;
 +				status = "disabled";
++			};
++
+ 			watchdog at fffffd40 {
+ 				compatible = "atmel,at91sam9260-wdt";
+ 				reg = <0xfffffd40 0x10>;
+ 				status = "disabled";
  			};
  		};
  
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 836 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20121126/78ba3b35/attachment.sig>
