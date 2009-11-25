From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Wed, 25 Nov 2009 12:08:54 +0100
Subject: [alsa-devel] [PATCH 03/12] add a mc13783 codec driver
In-Reply-To: <20091125103959.GB17420@opensource.wolfsonmicro.com>
References: <1258645706-9071-1-git-send-email-s.hauer@pengutronix.de>
	<1258645706-9071-2-git-send-email-s.hauer@pengutronix.de>
	<1258645706-9071-3-git-send-email-s.hauer@pengutronix.de>
	<1258645706-9071-4-git-send-email-s.hauer@pengutronix.de>
	<20091119193008.GC2814@sirena.org.uk>
	<20091125074631.GB27548@pengutronix.de>
	<20091125103959.GB17420@opensource.wolfsonmicro.com>
Message-ID: <20091125110854.GC27548@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Nov 25, 2009 at 10:39:59AM +0000, Mark Brown wrote:
> On Wed, Nov 25, 2009 at 08:46:31AM +0100, Sascha Hauer wrote:
> 
> > The problem here is that I don't really understand what arguments I
> > should supply to this function and how to parse them to archieve what I
> > want.
> 
> > The MC13783 Voice Codec always uses a network mode to send data. It has
> > a fixed width of four slots.
> 
> > PMIC_SSI_NETWORK[2:3] defines the slot for primary transmit/receive
> > PMIC_SSI_NETWORK[4:5] defines the secondary transmit timeslot
> > PMIC_SSI_NETWORK[6:7] defines the secondary receive timeslot
> 
> > The Codec has two channels and it's not primarily desgined to do stereo
> > Audio. I want to put the primary channel into the first timeslot and
> > the secondary channel into the second timeslot.
> 
> What are "primary" and "secondary" here?  If they are broadly unrelated
> except for the clocking (which is what this sounds like) then they
> probably should be handled as separate DAIs.

I thought about this, but can I do stereo with two seperate DAIs?

Sascha

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
