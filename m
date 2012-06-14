From: tixy@linaro.org (Jon Medhurst (Tixy))
Date: Thu, 14 Jun 2012 08:32:47 +0100
Subject: [PATCH 2/2] ARM: vexpress: Enable selection of SPARSE_IRQ
In-Reply-To: <4FD8E899.8080207@gmail.com>
References: <1339607602-3846-1-git-send-email-tixy@linaro.org>
 <1339607602-3846-3-git-send-email-tixy@linaro.org>
 <4FD8E899.8080207@gmail.com>
Message-ID: <1339659167.3044.3.camel@linaro1.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 2012-06-13 at 14:23 -0500, Rob Herring wrote:
> On 06/13/2012 12:13 PM, Jon Medhurst (Tixy) wrote:
> > From: Jon Medhurst <tixy@linaro.org>
> > 
> > This is required to add vexpress to multiplatform kernels containing
> > other boards which require SPARSE_IRQ.
> > 
> > Signed-off-by: Jon Medhurst <tixy@linaro.org>
> > ---
> >  arch/arm/Kconfig |    1 +
> >  1 file changed, 1 insertion(+)
> > 
> > diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
> > index 84449dd..bdede09 100644
> > --- a/arch/arm/Kconfig
> > +++ b/arch/arm/Kconfig
> > @@ -311,6 +311,7 @@ config ARCH_VEXPRESS
> >  	select HAVE_CLK
> >  	select HAVE_PATA_PLATFORM
> >  	select ICST
> > +	select MAY_HAVE_SPARSE_IRQ
> 
> Why not always select SPARSE_IRQ and remove mach/irqs.h?

I did consider that but my conservative side won out. If there are no
real downsides to sparse irqs that people would object to then I'm happy
to unconditionally enable it. (I'll post a v2 patch that does this.)

-- 
Tixy
