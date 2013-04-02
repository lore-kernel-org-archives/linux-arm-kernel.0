From: mark.rutland@arm.com (Mark Rutland)
Date: Tue, 2 Apr 2013 09:41:39 +0100
Subject: [PATCHv3 03/10] ARM: smp_twd: Divorce smp_twd from local timer API
In-Reply-To: <5154A37B.1070407@codeaurora.org>
References: <1363198676-30417-1-git-send-email-sboyd@codeaurora.org>
 <1363198676-30417-4-git-send-email-sboyd@codeaurora.org>
 <20130328152255.GD30477@e106331-lin.cambridge.arm.com>
 <5154A37B.1070407@codeaurora.org>
Message-ID: <20130402084138.GG30477@e106331-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Mar 28, 2013 at 08:09:31PM +0000, Stephen Boyd wrote:
> On 03/28/13 08:22, Mark Rutland wrote:
> > This works on my A9x4 coretile, bringing CPUs up and down via
> > /sys/devices/system/cpu/*/online, so:
> >
> > Tested-by: Mark Rutland <mark.rutland@arm.com>
> 
> Thanks. I still need to resolve patch #1 though.
> 
> >
> > Otherwise, is there any reason we couldn't now use the twd driver on a UP
> > system? Or would the overhead of handling frequency change make this pointless?
> 
> I don't see why not but I don't have any interest in pursuing it.

Ok.

> 
> >
> > On Wed, Mar 13, 2013 at 06:17:49PM +0000, Stephen Boyd wrote:
> >> diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
> >> index 5b71469..5ad2ccf 100644
> >> --- a/arch/arm/Kconfig
> >> +++ b/arch/arm/Kconfig
> >> @@ -1527,6 +1527,7 @@ config SMP
> >>  	depends on HAVE_SMP
> >>  	depends on MMU
> >>  	select HAVE_ARM_SCU if !ARCH_MSM_SCORPIONMP
> >> +	select HAVE_ARM_TWD if (!ARCH_MSM_SCORPIONMP && !EXYNOS4_MCT)
> > Could you not depend on your "Push selects for TWD/SCU into machine entries"
> > for this?
> 
> Right now the patches don't depend on the push down patch. Are you
> saying it would be better to depend on that patch?

It just seemed odd to me that the two series should conflict (though
trivially) here.

Mark.
