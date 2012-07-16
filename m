From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Mon, 16 Jul 2012 10:50:51 +0200
Subject: [PATCH 12/12] USB: chipidea: add imx usbmisc support
In-Reply-To: <20120716083837.GI21635@b20223-02.ap.freescale.net>
References: <1342076512-19207-1-git-send-email-richard.zhao@freescale.com>
 <1342076512-19207-13-git-send-email-richard.zhao@freescale.com>
 <20120716082520.GN24458@pengutronix.de>
 <20120716083837.GI21635@b20223-02.ap.freescale.net>
Message-ID: <20120716085051.GF30009@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jul 16, 2012 at 04:38:38PM +0800, Richard Zhao wrote:
> > 
> > NACK
> Right, it's a bad design. I'm considering change it too. Maybe I will
> move it out this patch series. As I asked you in another mail in this
> thread, do you think it's good to put it here or in mach-imx/ ?

I prefer it to be in drivers/usb/chipidea.

> > 
> > What you've done here exactly matches your current usecase but is not
> > enough for any of the other usecases I can think of. Even the i.MX6 has
> > three USB ports, each of them has a overcurrent disable bit. Also, there
> > are more flags, like:
> Yes, I'll change it to support different usb with different properties.
> > 
> > - use internal phy
> > - power pin polarity
> > - ttl enabled
> I focus on imx6 now. So I think the property can be added when it's
> needed. Now I only use disable oc.

That's fine, but you should give the impression that you thought about
other usecases and other SoCs than your current one, it'll make it easier
for us to believe that your patch does the right thing ;)

Sascha

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
