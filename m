From: plagnioj@jcrosoft.com (Jean-Christophe PLAGNIOL-VILLARD)
Date: Fri, 4 May 2012 18:40:45 +0200
Subject: Making ARM multiplatform kernels DT-only?
In-Reply-To: <20120504165603.GK897@n2100.arm.linux.org.uk>
References: <201205031350.35476.arnd@arndb.de>
 <20120503140428.GB897@n2100.arm.linux.org.uk>
 <201205041220.24747.arnd@arndb.de> <4FA40642.5040203@gmail.com>
 <20120504165603.GK897@n2100.arm.linux.org.uk>
Message-ID: <20120504164045.GH7788@game.jcrosoft.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 17:56 Fri 04 May     , Russell King - ARM Linux wrote:
> On Fri, May 04, 2012 at 11:39:30AM -0500, Rob Herring wrote:
> > Many of the headers are simply platform_data structs which may still be
> > needed on DT platforms, but could be moved elsewhere.
> 
> Those should be in include/linux/platform.
> 
> > >> Then there's also the problem of uncompress.h.  The last piece of the
> > >> puzzle is the common clock stuff.
> > 
> > The smp/hotplug/localtimer related functions are still global. Marc Z
> > has posted patches for this, but I haven't seen recent activity. This
> > and clocks were the 2 main issues I saw trying to build 2 platforms
> > together. highbank and picoxcell could be built together since only
> > highbank has clocks and smp.
> > 
> > gpio.h is still required, but empty for most platforms.
> 
> Those empty gpio.h files are definitely a candidate for going into
> arch/arm/include/mach/gpio.h, and then all those 12-byte mach/gpio.h can
> be deleted (13 files).
> 
> We've not had any progress on the gpio.h issue since I did the last round
> of cleanup; the next stage was to persuade SoC maintainers to get rid of
> their optimized versions which aren't compatible with multi-platform
> kernels.
> 
> I don't know if folk are expecting me to push that forwards or whether
> there's someone else working on that aspect of it...
> 
> So this issue really does need to be progressed too.
on at91 as we clean it for DT we will be able to drop it soon too

Best Regards
J.
