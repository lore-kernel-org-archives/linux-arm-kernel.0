From: LW@KARO-electronics.de (Lothar =?UTF-8?B?V2HDn21hbm4=?=)
Date: Fri, 28 Mar 2014 10:01:58 +0100
Subject: [PATCHv2 1/1] mtd: gpmi: make blockmark swapping optional
In-Reply-To: <53353524.9020605@freescale.com>
References: <532BCFCC.4080205@freescale.com>
 <1395399017-19005-1-git-send-email-LW@KARO-electronics.de>
 <20140324095902.GB11377@localhost>
 <20140326095156.3e5585b8@ipc1.ka-ro>
 <5332AEE7.2040402@freescale.com>
 <20140326125502.0e8d0657@ipc1.ka-ro>
 <20140327095956.GA29623@localhost>
 <20140327132109.06258526@ipc1.ka-ro>
 <5334D9F7.2030001@freescale.com>
 <20140328091646.1ce03f90@ipc1.ka-ro>
 <53353524.9020605@freescale.com>
Message-ID: <20140328100158.042a3d68@ipc1.ka-ro>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Huang Shijie wrote:
> ? 2014?03?28? 16:16, Lothar Wa?mann ??:
> > Still there is no need for the Linux NAND driver to be able to read or
> > write partitions in a format that the Boot ROM can understand. Thus it
> If you do not use the NAND boot, there really no need to do so.
>
There is no need for the ROM code to access any other partition than
the bootloader itself. Thus Linux can perfectly well be booted from
NAND without any byte swapping.

> Since you need the NAND boot, we should enable the swapping for imx28.
>
Why? There is no need for Linux to do any swapping when not accessing
the bootloader partition.

> > is perfectly legal to allow disregarding the BB marks and solely rely on
> > a flash based BBT.
> >
> The BB mark is in the page 0 of a NAND block. But the swapping can occur 
> in _each_ page of
> a NAND block, _NOT_ only the page 0.
> 
> I think you are confusing at these two things.
> 
No, I'm not confusing anything. The swapping in any other page than
page 0 is completely useless. Thus, when there is no need to recognize
the BB markers, there in no need to do any swapping too.


Lothar Wa?mann
-- 
___________________________________________________________

Ka-Ro electronics GmbH | Pascalstra?e 22 | D - 52076 Aachen
Phone: +49 2408 1402-0 | Fax: +49 2408 1402-10
Gesch?ftsf?hrer: Matthias Kaussen
Handelsregistereintrag: Amtsgericht Aachen, HRB 4996

www.karo-electronics.de | info at karo-electronics.de
___________________________________________________________
