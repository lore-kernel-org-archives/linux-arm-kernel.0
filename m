From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Thu, 26 Apr 2012 09:36:11 +0200
Subject: imx sgtl5000:BUG: scheduling while atomic:
 speaker-test/1225/0x00000003
In-Reply-To: <20376.63821.15844.738438@ipc1.ka-ro>
References: <20120426023319.GC28063@b20223-02.ap.freescale.net>
 <20120426051212.GF28063@b20223-02.ap.freescale.net>
 <20376.59099.336772.398425@ipc1.ka-ro>
 <20120426064430.GG28063@b20223-02.ap.freescale.net>
 <20376.63821.15844.738438@ipc1.ka-ro>
Message-ID: <20120426073611.GA17184@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Apr 26, 2012 at 09:29:17AM +0200, Lothar Wa?mann wrote:
> Hi,
> 
> > > -	init_completion(&sdmac->done);
> > > +	unsigned long timeout = 500;
> > I'm not sure. Did you test 500us is enough for loading firmware?
> >
> Channel 0 is not used for actual data transfer but for some internal
> housekeeping. Thus the timeout is independent from the time required
> for the actual data transfer.
> I haven't seen any timeout even with the timeout set to 100us.
> Usually it takes 3 to 4 us to complete.

It *is* used to load the firmware. Have you tested your patch with
actually loading a firmware?

Sascha

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
