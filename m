From: dave.martin@linaro.org (Dave Martin)
Date: Wed, 14 Dec 2011 15:01:19 +0000
Subject: [PATCH v4 REPOST 5/5] imx6q: Remove unconditional dependency on
 l2x0 L2 cache support
In-Reply-To: <20111214140500.GA1700@richard-laptop>
References: <1323862781-3465-1-git-send-email-dave.martin@linaro.org>
 <1323862781-3465-6-git-send-email-dave.martin@linaro.org>
 <20111214132622.GA1520@S2100-06.ap.freescale.net>
 <20111214140500.GA1700@richard-laptop>
Message-ID: <20111214150119.GD2568@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Dec 14, 2011 at 10:05:04PM +0800, Richard Zhao wrote:
> On Wed, Dec 14, 2011 at 09:26:24PM +0800, Shawn Guo wrote:
> > Hi Dave,
> > 
> > Sorry for that I did not look into previous post to point it out.
> > 
> > On Wed, Dec 14, 2011 at 11:39:41AM +0000, Dave Martin wrote:
> > > The i.MX6 Quad SoC will work without the l2x0 L2 cache controller
> > > support built into the kernel, so this patch removes the dependency
> > > on CACHE_L2X0 and selects MIGHT_HAVE_CACHE_L2X0 instead.
> > > 
> > > This makes the l2x0 support optional, so that it can be turned off
> > > when desired for debugging purposes etc.
> > > 
> > > Thanks to Shawn Guo for this suggestion. [1]
> > > 
> > > Signed-off-by: Dave Martin <dave.martin@linaro.org>
> > > 
> > > [1] http://lists.infradead.org/pipermail/linux-arm-kernel/2011-November/074602.html
> > > ---
> > >  arch/arm/mach-imx/Kconfig |    2 +-
> > >  1 files changed, 1 insertions(+), 1 deletions(-)
> > > 
> > > diff --git a/arch/arm/mach-imx/Kconfig b/arch/arm/mach-imx/Kconfig
> > > index 29a3d61..1fb93f2 100644
> > > --- a/arch/arm/mach-imx/Kconfig
> > > +++ b/arch/arm/mach-imx/Kconfig
> > > @@ -609,13 +609,13 @@ comment "i.MX6 family:"
> > >  config SOC_IMX6Q
> > >  	bool "i.MX6 Quad support"
> > >  	select ARM_GIC
> > > -	select CACHE_L2X0
> > >  	select CPU_V7
> > >  	select HAVE_ARM_SCU
> > >  	select HAVE_IMX_GPC
> > >  	select HAVE_IMX_MMDC
> > >  	select HAVE_IMX_SRC
> > >  	select HAVE_SMP
> > > +	select MIGHT_HAVE_CACHE_L2X0
> > 
> > The option SOC_IMX6Q is only available when ARCH_IMX_V6_V7 is selected.
> > Since MIGHT_HAVE_CACHE_L2X0 has been selected by ARCH_IMX_V6_V7 in
> > patch #1, this line seems redundant here.
> Would it be better keep this one and remove patch #1 one? imx5 doesn't have
> l2x0.

Do you mean to remove MIGHT_HAVE_CACHE_L2X0 from ARCH_IMX_V6_V7, and select
it only from SOC_IMX6Q?

Cheers
---Dave
