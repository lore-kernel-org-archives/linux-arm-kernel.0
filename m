From: sfr@canb.auug.org.au (Stephen Rothwell)
Date: Fri, 21 Jun 2013 15:49:25 +1000
Subject: linux-next: manual merge of the arm-soc tree with the net-next tree
Message-ID: <20130621154925.13c957ee77c5c62e540d7cfc@canb.auug.org.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi all,

Today's linux-next merge of the arm-soc tree got a conflict in
arch/arm/boot/dts/am335x-evmsk.dts between commit f6655d697b85 ("ARM:
dts: AM33XX: Add CPSW phy_id device tree data to am335x-evmsk") from the
net-next tree and commit 94a924ca61f0 ("ARM: dts: AM33XX: Add pinmux
configuration for CPSW to EVMsk") from the arm-soc tree.

I fixed it up (see below) and can carry the fix as necessary (no action
is required).

-- 
Cheers,
Stephen Rothwell                    sfr at canb.auug.org.au

diff --cc arch/arm/boot/dts/am335x-evmsk.dts
index 4297899,9e00eef..0000000
--- a/arch/arm/boot/dts/am335x-evmsk.dts
+++ b/arch/arm/boot/dts/am335x-evmsk.dts
@@@ -249,12 -381,14 +381,24 @@@
  	};
  };
  
 +&cpsw_emac0 {
 +	phy_id = <&davinci_mdio>, <0>;
 +	phy-mode = "rgmii-txid";
 +};
 +
 +&cpsw_emac1 {
 +	phy_id = <&davinci_mdio>, <1>;
 +	phy-mode = "rgmii-txid";
 +};
++
+ &mac {
+ 	pinctrl-names = "default", "sleep";
+ 	pinctrl-0 = <&cpsw_default>;
+ 	pinctrl-1 = <&cpsw_sleep>;
+ };
+ 
+ &davinci_mdio {
+ 	pinctrl-names = "default", "sleep";
+ 	pinctrl-0 = <&davinci_mdio_default>;
+ 	pinctrl-1 = <&davinci_mdio_sleep>;
+ };
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 836 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130621/1de69559/attachment-0001.sig>
