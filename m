From: marek.vasut@gmail.com (Marek Vasut)
Date: Fri, 1 Oct 2010 09:25:34 +0200
Subject: pxa3xx_nand issues
In-Reply-To: <201010010855.52532.pieterg@gmx.com>
References: <201009221912.24905.pieterg@gmx.com>
	<201010010215.09514.marek.vasut@gmail.com>
	<201010010855.52532.pieterg@gmx.com>
Message-ID: <201010010925.34759.marek.vasut@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dne P? 1. ??jna 2010 08:55:52 pieterg napsal(a):
> On Friday 01 October 2010 02:15:09 Marek Vasut wrote:
> > Dne Po 27. z??? 2010 19:39:04 pieterg napsal(a):
> > > On Monday 27 September 2010 15:50:50 pieterg wrote:
> > > > On Monday 27 September 2010 14:22:37 Lei Wen wrote:
> > > > > Does your jffs2 image make correct? Page size and block size set
> > > > > right?
> > > > 
> > > > I think so.
> > > > --eraseblock=0x20000 --pad --no-cleanmarkers
> > > 
> > > Well... that caused most of my problems.
> > > --pad means pad to eraseblock size, not pagesize.
> > > So the first writes in the new filesystem would cause pages in that
> > > last eraseblock to be overwritten.
> > > With SLC I always got away with that, but with MLC, clearly not.
> > > 
> > > (now I'm still left with lots of singlebit errors, and occasional jffs2
> > > CRC errors, pxa3xx_nand was obviously not meant to deal with such low
> > > quality MLC, no action is taken on bit errors, but at least everything
> > > can be explained now)
> > > 
> > > Thanks everybody for helping me find the cause of this problem.
> > 
> > So this is closed?
> 
> Yes, I guess what remains (many single bit errors, and occasional double
> bit errors) is 'normal' for this type of MLC NAND.
> Still not happy with it, especially since there is no way to recover when
> double bit errors occur, but for now this will have to do.
> 
> > btw. wont ubifs be better choice for such a big flash ?
> 
> Certainly, it's on my list (after I've updated to the latest u-boot to get
> ubi support there as well)

I'm currently fixing 2010.09, there were some changes that broke support for 
every pxa (or rather every ARM) machine. I have two machines fixed, but those are 
still pxa2xx. PXA3xx is on the list and thanks to this, pxa3xx should soon also 
hit mainline (well ... when, that depends on Wolfgang).

Cheers
> 
> Rgds, Pieter
