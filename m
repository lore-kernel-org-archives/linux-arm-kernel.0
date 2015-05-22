From: tiwai@suse.de (Takashi Iwai)
Date: Fri, 22 May 2015 16:05:22 +0200
Subject: [alsa-devel] [PATCH 10/13] sound/core: add DRM ELD helper
In-Reply-To: <s5hoalcemmy.wl-tiwai@suse.de>
References: <20150509102501.GO2067@n2100.arm.linux.org.uk>
 <E1Yr1xy-0006l8-Ft@rmk-PC.arm.linux.org.uk>
 <20150522122009.GK21391@sirena.org.uk>
 <20150522131534.GF2067@n2100.arm.linux.org.uk>
 <s5hzj4weo35.wl-tiwai@suse.de>
 <20150522135331.GG2067@n2100.arm.linux.org.uk>
 <s5hsiaoemz3.wl-tiwai@suse.de>
 <20150522140009.GH2067@n2100.arm.linux.org.uk>
 <s5hoalcemmy.wl-tiwai@suse.de>
Message-ID: <s5hmw0wemhp.wl-tiwai@suse.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

At Fri, 22 May 2015 16:02:13 +0200,
Takashi Iwai wrote:
> 
> At Fri, 22 May 2015 15:00:10 +0100,
> Russell King - ARM Linux wrote:
> > 
> > On Fri, May 22, 2015 at 03:54:56PM +0200, Takashi Iwai wrote:
> > > At Fri, 22 May 2015 14:53:31 +0100,
> > > Russell King - ARM Linux wrote:
> > > > 
> > > > On Fri, May 22, 2015 at 03:30:54PM +0200, Takashi Iwai wrote:
> > > > > At Fri, 22 May 2015 14:15:35 +0100,
> > > > > Russell King - ARM Linux wrote:
> > > > > > 
> > > > > > On Fri, May 22, 2015 at 01:20:09PM +0100, Mark Brown wrote:
> > > > > > > On Sat, May 09, 2015 at 11:26:42AM +0100, Russell King wrote:
> > > > > > > > Add a helper for the EDID like data structure, which is typically passed
> > > > > > > > from a HDMI adapter to its associated audio driver.  This informs the
> > > > > > > > audio driver of the capabilities of the attached HDMI sink.
> > > > > > > 
> > > > > > > As far as I can tell people are fairly happy with the implementation
> > > > > > > here and unless I'm missing something are definitely happy with the
> > > > > > > interface.  If that's the case can we get this into -next?  There's a
> > > > > > > lot of interest in HDMI right now (which is great) and this would be
> > > > > > > helpful for that, it seems like even if there are issues with the
> > > > > > > implementation it would be worth merging as is so we can start adding
> > > > > > > users and then do any improvements to the interface in parallel.
> > > > > > > 
> > > > > > > From an interface point of view:
> > > > > > > 
> > > > > > > Reviewed-by: Mark Brown <broonie@kernel.org>
> > > > > > 
> > > > > > I'd be more than happy if Takashi Iwai wants to take them - I'm not
> > > > > > planning on the audio driver itself being merged just yet as we still
> > > > > > need to properly hammer out the differences between the AHB audio (for
> > > > > > iMX6) and I2S audio (for Rockchip) for this device.
> > > > > 
> > > > > Sorry, I've been on vacation in the last two weeks, so slowly
> > > > > digesting all backlogs now.
> > > > > 
> > > > > > Alternatively, I could move these two patches to the beginning of my
> > > > > > series, and merge that point into my for-next and/or publish it as a
> > > > > > separate sub-branch... whatever people want, just let me know.
> > > > > 
> > > > > I'm fine to take the sound part.  It's only patches 10 and 11, right?
> > > > > Then I can provide a branch that can be merged for the rest drm
> > > > > stuff.
> > > > 
> > > > Yep, just patches 10 and 11.  If possible, please base these patches on
> > > > v4.1-rc1, thanks.
> > > 
> > > I applied them on top of -rc4, I suppose it's OK?
> > 
> > It is, but what it means is that I'll keep my copy of the patches in my
> > tree rather than pulling your tree.  Having branches spread on different
> > start points makes it difficult to generate a patch series from the git
> > tree - which is something I continue to do for the SolidRun iMX6 platforms
> > (publishing it as separate patches, tarball of those patches and a combined
> > patch.)
> > 
> > As I say, it doesn't matter that much, I can just keep my copies of the
> > patches, and when this stuff gets rebased to 4.2-rc1, git rebase should
> > eliminate them automatically.
> 
> OK, if so, then I rebase on top of -rc1.  The branch isn't merged yet,
> so no big problem.

Now the rebased branch is pushed.

I also merged this branch now to for-next branch, so that it'll be
tested through linux-next.


Takashi
