From: tony@atomide.com (Tony Lindgren)
Date: Mon, 24 Sep 2012 17:37:58 -0700
Subject: [PATCH] arm: make FORCE_MAX_ZONEORDER configurable for TI AM33XX
In-Reply-To: <20120924231619.GA28941@n2100.arm.linux.org.uk>
References: <1341325242-17638-1-git-send-email-yegorslists@googlemail.com>
 <20120924171858.GG28835@atomide.com>
 <CAGm1_ks_GvSTH8DJ6d3R5OjPNEOhQ39hNo4grg1Pn-NqFX5VKQ@mail.gmail.com>
 <20120924231619.GA28941@n2100.arm.linux.org.uk>
Message-ID: <20120925003758.GP28835@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Russell King - ARM Linux <linux@arm.linux.org.uk> [120924 16:17]:
> On Mon, Sep 24, 2012 at 09:05:11PM +0200, Yegor Yefremov wrote:
> > On Mon, Sep 24, 2012 at 7:18 PM, Tony Lindgren <tony@atomide.com> wrote:
> > > * yegorslists at googlemail.com <yegorslists@googlemail.com> [120703 07:26]:
> > >> From: Yegor Yefremov <yegorslists@googlemail.com>
> > >>
> > >> FORCE_MAX_ZONEORDER of 12 is needed to allocation more than 4MB
> > >> of consistent DMA memory (da8xx frame buffer driver).
> > >
> > > Sorry for the delay on this one, looks like this one is
> > > still valid. I'll apply it.
> > 
> > Thanks.
> > 
> > Yegor
> > 
> > >> Signed-off-by: Dejan Gacnik <dejan.gacnik@gmail.com>
> > >> Signed-off-by: Yegor Yefremov <yegorslists@googlemail.com>
> > >> ---
> > >>  arch/arm/Kconfig |    5 +++--
> > >>  1 files changed, 3 insertions(+), 2 deletions(-)
> > >>
> > >> diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
> > >> index e876819..ff14c1e 100644
> > >> --- a/arch/arm/Kconfig
> > >> +++ b/arch/arm/Kconfig
> > >> @@ -1725,8 +1725,9 @@ config HW_PERF_EVENTS
> > >>  source "mm/Kconfig"
> > >>
> > >>  config FORCE_MAX_ZONEORDER
> > >> -     int "Maximum zone order" if ARCH_SHMOBILE
> > >> -     range 11 64 if ARCH_SHMOBILE
> > >> +     int "Maximum zone order"
> > >> +     depends on ARCH_SHMOBILE || SOC_AM33XX
> > >> +     range 11 64 if ARCH_SHMOBILE || SOC_AM33XX
> > >>       default "9" if SA1111
> > >>       default "11"
> 
> NAK.  This patch breaks SA1111 platforms.  To see why, read the patch.

OK let's drop this.

Tony
