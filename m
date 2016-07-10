From: andrew@lunn.ch (Andrew Lunn)
Date: Sun, 10 Jul 2016 22:37:51 +0200
Subject: [PATCH] ARM: dts: armada-388-clearfog: remove duplicate mdio entry
In-Reply-To: <E1bMGdu-00005c-Dy@rmk-PC.armlinux.org.uk>
References: <E1bMGdu-00005c-Dy@rmk-PC.armlinux.org.uk>
Message-ID: <20160710203751.GB26397@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Jul 10, 2016 at 04:27:38PM +0100, Russell King wrote:
> The clearfog DTS should not be defining the on-board phy, this device
> is located on the microsom.  Remove the duplicated definition.

Hi Russell

While reviewing this patch i noticed that the microsom .dtsi file has

                        pinctrl at 18000 {
                                microsom_phy_clk_pins: microsom-phy-clk-pins {
                                        marvell,pins = "mpp45";
                                        marvell,function = "ref";
                                };
                        };

The armada-38x.dtsi has

                                ref_clk0_pins: ref-clk-pins-0 {
                                        marvell,pins = "mpp45";
                                        marvell,function = "ref";
                                };

which you could reference rather then defining it yourself.

      Andrew
