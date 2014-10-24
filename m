From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 24 Oct 2014 11:52:19 +0100
Subject: gcc 4.9 build warnings (was: Re: arm-soc build: 2917 warnings 0
 failures (arm-soc/v3.18-rc1-20-g06c0773))
In-Reply-To: <3042812.F54XYg3Q4M@wuerfel>
References: <544a2a2e.a2db440a.6eeb.ffffaef3@mx.google.com>
 <3042812.F54XYg3Q4M@wuerfel>
Message-ID: <20141024105219.GP27405@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Oct 24, 2014 at 12:49:50PM +0200, Arnd Bergmann wrote:
> On Friday 24 October 2014 03:30:06 Olof's autobuilder wrote:
> > Here are the build results from automated periodic testing.
> > 
> > The tree being built was arm-soc, found at:
> > 
> > http://git.kernel.org/cgit/linux/kernel/git/arm/arm-soc.git (for-next or to-build branch)
> > 
> > Topmost commit:
> > 
> > 06c0773 [EXPERIMENTAL] try to get Linux to build with bare-metal toolchain
> 
> This appears to have fixed one problem but not the other:
> 
> > Build logs (stderr only) can be found at the following link (experimental):
> > 
> > http://arm-soc.lixom.net/buildlogs/arm-soc/v3.18-rc1-20-g06c0773/
> > 
> > 
> > 	Runtime:		57m 11s
> > 
> > 	Passed:			129
> > 	Failed:			0
> > 
> > 	Warnings:		2917
> > 
> > 	Section mismatches:	0
> > 
> > -------------------------------------------------------------------------------
> > 
> > Failed defconfigs:
> > 
> > -------------------------------------------------------------------------------
> > 
> > Errors:
> 
> All build errors are gone now, after passing -D__linux__. That is good.
> 
> >       1 drivers/video/fbdev/sm501fb.c:245:2: warning: format '%zd' expects argument of type 'signed size_t', but argument 8 has type 'size_t' [-Wformat=]
> >       1 mm/percpu.c:895:3: warning: format '%zu' expects argument of type 'size_t', but argument 2 has type 'unsigned int' [-Wformat=]
> >       1 mm/percpu.c:895:3: warning: format '%zu' expects argument of type 'size_t', but argument 3 has type 'unsigned int' [-Wformat=]
> 
> The warnings are completely unchanged, still 249 unique warnings involving size_t,
> using this patch:

That's probably because the compiler is expecting size_t to be typedef'd
to __SIZE_TYPE__ and isn't expecting anyone to change it.

-- 
FTTC broadband for 0.8mile line: currently at 9.5Mbps down 400kbps up
according to speedtest.net.
