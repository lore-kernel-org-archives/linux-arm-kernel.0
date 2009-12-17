From: LW@KARO-electronics.de (=?iso-8859-15?Q?Lothar_Wa=DFmann?=)
Date: Thu, 17 Dec 2009 12:49:42 +0100
Subject: [PATCH 16/20] imx27: define and use MX27_IO_ADDRESS
In-Reply-To: <20091217100526.GD19548@pengutronix.de>
References: <1260990002-24168-8-git-send-email-u.kleine-koenig@pengutronix.de>
	<1260990002-24168-9-git-send-email-u.kleine-koenig@pengutronix.de>
	<1260990002-24168-10-git-send-email-u.kleine-koenig@pengutronix.de>
	<1260990002-24168-11-git-send-email-u.kleine-koenig@pengutronix.de>
	<1260990002-24168-12-git-send-email-u.kleine-koenig@pengutronix.de>
	<1260990002-24168-13-git-send-email-u.kleine-koenig@pengutronix.de>
	<1260990002-24168-14-git-send-email-u.kleine-koenig@pengutronix.de>
	<1260990002-24168-15-git-send-email-u.kleine-koenig@pengutronix.de>
	<1260990002-24168-16-git-send-email-u.kleine-koenig@pengutronix.de>
	<19241.55420.124271.517259@ipc1.ka-ro>
	<20091217100526.GD19548@pengutronix.de>
Message-ID: <19242.6870.193432.23163@ipc1.ka-ro>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Uwe Kleine-K?nig writes:
> Hello Lother,
> 
Lothar
    ^
> On Thu, Dec 17, 2009 at 08:06:36AM +0100, Lothar Wa?mann wrote:
> > > +#define MX27_IO_ADDRESS(x)						\
> > > +	(void __force __iomem *) ( 					\
> > > +	IMX_IO_ADDRESS(x, MX27_AIPI) ?:					\
> > > +	IMX_IO_ADDRESS(x, MX27_SAHB1) ?:				\
> > > +	IMX_IO_ADDRESS(x, MX27_X_MEMC) ?:				\
> > > +	0xdeadbeef)
> >         ^^^^^^^^^^
> > I prefer to have a plain '0' here. Otherwise an invocation of this
> > macro with an illegal address could lead to silent corruption of
> > memory that happens to be mapped at that virtual address instead of a
> > kernel oops due to a null pointer dereference!
> > 
> > Same for the other processors.
> I'm a bit undecided here.  I choosed 0xdeadbeef because it is used in
>
0xdeadbeef by itself may look suspicious if you find it in some crash
dump. But if some offset is added to it, you cannot distinguish it
from any other legal virtual address.

> IO_ADDRESS, too.  It's not aligned, so probably nothing happens.  As
>
Then, that macro should be changed also. And for the alignment
argument, memory can also be accessed bytewise.


Lothar Wa?mann
-- 
___________________________________________________________

Ka-Ro electronics GmbH | Pascalstra?e 22 | D - 52076 Aachen
Phone: +49 2408 1402-0 | Fax: +49 2408 1402-10
Gesch?ftsf?hrer: Matthias Kaussen
Handelsregistereintrag: Amtsgericht Aachen, HRB 4996

www.karo-electronics.de | info at karo-electronics.de
___________________________________________________________
