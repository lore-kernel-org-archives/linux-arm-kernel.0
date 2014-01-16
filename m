From: sfr@canb.auug.org.au (Stephen Rothwell)
Date: Thu, 16 Jan 2014 11:48:31 +1100
Subject: linux-next: manual merge of the libata tree with the arm-soc tree
Message-ID: <20140116114831.50261e22b6fb25aac2004b43@canb.auug.org.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Tejun,

Today's linux-next merge of the libata tree got a conflict in
arch/arm/boot/dts/armada-370-xp.dtsi between commit a095b1c78a35 ("ARM:
mvebu: sort DT nodes by address") from the arm-soc tree and commit
a96cc303e42a ("ARM: mvebu: update the SATA compatible string for Armada
370/XP") from the libata tree.

I fixed it up (see below) and can carry the fix as necessary (no action
is required).

-- 
Cheers,
Stephen Rothwell                    sfr at canb.auug.org.au

diff --cc arch/arm/boot/dts/armada-370-xp.dtsi
index b6b253924893,df141a1d6448..000000000000
--- a/arch/arm/boot/dts/armada-370-xp.dtsi
+++ b/arch/arm/boot/dts/armada-370-xp.dtsi
@@@ -236,12 -183,13 +236,12 @@@
  				status = "disabled";
  			};
  
 -			i2c0: i2c at 11000 {
 -				compatible = "marvell,mv64xxx-i2c";
 -				#address-cells = <1>;
 -				#size-cells = <0>;
 -				interrupts = <31>;
 -				timeout-ms = <1000>;
 -				clocks = <&coreclk 0>;
 +			sata at a0000 {
- 				compatible = "marvell,orion-sata";
++				compatible = "marvell,armada-370-sata";
 +				reg = <0xa0000 0x5000>;
 +				interrupts = <55>;
 +				clocks = <&gateclk 15>, <&gateclk 30>;
 +				clock-names = "0", "1";
  				status = "disabled";
  			};
  
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 836 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140116/c343270b/attachment.sig>
