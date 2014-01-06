From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 6 Jan 2014 17:46:06 +0000
Subject: [PATCH RFC 27/46] imx-drm: convert to componentised device support
In-Reply-To: <1389030088.5590.30.camel@pizza.hi.pengutronix.de>
References: <20140102212528.GD7383@n2100.arm.linux.org.uk>
 <E1VypoB-0007FJ-PA@rmk-PC.arm.linux.org.uk>
 <1388767737.19394.32.camel@pizza.hi.pengutronix.de>
 <20140103170724.GT7383@n2100.arm.linux.org.uk>
 <1388770004.19394.42.camel@pizza.hi.pengutronix.de>
 <52C70C1A.3090108@boundarydevices.com>
 <1389030088.5590.30.camel@pizza.hi.pengutronix.de>
Message-ID: <20140106174606.GG27432@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jan 06, 2014 at 06:41:28PM +0100, Philipp Zabel wrote:
> Hi Eric,
> 
> Am Freitag, den 03.01.2014, 12:14 -0700 schrieb Eric Nelson:
> > This is an issue we've seen before. The SABRE Lite board has
> > a voltage divider on the HPD pins and some monitors (esp. DVI
> > monitors) either don't drive things high enough to assert HPD or
> > bounce with connect/disconnect.
> 
> Yes, I used a DVI monitor.
> 
> > We've instrumented our 3.0.35 kernels to use the RX_SENSE bits
> > instead.
> 
> Reacting to RX_SENSE0 instead of HPD seems to work.

However, it's non-compliant, because HPD can be lowered and raised by
the sink when it changes its EDID data (eg, because you're connected
through a switch and the routing has been changed.)

So, reacting to RX_SENSE0 instead of HPD has to be a work-around enabled
only for those boards which are broken in this regard.

-- 
FTTC broadband for 0.8mile line: 5.8Mbps down 500kbps up.  Estimation
in database were 13.1 to 19Mbit for a good line, about 7.5+ for a bad.
Estimate before purchase was "up to 13.2Mbit".
