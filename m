From: k.kozlowski@samsung.com (Krzysztof Kozlowski)
Date: Mon, 14 Jul 2014 14:55:16 +0200
Subject: [PATCH] ARM: EXYNOS: Fix MCPM build with SUSPEND=n
In-Reply-To: <alpine.LFD.2.11.1407140730080.3647@knanqh.ubzr>
References: <1405337093-15377-1-git-send-email-k.kozlowski@samsung.com>
 <alpine.LFD.2.11.1407140730080.3647@knanqh.ubzr>
Message-ID: <1405342516.13970.0.camel@AMDC1943>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On pon, 2014-07-14 at 07:35 -0400, Nicolas Pitre wrote:
> On Mon, 14 Jul 2014, Krzysztof Kozlowski wrote:
> 
> > Building of EXYNOS5420_MCPM with disabled SUSPEND fails:
> > arch/arm/mach-exynos/built-in.o: In function `exynos_mcpm_init':
> > arch/arm/mach-exynos/mcpm-exynos.c:361: undefined reference to `mcpm_loopback'
> > 
> > The exynos_mcpm_init() in mcp-exynos.c calls mcpm_loopback() which
> > depends on cpu_suspend function (ARM_CPU_SUSPEND).
> > 
> > Signed-off-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
> > Cc: <stable@vger.kernel.org>
> 
> No need to CC stable here as this code has not reached a released kernel 
> yet.
> 
> > Fixes: a6a4d3152e3cbb6 ("ARM: 8083/1: exynos: activate the CCI on boot CPU/cluster using the MCPM loopback")
> 
> And this is not clear yet if this commit ID is stable.
> 
> Other than that:
> 
> Acked-by: Nicolas Pitre <nico@linaro.org>
> 
> Please send to RMK's patch system.

Sure, I'll remove the cc-stable tag, add your ack and send to the patch
system.

Thanks,
Krzysztof

> 
> 
> > ---
> >  arch/arm/mach-exynos/Kconfig | 1 +
> >  1 file changed, 1 insertion(+)
> > 
> > diff --git a/arch/arm/mach-exynos/Kconfig b/arch/arm/mach-exynos/Kconfig
> > index 8f9b66c4ac78..5d4ff6571dcd 100644
> > --- a/arch/arm/mach-exynos/Kconfig
> > +++ b/arch/arm/mach-exynos/Kconfig
> > @@ -119,6 +119,7 @@ config EXYNOS5420_MCPM
> >  	bool "Exynos5420 Multi-Cluster PM support"
> >  	depends on MCPM && SOC_EXYNOS5420
> >  	select ARM_CCI
> > +	select ARM_CPU_SUSPEND
> >  	help
> >  	  This is needed to provide CPU and cluster power management
> >  	  on Exynos5420 implementing big.LITTLE.
> > -- 
> > 1.9.1
> > 
> > 
