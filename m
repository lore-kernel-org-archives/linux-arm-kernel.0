From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 25 Oct 2012 13:35:23 +0000
Subject: [PATCH v3] ARM: mach-imx: Fix selection of ARCH_MXC
In-Reply-To: <20121025025117.GC2464@S2101-09.ap.freescale.net>
References: <1350583470-15500-1-git-send-email-fabio.estevam@freescale.com>
 <20121019150544.GD21078@S2101-09.ap.freescale.net>
 <20121025025117.GC2464@S2101-09.ap.freescale.net>
Message-ID: <201210251335.24066.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 25 October 2012, Shawn Guo wrote:
> On Fri, Oct 19, 2012 at 11:05:54PM +0800, Shawn Guo wrote:
> > On Thu, Oct 18, 2012 at 03:04:30PM -0300, Fabio Estevam wrote:
> > > Since commit c5a0d497(ARM: imx: enable multi-platform build),
> > > ARCH_MXC is selected by the following logic:
> > > 
> > > config ARCH_MXC
> > >         def_bool y if ARCH_MULTI_V4_V5 || ARCH_MULTI_V6_V7
> > > 
> > > , which causes build error on vexpress_defconfig:
> > > 
> > > arch/arm/mach-imx/hotplug.c:49: undefined reference to `imx_enable_cpu'
> > > arch/arm/mach-imx/platsmp.c:57: undefined reference to `imx_set_cpu_jump'
> > > arch/arm/mach-imx/platsmp.c:58: undefined reference to `imx_enable_cpu'
> > > 
> > > Make ARCH_MXC a user selectable option, so that it does not get built
> > > by default on other defconfigs that select ARCH_MULTI_V4_V5 or ARCH_MULTI_V6_V7.
> > > 
> > > Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
> > 
> > Arnd, Olof,
> > 
> > I just applied this patch on my imx/multi-platform.  Can you please
> > pull it to update the branch in arm-soc?  Thanks.
> > 
> I just applied another fix [1] on my branch.  Please pull both into
> arm-soc.  Thanks.


Pulled into imx/multiplatform and next/cleanup now.

Thanks,

	Arnd
