From: pawel.moll@arm.com (Pawel Moll)
Date: Mon, 05 Nov 2012 14:43:18 +0000
Subject: vexpress issues in next-20121029
In-Reply-To: <20121105094511.GE28327@n2100.arm.linux.org.uk>
References: <508EE610.9050703@wwwdotorg.org> <1351613819.6199.14.camel@hornet>
 <20121105093532.GC28327@n2100.arm.linux.org.uk>
 <20121105094511.GE28327@n2100.arm.linux.org.uk>
Message-ID: <1352126598.10947.13.camel@hornet>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 2012-11-05 at 09:45 +0000, Russell King - ARM Linux wrote:
> On Mon, Nov 05, 2012 at 09:35:32AM +0000, Russell King - ARM Linux wrote:
> > On Tue, Oct 30, 2012 at 04:16:59PM +0000, Pawel Moll wrote:
> > > There was a glitch between clk-next and arm-soc - it should be fine
> > > starting with next-20121030.
> > 
> > The problem is still there - my builds of my tree plus arm-soc are
> > continuing to fail with:
> > 
> > arch/arm/mach-vexpress/built-in.o: In function `v2m_timer_init':
> > reset.c:(.init.text+0xe0): undefined reference to `vexpress_clk_init'
> > arch/arm/mach-vexpress/built-in.o: In function `v2m_dt_timer_init':
> > reset.c:(.init.text+0x114): undefined reference to `vexpress_clk_of_init'
> > 
> > My guess is you have a dependency between the clk-next tree and arm-soc
> > which you haven't told the arm-soc people about.
> 
> Oh, and the above seems to affect all my kautobuilds for any ARM Ltd
> development platform - it's not just vexpress which is affected by this
> anymore.

I've just successfully built defconfigs for vexpress, versatile and
realview with next-20121105 so I guess Arnd simply didn't have time last
week (the Connect event) to sort out the arm-soc tree...

Arnd, will you pull the vexpress-clk-soc (containing, as you suggested,
the soc stuff rebased on top of the clk branch) or do you want me to do
something else?

Thanks!

Pawe?
