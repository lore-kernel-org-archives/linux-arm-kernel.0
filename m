From: sfr@canb.auug.org.au (Stephen Rothwell)
Date: Fri, 17 Jan 2014 14:11:46 +1100
Subject: linux-next: manual merge of the devicetree tree with the arm-soc tree
Message-ID: <20140117141146.8c6338ce852268d2f5ac22e7@canb.auug.org.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Grant,

Today's linux-next merge of the devicetree tree got a conflict in
arch/arm/boot/dts/kirkwood-netgear_readynas_duo_v2.dts between commit
261e7735d0ed ("ARM: kirkwood: NETGEAR ReadyNAS Duo v2 .dts cleanup") from
the arm-soc tree and commit 40aad3c1a9b6 ("dt/bindings: Remove all
references to device_type "ethernet-phy"") from the devicetree tree.

I fixed it up (see below) and can carry the fix as necessary (no action
is required).

-- 
Cheers,
Stephen Rothwell                    sfr at canb.auug.org.au

diff --cc arch/arm/boot/dts/kirkwood-netgear_readynas_duo_v2.dts
index 4d2a8db9ab77,00c0669b1b8c..000000000000
--- a/arch/arm/boot/dts/kirkwood-netgear_readynas_duo_v2.dts
+++ b/arch/arm/boot/dts/kirkwood-netgear_readynas_duo_v2.dts
@@@ -241,8 -210,7 +241,7 @@@
  &mdio {
  	status = "okay";
  
 -	ethphy0: ethernet-phy at 0 {
 +	ethphy0: ethernet-phy at 0 { /* Marvell 88E1318 */
- 		device_type = "ethernet-phy";
  		reg = <0>;
  	};
  };
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 836 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140117/0dc6a61b/attachment.sig>
