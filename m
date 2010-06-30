From: kirill@shutemov.name (Kirill A. Shutemov)
Date: Wed, 30 Jun 2010 22:49:42 +0300
Subject: [PATCH 02/33] Removing dead ARCH_DAVINCI_TNETV107X
In-Reply-To: <20100630170730.GE23534@tarshish>
References: <cover.1277911345.git.siccegge@cs.fau.de>
	<88ee583babc6f0aecb2238a57644f64159d5c395.1277911346.git.siccegge@cs.fau.de>
	<20100630170730.GE23534@tarshish>
Message-ID: <20100630194942.GB3969@shutemov.name>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jun 30, 2010 at 08:07:31PM +0300, Baruch Siach wrote:
> Hi Christoph,
> 
> On Wed, Jun 30, 2010 at 06:05:38PM +0200, Christoph Egger wrote:
> > ARCH_DAVINCI_TNETV107X doesn't exist in Kconfig, therefore removing
> > all references for it from the source code.
> > 
> > Signed-off-by: Christoph Egger <siccegge@cs.fau.de>
> > ---
> >  arch/arm/mach-davinci/include/mach/cputype.h |    6 ------
> >  1 files changed, 0 insertions(+), 6 deletions(-)
> > 
> > diff --git a/arch/arm/mach-davinci/include/mach/cputype.h b/arch/arm/mach-davinci/include/mach/cputype.h
> > index cea6b89..6143022 100644
> > --- a/arch/arm/mach-davinci/include/mach/cputype.h
> > +++ b/arch/arm/mach-davinci/include/mach/cputype.h
> > @@ -85,10 +85,4 @@ IS_DAVINCI_CPU(tnetv107x, DAVINCI_CPU_ID_TNETV107X)
> >  #define cpu_is_davinci_da850() 0
> >  #endif
> >  
> > -#ifdef CONFIG_ARCH_DAVINCI_TNETV107X
> > -#define cpu_is_davinci_tnetv107x() is_davinci_tnetv107x()
> > -#else
> > -#define cpu_is_davinci_tnetv107x() 0
> 
> Why remove the #else part?

Nobody uses cpu_is_davinci_tnetv107x as well.

Acked-by: Kirill A. Shutemov <kirill@shutemov.name>

-- 
 Kirill A. Shutemov
