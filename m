From: pieterg@gmx.com (pieterg)
Date: Fri, 1 Oct 2010 08:55:52 +0200
Subject: pxa3xx_nand issues
In-Reply-To: <201010010215.09514.marek.vasut@gmail.com>
References: <201009221912.24905.pieterg@gmx.com>
	<201009271939.04710.pieterg@gmx.com>
	<201010010215.09514.marek.vasut@gmail.com>
Message-ID: <201010010855.52532.pieterg@gmx.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 01 October 2010 02:15:09 Marek Vasut wrote:
> Dne Po 27. z??? 2010 19:39:04 pieterg napsal(a):
> > On Monday 27 September 2010 15:50:50 pieterg wrote:
> > > On Monday 27 September 2010 14:22:37 Lei Wen wrote:
> > > > Does your jffs2 image make correct? Page size and block size set
> > > > right?
> > >
> > > I think so.
> > > --eraseblock=0x20000 --pad --no-cleanmarkers
> >
> > Well... that caused most of my problems.
> > --pad means pad to eraseblock size, not pagesize.
> > So the first writes in the new filesystem would cause pages in that
> > last eraseblock to be overwritten.
> > With SLC I always got away with that, but with MLC, clearly not.
> >
> > (now I'm still left with lots of singlebit errors, and occasional jffs2
> > CRC errors, pxa3xx_nand was obviously not meant to deal with such low
> > quality MLC, no action is taken on bit errors, but at least everything
> > can be explained now)
> >
> > Thanks everybody for helping me find the cause of this problem.
>
> So this is closed?

Yes, I guess what remains (many single bit errors, and occasional double bit 
errors) is 'normal' for this type of MLC NAND.
Still not happy with it, especially since there is no way to recover when 
double bit errors occur, but for now this will have to do.

> btw. wont ubifs be better choice for such a big flash ?

Certainly, it's on my list (after I've updated to the latest u-boot to get 
ubi support there as well)

Rgds, Pieter
