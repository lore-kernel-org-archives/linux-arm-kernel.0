From: LW@KARO-electronics.de (=?utf-8?Q?Lothar_Wa=C3=9Fmann?=)
Date: Mon, 11 Jul 2011 09:49:07 +0200
Subject: [PATCH v2 1/7] spi/imx: do not make copy of spi_imx_devtype_data
In-Reply-To: <20110711073136.GA13840@pengutronix.de>
References: <1310231801-18761-1-git-send-email-shawn.guo@linaro.org>
	<1310231801-18761-2-git-send-email-shawn.guo@linaro.org>
	<19994.41750.920408.162356@ipc1.ka-ro>
	<20110711073136.GA13840@pengutronix.de>
Message-ID: <19994.43763.88454.662575@ipc1.ka-ro>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Uwe Kleine-K?nig writes:
> On Mon, Jul 11, 2011 at 09:15:34AM +0200, Lothar Wa?mann wrote:
> > Hi,
> > 
> > Shawn Guo writes:
> > > spi_imx_devtype_data has already been driver private data.  There is
> > > really no need to make a copy in spi_imx_data.  Instead, a reference
> > > pointer works perfectly fine.
> > > 
> > You obviously overlooked, that the copy is done on purpose to keep
> > only the data that is actually needed and discard everything else
> > after initialisation.
> though you could argue that __devinitdata isn't discarded on modern
> systems anyhow (and Shawn's patch takes care of removing that
> annotation).
> 
Shawn's comment should probably have reflected that...


Lothar Wa?mann
-- 
___________________________________________________________

Ka-Ro electronics GmbH | Pascalstra?e 22 | D - 52076 Aachen
Phone: +49 2408 1402-0 | Fax: +49 2408 1402-10
Gesch?ftsf?hrer: Matthias Kaussen
Handelsregistereintrag: Amtsgericht Aachen, HRB 4996

www.karo-electronics.de | info at karo-electronics.de
___________________________________________________________
