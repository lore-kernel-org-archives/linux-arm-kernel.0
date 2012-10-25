From: shawn.guo@linaro.org (Shawn Guo)
Date: Thu, 25 Oct 2012 10:51:22 +0800
Subject: [PATCH v3] ARM: mach-imx: Fix selection of ARCH_MXC
In-Reply-To: <20121019150544.GD21078@S2101-09.ap.freescale.net>
References: <1350583470-15500-1-git-send-email-fabio.estevam@freescale.com>
 <20121019150544.GD21078@S2101-09.ap.freescale.net>
Message-ID: <20121025025117.GC2464@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Oct 19, 2012 at 11:05:54PM +0800, Shawn Guo wrote:
> On Thu, Oct 18, 2012 at 03:04:30PM -0300, Fabio Estevam wrote:
> > Since commit c5a0d497(ARM: imx: enable multi-platform build),
> > ARCH_MXC is selected by the following logic:
> > 
> > config ARCH_MXC
> >         def_bool y if ARCH_MULTI_V4_V5 || ARCH_MULTI_V6_V7
> > 
> > , which causes build error on vexpress_defconfig:
> > 
> > arch/arm/mach-imx/hotplug.c:49: undefined reference to `imx_enable_cpu'
> > arch/arm/mach-imx/platsmp.c:57: undefined reference to `imx_set_cpu_jump'
> > arch/arm/mach-imx/platsmp.c:58: undefined reference to `imx_enable_cpu'
> > 
> > Make ARCH_MXC a user selectable option, so that it does not get built
> > by default on other defconfigs that select ARCH_MULTI_V4_V5 or ARCH_MULTI_V6_V7.
> > 
> > Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
> 
> Arnd, Olof,
> 
> I just applied this patch on my imx/multi-platform.  Can you please
> pull it to update the branch in arm-soc?  Thanks.
> 
I just applied another fix [1] on my branch.  Please pull both into
arm-soc.  Thanks.

Shawn

[1] http://article.gmane.org/gmane.linux.ports.arm.kernel/195009

------

The following changes since commit c5a0d4977f00ca18c49d46fdaff4b2cfeaa4eb28:

  ARM: imx: enable multi-platform build (2012-10-15 10:10:15 +0800)

are available in the git repository at:

  git://git.linaro.org/people/shawnguo/linux-2.6.git imx/multi-platform

for you to fetch changes up to 68b25325a7fd290b5e472bba0df9cbe8c1a81d8f:

  ARM: imx: select HAVE_IMX_SRC when SMP is enabled (2012-10-23 15:37:51 +0800)

----------------------------------------------------------------
Fabio Estevam (1):
      ARM: mach-imx: Fix selection of ARCH_MXC

Shawn Guo (1):
      ARM: imx: select HAVE_IMX_SRC when SMP is enabled

 arch/arm/configs/imx_v4_v5_defconfig |    1 +
 arch/arm/configs/imx_v6_v7_defconfig |    1 +
 arch/arm/mach-imx/Kconfig            |    5 ++---
 3 files changed, 4 insertions(+), 3 deletions(-)
