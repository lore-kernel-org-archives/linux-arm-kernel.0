From: LW@KARO-electronics.de (=?utf-8?Q?Lothar_Wa=C3=9Fmann?=)
Date: Thu, 26 Apr 2012 10:02:41 +0200
Subject: imx sgtl5000:BUG: scheduling while atomic:
 speaker-test/1225/0x00000003
In-Reply-To: <20120426073611.GA17184@pengutronix.de>
References: <20120426023319.GC28063@b20223-02.ap.freescale.net>
 <20120426051212.GF28063@b20223-02.ap.freescale.net>
 <20376.59099.336772.398425@ipc1.ka-ro>
 <20120426064430.GG28063@b20223-02.ap.freescale.net>
 <20376.63821.15844.738438@ipc1.ka-ro>
 <20120426073611.GA17184@pengutronix.de>
Message-ID: <20377.289.954415.840587@ipc1.ka-ro>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Sascha Hauer writes:
> On Thu, Apr 26, 2012 at 09:29:17AM +0200, Lothar Wa?mann wrote:
> > Hi,
> > 
> > > > -	init_completion(&sdmac->done);
> > > > +	unsigned long timeout = 500;
> > > I'm not sure. Did you test 500us is enough for loading firmware?
> > >
> > Channel 0 is not used for actual data transfer but for some internal
> > housekeeping. Thus the timeout is independent from the time required
> > for the actual data transfer.
> > I haven't seen any timeout even with the timeout set to 100us.
> > Usually it takes 3 to 4 us to complete.
> 
> It *is* used to load the firmware. Have you tested your patch with
> actually loading a firmware?
> 
I'm using it around 100 times a day (with a 100us timeout)...


Lothar Wa?mann
-- 
___________________________________________________________

Ka-Ro electronics GmbH | Pascalstra?e 22 | D - 52076 Aachen
Phone: +49 2408 1402-0 | Fax: +49 2408 1402-10
Gesch?ftsf?hrer: Matthias Kaussen
Handelsregistereintrag: Amtsgericht Aachen, HRB 4996

www.karo-electronics.de | info at karo-electronics.de
___________________________________________________________
