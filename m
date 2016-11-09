From: tixy@linaro.org (Jon Medhurst (Tixy))
Date: Wed, 09 Nov 2016 11:45:05 +0000
Subject: [PATCH RFC 00/12] tda998x updates
In-Reply-To: <20161108182434.GX1041@n2100.armlinux.org.uk>
References: <20161108122420.GP1041@n2100.armlinux.org.uk>
 <2264579a-3273-d9c4-761a-f50f547eb39b@arm.com>
 <20161108133215.GQ1041@n2100.armlinux.org.uk>
 <20161108133411.GA31754@n2100.armlinux.org.uk>
 <1478625636.27416.7.camel@linaro.org>
 <20161108182434.GX1041@n2100.armlinux.org.uk>
Message-ID: <1478691905.2835.12.camel@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 2016-11-08 at 18:24 +0000, Russell King - ARM Linux wrote:
> On Tue, Nov 08, 2016 at 05:20:36PM +0000, Jon Medhurst (Tixy) wrote:
> > On Tue, 2016-11-08 at 13:34 +0000, Russell King - ARM Linux wrote:
> > > On Tue, Nov 08, 2016 at 01:32:15PM +0000, Russell King - ARM Linux wrote:
> > > > Unfortunately, my drm-tda998x-devel branch is slightly out of date with
> > > > these patches it's the original set of 10 patches.  I've not pushed
> > > > these ones out to that branch yet, as I've three additional patches on
> > > > top of these which aren't "ready" for pushing out.
> > > 
> > > Here's the delta between the branch and what I just posted:
> > > 
> > > diff --git a/drivers/gpu/drm/i2c/tda998x_drv.c b/drivers/gpu/drm/i2c/tda998x_drv.c
> > [...]
> > 
> > I have a working setup for HDMI audio on Juno an would like to test this
> > series but am struggling to work out which patches to apply in what
> > order to what branch, can you be specific? (I've tried various
> > combinations of patches series from the list, drm-tda998x-devel, and the
> > diff you posted)
> 
> Hmm, I guess this is going to be annoyingly rather difficult then.
> The structure of my git tree is:
> 
> v4.8 ---------------- mali patch ------------------ merge --- these patches
> v4.7 -- tda998x audio patches (up to df0bd1e8f3c5) --^
> 
> which makes it rather difficult to send out a series that people can
> apply as patches without first replicating that merge.  I guess the
> answer is... use the _patches_ for review, and I'll push out the
> changes into drm-tda998x-devel... should be there soon.  Look for
> commit hash d61fa2e50f2a.  (Bah, slow 'net connections.)

Testing gets more complicated as I'm using 4.9-rc? which has a DMA fix
needed for audio [1] and breaks hdmi-codec which I hope I fixed [2].

Anyway, I merged in drm-tda998x-devel and audio continued to work on my
HDMI connected monitor. So I guess that's

Tested-by: Jon Medhurst <tixy@linaro.org>

I also reviewed the patches in this series. They look like a mostly
mechanical code organisation improvement, and whilst I'm not very
familiar with the driver and DRM, the other actual code changes look OK
too. So, FWIW:

Acked-by: Jon Medhurst <tixy@linaro.org>

[1] Commit d64e9a2c7509 ("dmaengine: pl330: fix residual for non-running BUSY descriptors")
[2] https://patchwork.kernel.org/patch/9401485/

-- 
Tixy
