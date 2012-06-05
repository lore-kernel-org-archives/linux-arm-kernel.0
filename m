From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Tue, 5 Jun 2012 14:41:16 +0100
Subject: Freescale fec.c driver breakage
In-Reply-To: <4FCE088D.1060604@snapgear.com>
References: <4FCC3CB4.5030107@snapgear.com>
 <20120604081937.GH30400@pengutronix.de>
 <20120604091616.GA3943@opensource.wolfsonmicro.com>
 <4FCDAD5B.8010106@snapgear.com>
 <20120605094141.GE23408@opensource.wolfsonmicro.com>
 <4FCDF8BE.6010509@snapgear.com>
 <20120605124844.GR30400@pengutronix.de>
 <4FCE088D.1060604@snapgear.com>
Message-ID: <20120605134116.GY23408@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jun 05, 2012 at 11:24:29PM +1000, Greg Ungerer wrote:

> Well, yeah, of course there are clocks involved. But you pretty much
> hit the point here. 'ipg' and 'ahb' here are platform specific.

What should be happening for that is that the driver requests with some
generic name which is referenced to the IP (unfortunately these are
usually not documented for the public...) and then clkdev or some
platform specific code is used to map the names onto the underlying
clocks.

If 'ahb' isn't suitable how about 'bus', and for 'ipg' how about 'mclk'
or something?
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120605/7c29e6c3/attachment.sig>
