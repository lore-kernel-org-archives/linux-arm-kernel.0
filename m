From: jan.glauber@caviumnetworks.com (Jan Glauber)
Date: Thu, 18 Feb 2016 14:45:20 +0100
Subject: [PATCH v3 1/5] arm64/perf: Rename Cortex A57 events
In-Reply-To: <20160218112429.GC8011@arm.com>
References: <cover.1454516082.git.jglauber@cavium.com>
 <e0ecaaaffb64cc0b2ecfd8852f718a3f1d642b5c.1454516082.git.jglauber@cavium.com>
 <20160215194037.GU6298@arm.com> <20160215200613.GY6298@arm.com>
 <20160218091307.GA4566@hardcore> <20160218112429.GC8011@arm.com>
Message-ID: <20160218134520.GC2648@hardcore>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Feb 18, 2016 at 11:24:29AM +0000, Will Deacon wrote:
> On Thu, Feb 18, 2016 at 10:13:07AM +0100, Jan Glauber wrote:
> > On Mon, Feb 15, 2016 at 08:06:13PM +0000, Will Deacon wrote:
> > > On Mon, Feb 15, 2016 at 07:40:37PM +0000, Will Deacon wrote:
> > > > On Wed, Feb 03, 2016 at 06:11:56PM +0100, Jan Glauber wrote:
> > > > > The implemented Cortex A57 events are not A57 specific.
> > > > > They are recommended by ARM and can be found on other
> > > > > ARMv8 SOCs like Cavium ThunderX too. Therefore move
> > > > > these events to the common PMUv3 table.
> > > > 
> > > > I can't find anything in the architecture that suggests these event
> > > > numbers are necessarily portable between implementations. Am I missing
> > > > something?
> > > 
> > > Aha, I just noticed appendix K3.1 (silly me for missing it...).
> > > 
> > > Lemme check whether or not that mandates that those encodings can't be
> > > used for wildly different things.
> > 
> > To me it looks like we would just have duplicated code without the patch,
> > and at least the event types (e.g. L1D_CACHE_RD) should be identical
> > across implementations.
> > 
> > But I don't care too much, so please tell me if should drop the patch or
> > keep it.
> 
> Tell you what then -- how about we simply rename those to ARMV8_IMPDEF_*
> instead of ARMV8_A57_*? That way, we can easily identify them as distinct
> from the architected events if we need to in future.

Sounds good. I'll refresh and re-post the whole series then.

Jan

> Will
