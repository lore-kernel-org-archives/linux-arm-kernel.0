From: sfr@canb.auug.org.au (Stephen Rothwell)
Date: Fri, 5 Dec 2014 14:03:13 +1100
Subject: linux-next: manual merge of the v4l-dvb tree with the arm-soc tree
Message-ID: <20141205140313.7d0242a6@canb.auug.org.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Mauro,

Today's linux-next merge of the v4l-dvb tree got a conflict in
arch/arm/boot/dts/meson.dtsi between commit 8fba96fac1c4 ("ARM: dts:
meson: add I2C controller nodes") from the arm-soc tree and commit
ac61e3787315 ("[media] ARM: dts: meson: add IR receiver node") from the
v4l-dvb tree.

I fixed it up (see below) and can carry the fix as necessary (no action
is required).

-- 
Cheers,
Stephen Rothwell                    sfr at canb.auug.org.au

diff --cc arch/arm/boot/dts/meson.dtsi
index 03bcff87bd27,6a37f15e8627..000000000000
--- a/arch/arm/boot/dts/meson.dtsi
+++ b/arch/arm/boot/dts/meson.dtsi
@@@ -114,34 -107,11 +114,41 @@@
  			status = "disabled";
  		};
  
 +		i2c_AO: i2c at c8100500 {
 +			compatible = "amlogic,meson6-i2c";
 +			reg = <0xc8100500 0x20>;
 +			interrupts = <0 92 1>;
 +			clocks = <&clk81>;
 +			#address-cells = <1>;
 +			#size-cells = <0>;
 +			status = "disabled";
 +		};
 +
 +		i2c_A: i2c at c1108500 {
 +			compatible = "amlogic,meson6-i2c";
 +			reg = <0xc1108500 0x20>;
 +			interrupts = <0 21 1>;
 +			clocks = <&clk81>;
 +			#address-cells = <1>;
 +			#size-cells = <0>;
 +			status = "disabled";
 +		};
 +
 +		i2c_B: i2c at c11087c0 {
 +			compatible = "amlogic,meson6-i2c";
 +			reg = <0xc11087c0 0x20>;
 +			interrupts = <0 128 1>;
 +			clocks = <&clk81>;
 +			#address-cells = <1>;
 +			#size-cells = <0>;
 +			status = "disabled";
 +		};
++
+ 		ir_receiver: ir-receiver at c8100480 {
+ 			compatible= "amlogic,meson6-ir";
+ 			reg = <0xc8100480 0x20>;
+ 			interrupts = <0 15 1>;
+ 			status = "disabled";
+ 		};
  	};
  }; /* end of / */
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 819 bytes
Desc: OpenPGP digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20141205/9726ffdc/attachment.sig>
