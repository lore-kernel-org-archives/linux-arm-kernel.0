From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Thu, 12 Sep 2013 12:41:26 +0200
Subject: [PATCH v3 3/3] PCI: imx6: Add support for i.MX6 PCIe controller
In-Reply-To: <65E0D2C79B2B43D28CC77454F44ECCFA@kosagi.com>
References: <1378958611-4274-1-git-send-email-xobs@kosagi.com>
 <1378958611-4274-4-git-send-email-xobs@kosagi.com>
 <20130912062859.GM30088@pengutronix.de>
 <6FF3113C3FCC43A4A0D711C8656A4C03@kosagi.com>
 <20130912070131.GO30088@pengutronix.de>
 <65E0D2C79B2B43D28CC77454F44ECCFA@kosagi.com>
Message-ID: <20130912104126.GS30088@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Sep 12, 2013 at 03:11:45PM +0800, Sean Cross wrote:
> > Even if it should be configurable I'm still unsure whether this should
> > be done at pci driver level.
> 
> I'm a bit wary of including clock setup like this in the SoC code, as
> different boards might be different.  If a board designer wants to run
> LVDS2 to the PCIe slot, that's entirely acceptable.  It might not
> actually ever get done, but it seems like the sort of board-specific
> thing that device tree was designed to handle.

The devicetree was designed to handle hardware descriptions, not
configuration options.

Chosing the clock parent is probably in the grey area between hardware
description and configuration, so I assume when we find a good reason to
add this option to the devicetree then it's acceptable to add it there.

But we shouldn't add this option for something that, as you say, 'might
not actually ever get done'. Just hardcode the clock selection in SoC
code for now. If someone ever finds the good reason to make this configurable
then he will speak up and we can discuss this again.

Sascha

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
