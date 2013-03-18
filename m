From: sfr@canb.auug.org.au (Stephen Rothwell)
Date: Mon, 18 Mar 2013 14:49:48 +1100
Subject: linux-next: manual merge of the arm-soc tree with Linus' tree
Message-ID: <20130318144948.1d2c83fb633404d206f3ea0a@canb.auug.org.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi all,

Today's linux-next merge of the arm-soc tree got a conflict in
arch/arm/boot/dts/snowball.dts between commit d52701d39e37 ("mfd: ab8500:
Kill "reg" property from binding") from Linus' tree and commit
924e82dacab9 ("ARM: ux500: allow Snowball access to the AB8500 GPIO
pins") from the arm-soc tree.

I fixed it up (see below) and can carry the fix as necessary (no action
is required).

-- 
Cheers,
Stephen Rothwell                    sfr at canb.auug.org.au

diff --cc arch/arm/boot/dts/snowball.dts
index d3ec32f,b095e85..0000000
--- a/arch/arm/boot/dts/snowball.dts
+++ b/arch/arm/boot/dts/snowball.dts
@@@ -298,7 -298,11 +298,11 @@@
  				};
  			};
  
 -			ab8500 at 5 {
 +			ab8500 {
+ 				ab8500-gpio {
+ 					compatible = "stericsson,ab8500-gpio";
+ 				};
+ 
  				ab8500-regulators {
  					ab8500_ldo_aux1_reg: ab8500_ldo_aux1 {
  						regulator-name = "V-DISPLAY";
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 836 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130318/33b843f4/attachment.sig>
