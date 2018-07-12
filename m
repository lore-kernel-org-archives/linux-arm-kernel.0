From: linux@armlinux.org.uk (Russell King - ARM Linux)
Date: Thu, 12 Jul 2018 08:53:25 +0100
Subject: [PATCH v3] Add DT support for Octavo Systems OSD3358-SM-RED
 based on TI AM335x
In-Reply-To: <20180712053155.GP99251@atomide.com>
References: <20180711145822.1090-1-neeraj.dantu@octavosystems.com>
 <20180712053155.GP99251@atomide.com>
Message-ID: <20180712075325.GH6920@n2100.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jul 11, 2018 at 10:31:55PM -0700, Tony Lindgren wrote:
> Hi,
> 
> * Neeraj Dantu <dantuguf14105@gmail.com> [180711 15:13]:
> > OSD3358-SM-RED is a dev board for OSD335x System-in-Package(SiP) devices from
> > Octavo Systems.
> ...
> > - Fix HDMI encoder node name
> 
> I think you got this the wrong way around :) See below.
> 
> > +&i2c0 {
> > +	hdmiencoder: tda19988 {
> > +		compatible = "nxp,tda998x";
> 
> 	tda19988: hdmiencoder {
> 		...
> 	};
> 
> So the generic type for the node. Please check the
> other devices for that too.

In the binding doc, we use "hdmi-encoder" for the node name.

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 13.8Mbps down 630kbps up
According to speedtest.net: 13Mbps down 490kbps up
