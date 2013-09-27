From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 27 Sep 2013 10:49:02 +0100
Subject: device tree binding documentation outdated
In-Reply-To: <20130926195158.GS12758@n2100.arm.linux.org.uk>
References: <20130926195158.GS12758@n2100.arm.linux.org.uk>
Message-ID: <20130927094902.GX12758@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Here's another instance:

Documentation/devicetree/bindings/net/fsl-fec.txt:

Required properties:
- phy-mode : String, operation mode of the PHY interface.
  Supported values are: "mii", "gmii", "sgmii", "tbi", "rmii",
  "rgmii", "rgmii-id", "rgmii-rxid", "rgmii-txid", "rtbi", "smii".

Is this really required?  Maybe someone can point to where the code
makes use of this, because I'm damned if I can find it:

$ grep phy-mode drivers/net/ include/ net/ -r
drivers/net/ethernet/marvell/mvneta.c:              dev_err(&pdev->dev, "incorrect phy-mode\n");
drivers/net/ethernet/nxp/lpc_eth.c:                                            phy-mode", NULL);

"local-mac-address" in the optional properties also falls into this
category: only a small handful of network drivers make use of this,
and fec is not one of them.

What's the use of documentation if its inaccurate.
