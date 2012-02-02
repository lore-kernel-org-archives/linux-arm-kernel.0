From: LW@KARO-electronics.de (=?utf-8?Q?Lothar_Wa=C3=9Fmann?=)
Date: Thu, 2 Feb 2012 15:43:28 +0100
Subject: [PATCH v3] mtd/gpmi : add BBT support to gpmi nand driver
In-Reply-To: <Pine.LNX.4.64.1202021441330.554@lnxricardw.se.axis.com>
References: <1328008316-27258-1-git-send-email-b32955@freescale.com>
 <20120131121007.GO2471@pengutronix.de>
 <1328183611.28171.170.camel@sauron.fi.intel.com>
 <20266.36804.844286.216383@ipc1.ka-ro>
 <Pine.LNX.4.64.1202021441330.554@lnxricardw.se.axis.com>
Message-ID: <20266.41232.670348.59659@ipc1.ka-ro>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Ricard Wanderlof writes:
> 
> On Thu, 2 Feb 2012, Lothar Wa?mann wrote:
> 
> > Hi,
> 
> > IMO it's just silly trying to write anything, even a bad block marker,to 
> > a known bad block in NAND flash.
> >
> > The bad block markers in particular bytes in the OOB area are providedby 
> > the manufacturer to identify "Factory Bad Blocks". That and no more! I 
> > don't know why everybody is trying to interpret them as a general bad 
> > block indicator.
> 
> Why not? It's just another byte within the block.
> 
But on a block that is known to have failed erasure or programming you
cannot rely on being able to program anything reliably. Thus it is
vain to try storing the info that the block is bad within that block
itself.

> The Flash chip reports an error on a write or erase operation if the 
> operation does not complete successfully within certain time constraints, 
> which are grounds for marking a block as unusable, i.e. bad, but usually 
> the block is worn out long before the on-chip write/erase algorithms 
> report errors. Hence a block should really be marked 'bad' while it still 
> is 'good', in a sense.
> 
How do you know that a worn out block will still retain the 'This
block is bad' information?


Lothar Wa?mann
-- 
___________________________________________________________

Ka-Ro electronics GmbH | Pascalstra?e 22 | D - 52076 Aachen
Phone: +49 2408 1402-0 | Fax: +49 2408 1402-10
Gesch?ftsf?hrer: Matthias Kaussen
Handelsregistereintrag: Amtsgericht Aachen, HRB 4996

www.karo-electronics.de | info at karo-electronics.de
___________________________________________________________
