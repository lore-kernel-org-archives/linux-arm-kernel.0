From: christoffer.dall@linaro.org (Christoffer Dall)
Date: Fri, 10 Oct 2014 23:03:02 +0200
Subject: [PATCH v3 3/3] arm64: Allow 48-bits VA space without ARM_SMMU
In-Reply-To: <20141010151053.GC7758@e104818-lin.cambridge.arm.com>
References: <1412936070-18860-1-git-send-email-christoffer.dall@linaro.org>
 <1412936070-18860-4-git-send-email-christoffer.dall@linaro.org>
 <20141010151053.GC7758@e104818-lin.cambridge.arm.com>
Message-ID: <20141010210302.GD3717@cbox>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Oct 10, 2014 at 04:10:53PM +0100, Catalin Marinas wrote:
> On Fri, Oct 10, 2014 at 11:14:30AM +0100, Christoffer Dall wrote:
> > Now when KVM has been reworked to support 48-bits host VA space, we can
> > allow systems to be configured with this option.  However, the ARM SMMU
> > driver also needs to be tweaked for 48-bit support so only allow the
> > config option to be set when not including support for theSMMU.
> > 
> > Signed-off-by: Christoffer Dall <christoffer.dall@linaro.org>
> > ---
> >  arch/arm64/Kconfig | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
> > index fd4e81a..a76c6c3b 100644
> > --- a/arch/arm64/Kconfig
> > +++ b/arch/arm64/Kconfig
> > @@ -200,7 +200,7 @@ config ARM64_VA_BITS_42
> >  
> >  config ARM64_VA_BITS_48
> >  	bool "48-bit"
> > -	depends on BROKEN
> > +	depends on !ARM_SMMU
> >  
> >  endchoice
> 
> I think we should rather merge this separately via the arm64 tree once
> we test 48-bit VA some more (and as you noticed, there is a bug
> already).
> 
Sounds like a good idea, I'll apply the other two to kvmarm.

Thanks for the reviews!

-Christoffer
