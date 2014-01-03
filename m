From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 3 Jan 2014 17:38:34 +0000
Subject: [PATCH RFC 27/46] imx-drm: convert to componentised device support
In-Reply-To: <1388770004.19394.42.camel@pizza.hi.pengutronix.de>
References: <20140102212528.GD7383@n2100.arm.linux.org.uk>
 <E1VypoB-0007FJ-PA@rmk-PC.arm.linux.org.uk>
 <1388767737.19394.32.camel@pizza.hi.pengutronix.de>
 <20140103170724.GT7383@n2100.arm.linux.org.uk>
 <1388770004.19394.42.camel@pizza.hi.pengutronix.de>
Message-ID: <20140103173834.GU7383@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jan 03, 2014 at 06:26:44PM +0100, Philipp Zabel wrote:
> Am Freitag, den 03.01.2014, 17:07 +0000 schrieb Russell King - ARM
> Linux:
> > On Fri, Jan 03, 2014 at 05:48:57PM +0100, Philipp Zabel wrote:
> > > Hi Russell,
> > > 
> > > I've tested this series on a BD-SL (SabreLite) with HDMI. Right now
> > > the HPD signal doesn't seem to work, but after overwriting the
> > > connection check, I got a stable and correct picture on the monitor:
> > 
> > Hmm.  Does this mean you're not getting any IRQs from the HDMI interface
> > when you plug and unplug the monitor?
> > 
> > 147:        281       GIC 147  120000.hdmi
> > 
> > on turning the TV on:
> > 
> > 147:        282       GIC 147  120000.hdmi
> > 
> > on unplugging the HDMI cable:
> > 
> > 147:        283       GIC 147  120000.hdmi
> > 
> > on replugging the HDMI cable:
> > 
> > 147:        284       GIC 147  120000.hdmi
> 
> Exactly. And while the RX_SENSE bits of HDMI_IH_PHY_STAT0 change when I
> (un)plug, the HPD bit stays zero. I'll check with other hardware.

My guess would be that someone forgot to wire up the HPD line
correctly.  As ever, the documentation doesn't describe how this
stuff works...

-- 
FTTC broadband for 0.8mile line: 5.8Mbps down 500kbps up.  Estimation
in database were 13.1 to 19Mbit for a good line, about 7.5+ for a bad.
Estimate before purchase was "up to 13.2Mbit".
