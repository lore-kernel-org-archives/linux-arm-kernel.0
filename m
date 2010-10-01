From: marek.vasut@gmail.com (Marek Vasut)
Date: Fri, 1 Oct 2010 02:15:09 +0200
Subject: pxa3xx_nand issues
In-Reply-To: <201009271939.04710.pieterg@gmx.com>
References: <201009221912.24905.pieterg@gmx.com>
	<201009271550.50399.pieterg@gmx.com>
	<201009271939.04710.pieterg@gmx.com>
Message-ID: <201010010215.09514.marek.vasut@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dne Po 27. z??? 2010 19:39:04 pieterg napsal(a):
> On Monday 27 September 2010 15:50:50 pieterg wrote:
> > On Monday 27 September 2010 14:22:37 Lei Wen wrote:
> > > Does your jffs2 image make correct? Page size and block size set right?
> > 
> > I think so.
> > --eraseblock=0x20000 --pad --no-cleanmarkers
> 
> Well... that caused most of my problems.
> --pad means pad to eraseblock size, not pagesize.
> So the first writes in the new filesystem would cause pages in that last
> eraseblock to be overwritten.
> With SLC I always got away with that, but with MLC, clearly not.
> 
> (now I'm still left with lots of singlebit errors, and occasional jffs2 CRC
> errors, pxa3xx_nand was obviously not meant to deal with such low quality
> MLC, no action is taken on bit errors, but at least everything can be
> explained now)
> 
> Thanks everybody for helping me find the cause of this problem.

So this is closed?

btw. wont ubifs be better choice for such a big flash ?

Cheers
> 
> Rgds, Pieter
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
