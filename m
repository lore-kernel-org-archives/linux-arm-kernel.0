From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Sun, 11 Aug 2013 23:05:41 +0100
Subject: [RFC PATCH] ARM: dma: default ZONE_DMA to y if ARM_LPAE
In-Reply-To: <20130811215112.GB26757@quad.lixom.net>
References: <1374843951-1615-1-git-send-email-will.deacon@arm.com>
 <20130811215112.GB26757@quad.lixom.net>
Message-ID: <20130811220541.GZ23006@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Aug 11, 2013 at 02:51:12PM -0700, Olof Johansson wrote:
> On Fri, Jul 26, 2013 at 02:05:51PM +0100, Will Deacon wrote:
> > On systems running with LPAE enabled, DMA masters capable only of 32-bit
> > addressing require ZONE_DMA to be set. Given the proliferation of such
> > masters, and the tendency to re-use existing system IP with newer
> > processors, this patch defaults ZONE_DMA to y if ARM_LPAE, rather than
> > force each SoC to select it individually.
> > 
> > Cc: Olof Johansson <olof@lixom.net>
> > Signed-off-by: Will Deacon <will.deacon@arm.com>
> > ---
> >  arch/arm/Kconfig | 1 +
> >  1 file changed, 1 insertion(+)
> > 
> > diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
> > index 82f06982..7fede35 100644
> > --- a/arch/arm/Kconfig
> > +++ b/arch/arm/Kconfig
> > @@ -192,6 +192,7 @@ config ARCH_MAY_HAVE_PC_FDC
> >  
> >  config ZONE_DMA
> >  	bool
> > +	default y if ARM_LPAE
> 
> I guess you could bikeshed over this vs selecting it from ARM_LPAE, but either
> way gets the work done. I don't have a preference.
> 
> Acked-by: Olof Johansson <olof@lixom.net>
> 
> ..for Russell's patch tracker?

No.  As I keep telling people, go look at my dma-mask patches and stop
papering over this problem.
