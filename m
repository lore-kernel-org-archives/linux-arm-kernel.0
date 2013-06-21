From: sfr@canb.auug.org.au (Stephen Rothwell)
Date: Fri, 21 Jun 2013 15:54:08 +1000
Subject: linux-next: manual merge of the arm-soc tree with the mfd tree
Message-ID: <20130621155408.7e4a4c891ff4d74627b57a45@canb.auug.org.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi all,

Today's linux-next merge of the arm-soc tree got a conflict in
arch/arm/boot/dts/am33xx.dtsi between commit a82279dd6d3e ("arm: am33xx:
add TSC/ADC mfd device support") from the mfd tree and commit
15e8246bd61b ("ARM: dts: AM33XX: Add ELM node") from the arm-soc tree.

I fixed it up (see below) and can carry the fix as necessary (no action
is required).

-- 
Cheers,
Stephen Rothwell                    sfr at canb.auug.org.au

diff --cc arch/arm/boot/dts/am33xx.dtsi
index 37ef320,0d4df90..0000000
--- a/arch/arm/boot/dts/am33xx.dtsi
+++ b/arch/arm/boot/dts/am33xx.dtsi
@@@ -404,24 -494,14 +494,32 @@@
  			ti,hwmods = "wkup_m3";
  		};
  
 +		tscadc: tscadc at 44e0d000 {
 +			compatible = "ti,am3359-tscadc";
 +			reg = <0x44e0d000 0x1000>;
 +			interrupt-parent = <&intc>;
 +			interrupts = <16>;
 +			ti,hwmods = "adc_tsc";
 +			status = "disabled";
 +
 +			tsc {
 +				compatible = "ti,am3359-tsc";
 +			};
 +			am335x_adc: adc {
 +				#io-channel-cells = <1>;
 +				compatible = "ti,am3359-adc";
 +			};
 +
 +		};
 +
+ 		elm: elm at 48080000 {
+ 			compatible = "ti,am3352-elm";
+ 			reg = <0x48080000 0x2000>;
+ 			interrupts = <4>;
+ 			ti,hwmods = "elm";
+ 			status = "disabled";
+ 		};
+ 
  		gpmc: gpmc at 50000000 {
  			compatible = "ti,am3352-gpmc";
  			ti,hwmods = "gpmc";
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 836 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130621/c7462e4f/attachment.sig>
