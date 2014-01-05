From: sfr@canb.auug.org.au (Stephen Rothwell)
Date: Mon, 6 Jan 2014 10:38:50 +1100
Subject: linux-next: manual merge of the imx-mxs tree with the arm-soc tree
Message-ID: <20140106103850.3c60fa973ae9355c0a3c2449@canb.auug.org.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Shawn,

Today's linux-next merge of the imx-mxs tree got a conflict in
arch/arm/boot/dts/imx27-phytec-phycore-som.dtsi between commit
8f568b496dd9 ("ARM: imx: Explicitly pass the active level of the PHY
reset") from the arm-soc tree and commit 208d5b9c2c71 ("ARM: dts: i.MX27
boards: Switch to use standard GPIO and IRQ flags definitions") from the
imx-mxs tree.

I fixed it up (I randomly chose to go with the latter - please get
together and decide which is right) and can carry the fix as necessary
(no action is required).

At the time of those commits, the file was called
arch/arm/boot/dts/imx27-phytec-phycore-som.dts (it is renamed by commit
c7914d9b5565 ("ARM: dts: imx27-phytec-phycore-som: Rename file to .dtsi"
from the imx-mxs tree) and we we ended up with (cut and paste damaged):

&fec {
	phy-mode = "mii";
	phy-reset-gpios = <&gpio3 30 GPIO_ACTIVE_HIGH>;
	phy-supply = <&reg_3v3>;
	pinctrl-names = "default";
	pinctrl-0 = <&pinctrl_fec1>;
	status = "okay";
};

-- 
Cheers,
Stephen Rothwell <sfr@canb.auug.org.au>
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 836 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140106/39e455ff/attachment.sig>
