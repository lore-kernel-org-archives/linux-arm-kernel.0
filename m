From: ben-linux@fluff.org (Ben Dooks)
Date: Sat, 26 Sep 2009 12:59:27 +0100
Subject: Announcing s3c64xx XWindows fbdrv w/ XAA+XVideo+HWcursor
In-Reply-To: <200909251247.n8PClIil011167@chronolytics.com>
References: <20090924210958.GI31920@trinity.fluff.org>
	<200909251247.n8PClIil011167@chronolytics.com>
Message-ID: <20090926115927.GK31920@trinity.fluff.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Sep 25, 2009 at 08:47:18AM -0400, David F. Carlson wrote:
> According to Ben Dooks:
> > 
> > On Thu, Sep 24, 2009 at 01:42:20PM -0400, David F. Carlson wrote:
> > > 
> > > S3C6410 based Xwindows fbdev with
> > >    o  XAA accelerated fills, lines, expands, blits, offscreen pixmaps/stipples
> > >    o  Alpha-blended HWCursor 
> > >    o  XVideo Support (using the Samsung Post-Processor colorspace driver)
> > >    o  Tested with the Maemo Mer kernel 2.6.24.7 because...
> > > 
> > Are the necessary changes for the s3cfb postable to the list to start
> > the review process for them?
> 
> I have a near-term problem which is that I am still developing on 2.6.24.7
> because my attempts to use next-s3c failed to produce an image that would 
> start XWindows.  (SDHC, pwm, lcd support, etc.)  I am not complaining, just
> explaining.  Patching without testing is not a good place to be.

I was asking if it was possible to review them, not making a demand for
them to be merged. Starting to review can save time in the future if there
is any necessary changes. You can mark the patches 'for review only' if
you really care that they do not want to be merged.

As for the problems with next-s3c, bug reports are helpful in this case. If
you don't report issues then they might carry on being issues for you for
a while longer. Working on a such an ancient kernel may probe problematic
when you come to actually want to submit your own support to mainline.
 
> That being said, you seem to have a preferred direction for what should be
> in the s3c-fb.  Allocation of offscreen memory at config time seems doable
> with static testing.  Is a per-screen Kconfig desirable?  How should DBE and
> offscreen memory play nice?  (Or should they be mutually exclusive?)  With 
> a PP handling color space conversion and onscreen bit, I am not sure 
> DBE buys much.

I was asking for the patch and any necessarry changes to make it work
to find out what is going on and to allow a discussion of the technical
merrits of such a change.

Please explain 'DBE'.
 
> Adding the MMIO mmap interface is also "trivial".  (If it is desirable.
> I will not waste my time if it is "pre-rejected")
> 
> It also appears that even Samsung latests gits omit the g2d driver.  Is the 
> plan to fold that register space into s3c-fb or "something else"?  I need 
> suspend/resume support in the kernel for the XAA to "work".  But a contig
> vaddr mmap of the display controller and g2d dis-contig physical spaces 
> would suit me fine.  We need an answer to "how do we access the g2d space?"
>
> I am not a huge fan of the PP driver API, but it works.  I also think that 
> XVideo is the right way for user space to access the PP.  XWindows will "own"
> the device (ie., baseband not shared).  I would be willing to get you diffs 
> for PP (or Samsung could).

The 'PP' ?
 
> >  
> > > This driver is pretty much hardcoded for s3c64xx.  If kernel hooks for 
> > > describing configuration this driver base could be expanded to 
> > > support many s3c variants (with g2d and pp).
> > 
> > It would be good to get the discussion about these items going before
> > we get too much further down the development process.
> 
> I have tried to contact Samsung but I get dead-air.

If you've not reported this to your FAE/Distributor/etc then I seriously
suggest that you do so. If there is no reports about this how  can they
improve their behaviour.

> I know you (Ben) and Harald have had some discussion, but I am out of the 
> loop as to how Samsung/Harald/Ben/others want this thing to look when we 
> are done.

I'll have a look at this once I'm back and see what I can come up with
as at the moment I am not sure about the right way to solve this.
 
> I have placed a marker.  
> 
> And I am very willing to "get this right".  But part of my problem is that I 
> have access to 6410 only.  I do not understand the differences amongst the 
> 10+ devices in the s3c family.  With very few exceptions (Ben? :-) I am not 
> sure any out of Samsung really understands the whole s3c family.

-- 
Ben

Q:      What's a light-year?
A:      One-third less calories than a regular year.
