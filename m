From: sfr@canb.auug.org.au (Stephen Rothwell)
Date: Mon, 26 Nov 2012 21:01:44 +1100
Subject: linux-next: manual merge of the arm-soc tree with the thermal tree
Message-ID: <20121126210144.d753c9f29a94d0816e8d3709@canb.auug.org.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi all,

Today's linux-next merge of the arm-soc tree got a conflict in
arch/arm/boot/dts/dbx5x0.dtsi between commit dc1956b5f84d ("Thermal: Add
ST-Ericsson DB8500 thermal properties and platform data") from the
thermal tree and commit 0563f638f052 ("ARM: ux500: Add node for the MMC
GPIO regulator") from the arm-soc tree.

I fixed it up (see below) and can carry the fix as necessary (no action
is required).

-- 
Cheers,
Stephen Rothwell                    sfr at canb.auug.org.au

diff --cc arch/arm/boot/dts/dbx5x0.dtsi
index 487b705,7ce45fc..0000000
--- a/arch/arm/boot/dts/dbx5x0.dtsi
+++ b/arch/arm/boot/dts/dbx5x0.dtsi
@@@ -695,10 -630,18 +664,23 @@@
  			status = "disabled";
  		};
  
 +		cpufreq-cooling {
 +			compatible = "stericsson,db8500-cpufreq-cooling";
 +			status = "disabled";
 +		 };
 +
+ 		vmmci: regulator-gpio {
+ 			compatible = "regulator-gpio";
+ 
+ 			regulator-min-microvolt = <1800000>;
+ 			regulator-max-microvolt = <2600000>;
+ 			regulator-name = "mmci-reg";
+ 			regulator-type = "voltage";
+ 
+ 			gpios = <&tc3589x_gpio 18 0x4>;
+ 			gpio-enable = <&tc3589x_gpio 17 0x4>;
+ 			states = <1800000 0x1
+ 				  2900000 0x0>;
+ 		};
  	};
  };
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 836 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20121126/a9027509/attachment.sig>
