From: dave.martin@linaro.org (Dave Martin)
Date: Thu, 1 Dec 2011 12:14:03 +0000
Subject: [PATCH v3 4/5] ARM: vexpress: Initial RS1 memory map support
In-Reply-To: <20111201111049.GB2915@opensource.wolfsonmicro.com>
References: <1322579473-8804-1-git-send-email-pawel.moll@arm.com>
 <1322579473-8804-5-git-send-email-pawel.moll@arm.com>
 <20111130153749.GE2045@localhost.localdomain>
 <1322673302.3180.25.camel@hornet.cambridge.arm.com>
 <20111130175410.GJ2045@localhost.localdomain>
 <alpine.LFD.2.02.1111301522340.2357@xanadu.home>
 <20111130204805.GA5698@sirena.org.uk>
 <alpine.LFD.2.02.1111301604230.2357@xanadu.home>
 <20111201111049.GB2915@opensource.wolfsonmicro.com>
Message-ID: <20111201121403.GC2026@localhost.localdomain>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Dec 01, 2011 at 11:10:50AM +0000, Mark Brown wrote:
> On Wed, Nov 30, 2011 at 04:38:26PM -0500, Nicolas Pitre wrote:
> > On Wed, 30 Nov 2011, Mark Brown wrote:
> 
> > > Oh, dear.  Any pointers to the discussions on the u-boot side?
> 
> > Certainly.  Many different threads actually.  Here's a few:
> 
> OK, thanks - I see Stephen just followed up and Wolfgang seems
> moderately happy so hopefully there will be some progress.  It also
> occurs to me that there's at least Qi also using uImages, hopefully
> other bootloaders are going to be easier to deal with (or already cope).

If Stephen's patches are heading for merge, that's great.

If this feature remains blocked though, could we support Wolfgang's
preference for start-of-RAM-relative load and entry address?


This provides everything we need, and also works for Image as well as
zImage.  The one thing it doesn't allow is to tell u-Boot that
relocating a zImage to another location in memory is not usually
necessary.  But we already have that redundant copy during boot, so
this particular aspect of the situation at least won't get any worse.

Whether or not we consider this an ideal solution, it will work (which
is more than we have right now)


A final alternative would be to propose a more expressive descripition
of an image's load address constraints, so that we really can describe
things like "must be loaded to a word-aligned range within the first
128MB of RAM" and "must be loaded to start of RAM + 0x8000".  This
would give U-Boot the flexibility to choose an appropriate location
for the image, and the knowledge to make a correct choice.  It would
also give U-Boot the opportunity not to copy the image payload if
it meets the address constraints already.  However, such a solution
would come at the expense of a bit of added complexity.

Cheers
---Dave
