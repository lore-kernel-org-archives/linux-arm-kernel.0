From: dave@chronolytics.com (David F. Carlson)
Date: Tue, 15 Sep 2009 05:49:51 -0400 (EDT)
Subject: Samsung S3C6410 / SmartQ / 2D acceleration / Xorgy
In-Reply-To: <20090915233430.GA13508@trinity.fluff.org>
Message-ID: <200909150949.n8F9np6X022280@chronolytics.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


I am not sure about uio.  Sorry.

The main problem is the g2d fifo is 32 commands deep.  And some of the 
x11perf tests are running in our XAA s3c driver @ ~2e6 ops/sec.  That is is 
lot of interrupts for user or kernel context.  :-)   

Sometimes polling is better.  1/2 :-)  

We are 1 stupid bug away from a release of s3c Xwindows fbdev + XAA + 
Xvideo (using the samsung s3c-pp) and HW cursor with alpha blend.

I have not looked at the g3d but DRI is "next".  

Cheers

David F. Carlson    Chronolytics, Inc.  Rochester, NY
mailto:dave at chronolytics.com            http://www.chronolytics.com

"The faster I go, the behinder I get." --Lewis Carroll
According to Ben Dooks:
> 
> On Thu, Sep 10, 2009 at 02:49:42PM +0900, Harald Welte wrote:
> > Dear David,
> > 
> > > I have a fairly decent SmartQ5/7 config and mach-smartq init file.  Much of
> > > this work (that I can test) can be back ported to the smdk6410 (that I can't
> > > test. :-)
> > 
> > So you're hacking on the SmartQ devices?  I recently discovered that they exist and I was
> > very intrigued in buying one. 
> 
> [snip]
>  
> > yes, a regular userspace Xorg EXA driver makes probably much more sense.
> > If the polling turns out to waste too many cycles, we can still think of some
> > interrupt-to-userspace delivery mechanism where we don't need to busy-wait
> > in the Xorg driver.
> 
> does uio support wait-for-interrupt?
> 
> -- 
> Ben
> 
> Q:      What's a light-year?
> A:      One-third less calories than a regular year.
> 
