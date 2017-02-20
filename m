From: clabbe.montjoie@gmail.com (Corentin Labbe)
Date: Mon, 20 Feb 2017 16:07:51 +0100
Subject: [PATCH 04/21] ARM: sun8i: dt: Add DT bindings documentation for
 Allwinner dwmac-sun8i
In-Reply-To: <783a717d-f1f4-e265-bf94-0b3080cea542@gmail.com>
References: <20170216124859.14346-1-clabbe.montjoie@gmail.com>
 <20170216124859.14346-5-clabbe.montjoie@gmail.com>
 <783a717d-f1f4-e265-bf94-0b3080cea542@gmail.com>
Message-ID: <20170220150751.GB31799@Red>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Feb 16, 2017 at 12:58:46PM -0800, Florian Fainelli wrote:
> On 02/16/2017 04:48 AM, Corentin Labbe wrote:
> > +
> > +Optional properties:
> > +- allwinner,tx-delay: TX clock delay chain value. Range value is 0-0x07. Default is 0)
> > +- allwinner,rx-delay: RX clock delay chain value. Range value is 0-0x1F. Default is 0)
> 
> Delays should be specified in nanosecond units, and should not be a
> value that maps directly to a HW register value, you need to convert the
> property value into the appropriate register value.
> 

This question already raised multiple times in sun8i-emac development, I do not have any information on how to decode thoses values. (and so the comment below in documentation)
I will try to contact Allwinner for more details.

> > +Both delay properties does not have units, there are arbitrary value.
> > +The TX/RX clock delay chain settings are board specific and could be found
> > +in vendor FEX files.
> > +
> > +Optional properties for "allwinner,sun8i-h3-emac":
> > +- allwinner,leds-active-low: EPHY LEDs are active low
> 
> Are you sure this is appropriate at the MAC node level and this is not
> something that follows the PHY instead?
> 

As said by MoeIcenowy, an internal PHY is present. At early stage of development, wens tried to create a PHY driver for it, but finaly it was too much over complicated and with few interest to split in two.

> > +
> > +Required child node of emac:
> > +- mdio bus node: should be named mdio
> > +
> > +Required properties of the mdio node:
> > +- #address-cells: shall be 1
> > +- #size-cells: shall be 0
> > +
> > +The device node referenced by "phy" or "phy-handle" should be a child node
> > +of the mdio node. See phy.txt for the generic PHY bindings.
> > +
> > +Required properties of the phy node with "allwinner,sun8i-h3-emac":
> > +- clocks: an extra phandle to the reference clock for the EPHY
> 
> s/an extra/a phandle/
> 

Thanks, will fix

Regards
Corentin Labbe
