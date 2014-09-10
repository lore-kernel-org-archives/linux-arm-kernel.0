From: sfr@canb.auug.org.au (Stephen Rothwell)
Date: Wed, 10 Sep 2014 14:48:37 +1000
Subject: linux-next: manual merge of the net-next tree with the arm-soc tree
Message-ID: <20140910144837.5e3089e1@canb.auug.org.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi all,

Today's linux-next merge of the net-next tree got a conflict in
arch/arm/boot/dts/rk3188-radxarock.dts between commit 4721ab855d1a
("ARM: dts: rockchip: add hym8563 rtc to Radxa Rock board") from the
arm-soc tree and commit c6ec956b73db ("ARM: dts: Enable emac node on
the rk3188-radxarock boards") from the net-next tree.

I fixed it up (see below) and can carry the fix as necessary (no action
is required).

-- 
Cheers,
Stephen Rothwell                    sfr at canb.auug.org.au

diff --cc arch/arm/boot/dts/rk3188-radxarock.dts
index 2c2313ff67c6,d63d685ea6cc..000000000000
--- a/arch/arm/boot/dts/rk3188-radxarock.dts
+++ b/arch/arm/boot/dts/rk3188-radxarock.dts
@@@ -209,12 -217,12 +225,18 @@@
  		};
  	};
  
 +	hym8563 {
 +		rtc_int: rtc-int {
 +			rockchip,pins = <RK_GPIO0 0 RK_FUNC_GPIO &pcfg_pull_up>;
 +		};
 +	};
 +
+ 	lan8720a  {
+ 		phy_int: phy-int {
+ 			rockchip,pins = <RK_GPIO3 26 RK_FUNC_GPIO &pcfg_pull_up>;
+ 		};
+ 	};
+ 
  	ir-receiver {
  		ir_recv_pin: ir-recv-pin {
  			rockchip,pins = <RK_GPIO0 10 RK_FUNC_GPIO &pcfg_pull_none>;
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140910/3cb62171/attachment.sig>
