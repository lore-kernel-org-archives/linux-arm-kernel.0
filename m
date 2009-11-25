From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Wed, 25 Nov 2009 12:30:34 +0100
Subject: [alsa-devel] [PATCH 03/12] add a mc13783 codec driver
In-Reply-To: <20091125111037.GE17420@opensource.wolfsonmicro.com>
References: <1258645706-9071-1-git-send-email-s.hauer@pengutronix.de>
	<1258645706-9071-2-git-send-email-s.hauer@pengutronix.de>
	<1258645706-9071-3-git-send-email-s.hauer@pengutronix.de>
	<1258645706-9071-4-git-send-email-s.hauer@pengutronix.de>
	<20091119193008.GC2814@sirena.org.uk>
	<20091125074631.GB27548@pengutronix.de>
	<20091125103959.GB17420@opensource.wolfsonmicro.com>
	<20091125110854.GC27548@pengutronix.de>
	<20091125111037.GE17420@opensource.wolfsonmicro.com>
Message-ID: <20091125113034.GD27548@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Nov 25, 2009 at 11:10:37AM +0000, Mark Brown wrote:
> On Wed, Nov 25, 2009 at 12:08:54PM +0100, Sascha Hauer wrote:
> > On Wed, Nov 25, 2009 at 10:39:59AM +0000, Mark Brown wrote:
> 
> > > What are "primary" and "secondary" here?  If they are broadly unrelated
> > > except for the clocking (which is what this sounds like) then they
> > > probably should be handled as separate DAIs.
> 
> > I thought about this, but can I do stereo with two seperate DAIs?
> 
> Again, what are "primary" and "secondary"?

Please have a look at page 3 of:

http://www.freescale.com/files/rf_if/doc/data_sheet/MC13783.pdf

Maybe this explains best the situation we have here.
Right in the middle of the diagram you see the A/D converters in the
Voice Codec. As you see it has two monaural A/D converters. One of them
is the primary, the other is the secondary converter (don't ask me which
of them is which, I'd had to lookup myself)
The input sources of these ADCs can't be controlled completely
independent and they are designed to be used for example with two
microphones in a mobile phone. (I guess that's why they call them
'primary' and 'secondary', not 'left' and 'right'). But of course you
can also do stereo with them.

Sascha


-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
