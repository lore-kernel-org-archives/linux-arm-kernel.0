From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Wed, 15 Dec 2010 16:15:28 +0100
Subject: [PATCH] i.MX51: Full iomux support
In-Reply-To: <87y67rcdnf.fsf@lechat.rtp-net.org>
References: <1292421691-14615-1-git-send-email-s.hauer@pengutronix.de>
	<87y67rcdnf.fsf@lechat.rtp-net.org>
Message-ID: <20101215151528.GD29833@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Dec 15, 2010 at 03:29:56PM +0100, Arnaud Patard wrote:
> Sascha Hauer <s.hauer@pengutronix.de> writes:
> 
> > Hi,
> 
> Hi,
> 
> >
> > The following series picks up the patch from Lothar Wa?mann replacing
> > the struct pad_desc with a 64bit variable and adds full i.MX51 iomux
> > support based on this patch.
> > The iomux configurations are taken from the Freescale pinmux tool, so the
> > definitions should be rather complete. Anyway, there are some modes
> > not present in the tool.
> > I took the padmux settings from the old iomux support where present.
> 
> I'm seeing a lot of changes in the iomux file and I have a patch [1]
> setting the SION bit for all gpios configuration so that reading the PSR
> value is giving usefull results when the gpio is configured as output. I
> wanted to send it this week but it will obviously conflict with
> this. Should I test your patchset first and if it's working, wait
> for its merge or should I send it anyway ? How do you want to deal with
> this (as long as you're fine with setting the SION bit for all gpios) ?

I'm fine with setting the SION bit for all gpios, I'm also fine with
setting the SION bit everywhere it's available (I tried this during
testing and it didn't have bad effects).

Maybe one of the Freescale guys can comment on this. On the i.MX35
we did not need this bit. There were the pinmux registers for
configuring the the way from the internal units to the pads and the
sel_input registers for the way back.
On i.MX51 there are several pins which do not have a sel_input register
associated (I2C) and so setting the SION bit becomes mandatory. On the
other hand not all pins have a SION bit. I'm confused...

Anyway, I can add the SION bits to the missing pins once we agree on
what we want to do.

Sascha


-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
