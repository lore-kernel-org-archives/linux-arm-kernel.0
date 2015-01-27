From: sfr@canb.auug.org.au (Stephen Rothwell)
Date: Tue, 27 Jan 2015 13:04:37 +1100
Subject: linux-next: manual merge of the net-next tree with the arm-soc tree
Message-ID: <20150127130437.3cd05af9@canb.auug.org.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi all,

Today's linux-next merge of the net-next tree got a conflict in
arch/arm/boot/dts/rk3288.dtsi between commit eecfe981cecd ("ARM: dts:
rockchip: add RK3288 suspend support") from the arm-soc tree and commit
3d3fb74afc9b ("ARM: dts: rockchip: add gmac info for rk3288") from the
net-next tree.

I fixed it up (see below) and can carry the fix as necessary (no action
is required).

-- 
Cheers,
Stephen Rothwell                    sfr at canb.auug.org.au

diff --cc arch/arm/boot/dts/rk3288.dtsi
index 2a878a35facc,910dcad2088a..000000000000
--- a/arch/arm/boot/dts/rk3288.dtsi
+++ b/arch/arm/boot/dts/rk3288.dtsi
@@@ -734,24 -741,11 +750,29 @@@
  			bias-disable;
  		};
  
+ 		pcfg_pull_none_12ma: pcfg-pull-none-12ma {
+ 			bias-disable;
+ 			drive-strength = <12>;
+ 		};
+ 
 +		sleep {
 +			global_pwroff: global-pwroff {
 +				rockchip,pins = <0 0 RK_FUNC_1 &pcfg_pull_none>;
 +			};
 +
 +			ddrio_pwroff: ddrio-pwroff {
 +				rockchip,pins = <0 1 RK_FUNC_1 &pcfg_pull_none>;
 +			};
 +
 +			ddr0_retention: ddr0-retention {
 +				rockchip,pins = <0 2 RK_FUNC_1 &pcfg_pull_up>;
 +			};
 +
 +			ddr1_retention: ddr1-retention {
 +				rockchip,pins = <0 3 RK_FUNC_1 &pcfg_pull_up>;
 +			};
 +		};
 +
  		i2c0 {
  			i2c0_xfer: i2c0-xfer {
  				rockchip,pins = <0 15 RK_FUNC_1 &pcfg_pull_none>,
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 819 bytes
Desc: OpenPGP digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150127/039daea7/attachment.sig>
