From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Fri, 20 Nov 2009 12:10:33 +0100
Subject: [alsa-devel] i.MX audio support
In-Reply-To: <eedb5540911200232u21767102i8310e62b952c77bb@mail.gmail.com>
References: <1258645706-9071-1-git-send-email-s.hauer@pengutronix.de>
	<20091119162830.GA31336@rakim.wolfsonmicro.main>
	<20091119175327.GV30179@pengutronix.de>
	<20091119185426.GA2814@sirena.org.uk>
	<eedb5540911192351l5abc7a18s5a218f9b20b58d1b@mail.gmail.com>
	<20091120095109.GW30179@pengutronix.de>
	<eedb5540911200232u21767102i8310e62b952c77bb@mail.gmail.com>
Message-ID: <20091120111033.GX30179@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Nov 20, 2009 at 11:32:10AM +0100, javier Martin wrote:
> > I would agree if the current code worked and would be good shape.
> > Unfortunately it's not. It hardcodes the fact that there are 2 SSI units
> > (i.MX51 has three of them). Instead of writel/readl it uses direct pointer
> > derefs. The driver skips audio while it reinitialises the DMA engine. In
> > mx1_mx2_pcm_open() there are several memory leaks. The driver does not
> > call clk_get itself but depends on the board doing it. The only
> > available board support depends on a board not present in the kernel, so
> > we are not able to compile it (and it won't because the audmux
> > definitions are missing)
> 
> We have still some pending HW changes in our board so we are not ready
> to submit it now. Anyway it would have been nice to have such this
> comments when I submitted my patches to avoid unnecessary rework.

Sorry, I missed them. I'm subscribed to alsa-devel for one day now and
AFAIK the patches haven't been posted to any other list.

Sascha


-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
