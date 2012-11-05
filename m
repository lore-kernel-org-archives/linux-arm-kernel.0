From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 5 Nov 2012 09:35:32 +0000
Subject: vexpress issues in next-20121029
In-Reply-To: <1351613819.6199.14.camel@hornet>
References: <508EE610.9050703@wwwdotorg.org> <1351613819.6199.14.camel@hornet>
Message-ID: <20121105093532.GC28327@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Oct 30, 2012 at 04:16:59PM +0000, Pawel Moll wrote:
> Hi Stephen,
> 
> On Mon, 2012-10-29 at 20:24 +0000, Stephen Warren wrote:
> > 1) At compile-time: v2m_timer_init() and v2m_dt_timer_init() reference
> > functions vexpress_clk_init() and vexpress_clk_of_init() respectively,
> > which don't appear anywhere in the source tree.
> 
> There was a glitch between clk-next and arm-soc - it should be fine
> starting with next-20121030.

The problem is still there - my builds of my tree plus arm-soc are
continuing to fail with:

arch/arm/mach-vexpress/built-in.o: In function `v2m_timer_init':
reset.c:(.init.text+0xe0): undefined reference to `vexpress_clk_init'
arch/arm/mach-vexpress/built-in.o: In function `v2m_dt_timer_init':
reset.c:(.init.text+0x114): undefined reference to `vexpress_clk_of_init'

My guess is you have a dependency between the clk-next tree and arm-soc
which you haven't told the arm-soc people about.
