From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Fri, 28 Mar 2014 10:00:23 +0100
Subject: [PATCHv2 1/1] mtd: gpmi: make blockmark swapping optional
In-Reply-To: <53353524.9020605@freescale.com>
References: <1395399017-19005-1-git-send-email-LW@KARO-electronics.de>
 <20140324095902.GB11377@localhost>
 <20140326095156.3e5585b8@ipc1.ka-ro>
 <5332AEE7.2040402@freescale.com>
 <20140326125502.0e8d0657@ipc1.ka-ro>
 <20140327095956.GA29623@localhost>
 <20140327132109.06258526@ipc1.ka-ro>
 <5334D9F7.2030001@freescale.com>
 <20140328091646.1ce03f90@ipc1.ka-ro>
 <53353524.9020605@freescale.com>
Message-ID: <20140328090023.GB17250@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Mar 28, 2014 at 04:39:00PM +0800, Huang Shijie wrote:
> ? 2014?03?28? 16:16, Lothar Wa?mann ??:
> >Still there is no need for the Linux NAND driver to be able to read or
> >write partitions in a format that the Boot ROM can understand. Thus it
> If you do not use the NAND boot, there really no need to do so.
> 
> Since you need the NAND boot, we should enable the swapping for imx28.
> >is perfectly legal to allow disregarding the BB marks and solely rely on
> >a flash based BBT.
> >
> The BB mark is in the page 0 of a NAND block. But the swapping can
> occur in _each_ page of
> a NAND block, _NOT_ only the page 0.
> 
> I think you are confusing at these two things.

I think you are confusing two things. If Lothar:

- disables swapping of BB marks in the FCB the ROM won't swap bytes.
- writes data without swapping
- Uses a DBBT for telling the ROM code where bad blocks are
- uses a Flash BBT for mtd

Then everything should work just fine.

Sascha

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
