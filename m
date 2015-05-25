From: andrew@lunn.ch (Andrew Lunn)
Date: Mon, 25 May 2015 16:08:40 +0200
Subject: [PATCHv2] ARM: mvebu: add support for the new Aramda 385 based
 Linksys boards
In-Reply-To: <55631C6E.8050700@free-electrons.com>
References: <1432156456-440-1-git-send-email-kaloz@openwrt.org>
 <55631C6E.8050700@free-electrons.com>
Message-ID: <20150525140840.GA8883@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, May 25, 2015 at 02:58:22PM +0200, Gregory CLEMENT wrote:
> Hi Imre,
> 
> On 20/05/2015 23:14, Imre Kaloz wrote:
> > This patch adds support for the Linksys WRT1200AC (Caiman) and
> > the Linksys WRT1900AC v2 (Cobra).
> > 
> > Both boards have:
> > 
> > - 2 Marvell 88W8864 radios
> > - 1 USB 3.0 port
> > - 1 USB 2.0/eSATAp port
> > - 2 Ethernet interfaces connected to a 88E6176 switch (1x WAN + 4x LAN)
> > - 128MB NAND flash
> > - 512MB RAM
> > 
> > Signed-off-by: Imre Kaloz <kaloz@openwrt.org>
> > 
> > ---
> > Changes since v1: added DSA support
> > ---
> > The only difference between the two boards is the radio configuration
> > (2x2 vs 3x3), so everything except the leds (to be named properly)
> > is in the dtsi file. When the wireless driver will be submitted
> > upstream, the powertables (calibration data) will end up in the board
> > specific files, tho.
> 
> it seems that you missed my comment about removing bootargs and just using
> stdout-path = "serial0:115200n8";
> 
> If you agree and if there is no remark about the DSA part from Andrew, I can
> take car of it while applying your patch on mvebu/dt.

DSA looks fine

Acked-by: Andrew Lunn <andrew@lunn.ch>

Thanks
	Andrew

> 
> 
> Thanks,
> 
> Gregory
> 
> [...]
> 
> > --- /dev/null
> > +++ b/arch/arm/boot/dts/armada-385-linksys.dtsi
> 
> [...]
> 
> > +	chosen {
> > +		bootargs = "console=ttyS0,115200";
> > +		stdout-path = &uart0;
> Just here
> > +	};
> 
> 
> [...]
> -- 
> Gregory Clement, Free Electrons
> Kernel, drivers, real-time and embedded Linux
> development, consulting, training and support.
> http://free-electrons.com
