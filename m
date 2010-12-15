From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Wed, 15 Dec 2010 16:23:00 +0100
Subject: [PATCH] i.MX51: Full iomux support
In-Reply-To: <19720.55896.197553.407321@ipc1.ka-ro>
References: <1292421691-14615-1-git-send-email-s.hauer@pengutronix.de>
	<87y67rcdnf.fsf@lechat.rtp-net.org>
	<19720.55896.197553.407321@ipc1.ka-ro>
Message-ID: <20101215152300.GE29833@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Dec 15, 2010 at 04:10:16PM +0100, Lothar Wa?mann wrote:
> Hi,
> 
> Arnaud Patard (Rtp) writes:
> > Sascha Hauer <s.hauer@pengutronix.de> writes:
> [...]
> > > The following series picks up the patch from Lothar Wa?mann replacing
> > > the struct pad_desc with a 64bit variable and adds full i.MX51 iomux
> > > support based on this patch.
> > > The iomux configurations are taken from the Freescale pinmux tool, so the
> > > definitions should be rather complete. Anyway, there are some modes
> > > not present in the tool.
> > > I took the padmux settings from the old iomux support where present.
> > 
> > I'm seeing a lot of changes in the iomux file and I have a patch [1]
> > setting the SION bit for all gpios configuration so that reading the PSR
> > value is giving usefull results when the gpio is configured as output. I
> > wanted to send it this week but it will obviously conflict with
> > this. Should I test your patchset first and if it's working, wait
> > for its merge or should I send it anyway ? How do you want to deal with
> > this (as long as you're fine with setting the SION bit for all gpios) ?
> > 
> I had done the same, but had some trouble with this.
> E.g. on our board GPIO1_7 is used as a generic GPIO to enable an
> external clock oscillator for the USBH1 ULPI PHY. When the SION bit
> for this pad was set, I got strange errors on the USBH1 port
> (disconnecting low speed devices behind a hub would stall the
> bus). When I removed the SION bit for that pin everything worked
> well.
> 
> It looks like the SION setting may adversly affect the GPIO functions
> on the i.MX51.

This seems to suggest that we should leave the SION settings for the
gpios up to the board. With a simple bitmask it's easy enough for the
boards to customize the pinmux settings.

Sascha


-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
