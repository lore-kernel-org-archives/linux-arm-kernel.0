From: andrew@lunn.ch (Andrew Lunn)
Date: Fri, 23 Nov 2018 16:36:56 +0100
Subject: [PATCH 1/7] ata: libahci_platform: comply to PHY framework
In-Reply-To: <20181123152730.GU30658@n2100.armlinux.org.uk>
References: <20181123101556.29888-1-miquel.raynal@bootlin.com>
 <20181123101556.29888-2-miquel.raynal@bootlin.com>
 <20181123151806.GC30913@lunn.ch>
 <20181123152730.GU30658@n2100.armlinux.org.uk>
Message-ID: <20181123153656.GD30913@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Nov 23, 2018 at 03:27:30PM +0000, Russell King - ARM Linux wrote:
> On Fri, Nov 23, 2018 at 04:18:06PM +0100, Andrew Lunn wrote:
> > Russell King wrote a comphy driver for the Armada 3XX family. It only
> > supports network PHYs. Did you check it does the right thing when
> > passed PHY_MODE_SATA? This is slightly different to Hans's comment, in
> > that i expect phy_set_mode() is implemented for the comphy driver, but
> > it might not understand PHY_MODE_SATA and return an error?
> 
> It makes no difference until the comphy is wired up to the SATA
> device in the appropriate DT files.  Until then, there's no way
> that the comphy will ever see PHY_MODE_SATA.

O.K, great.

Thanks
	Andrew
