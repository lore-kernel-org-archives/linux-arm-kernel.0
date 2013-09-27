From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Fri, 27 Sep 2013 14:08:01 +0200
Subject: device tree binding documentation outdated
In-Reply-To: <20130927094902.GX12758@n2100.arm.linux.org.uk>
References: <20130926195158.GS12758@n2100.arm.linux.org.uk>
 <20130927094902.GX12758@n2100.arm.linux.org.uk>
Message-ID: <20130927120801.GU30088@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Sep 27, 2013 at 10:49:02AM +0100, Russell King - ARM Linux wrote:
> Here's another instance:
> 
> Documentation/devicetree/bindings/net/fsl-fec.txt:
> 
> Required properties:
> - phy-mode : String, operation mode of the PHY interface.
>   Supported values are: "mii", "gmii", "sgmii", "tbi", "rmii",
>   "rgmii", "rgmii-id", "rgmii-rxid", "rgmii-txid", "rtbi", "smii".
> 
> Is this really required?  Maybe someone can point to where the code
> makes use of this, because I'm damned if I can find it:
> 
> $ grep phy-mode drivers/net/ include/ net/ -r
> drivers/net/ethernet/marvell/mvneta.c:              dev_err(&pdev->dev, "incorrect phy-mode\n");
> drivers/net/ethernet/nxp/lpc_eth.c:                                            phy-mode", NULL);

See of_get_phy_mode() implemented in drivers/net/of_net.c and used in
the FEC driver.

> 
> "local-mac-address" in the optional properties also falls into this
> category: only a small handful of network drivers make use of this,
> and fec is not one of them.

of_get_mac_address(), also in drivers/net/of_net.c

Sascha

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
