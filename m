From: nicolas.pitre@linaro.org (Nicolas Pitre)
Date: Fri, 5 Apr 2013 12:15:55 -0400 (EDT)
Subject: [PATCH v6 2/4] arm: prefer psci_smp_ops over mdesc->smp
In-Reply-To: <1365167495-18508-2-git-send-email-stefano.stabellini@eu.citrix.com>
References: <alpine.DEB.2.02.1304031239550.5078@kaball.uk.xensource.com>
 <1365167495-18508-2-git-send-email-stefano.stabellini@eu.citrix.com>
Message-ID: <alpine.LFD.2.03.1304051215270.1171@syhkavp.arg>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 5 Apr 2013, Stefano Stabellini wrote:

> If PSCI is available on the platform, prefer psci_smp_ops over the
> platform smp_ops.
> 
> Signed-off-by: Stefano Stabellini <stefano.stabellini@eu.citrix.com>

Acked-by: Nicolas Pitre <nico@linaro.org>

> ---
>  arch/arm/kernel/setup.c |    6 +++---
>  1 files changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/arm/kernel/setup.c b/arch/arm/kernel/setup.c
> index 341efaa..dad3048 100644
> --- a/arch/arm/kernel/setup.c
> +++ b/arch/arm/kernel/setup.c
> @@ -770,10 +770,10 @@ void __init setup_arch(char **cmdline_p)
>  	psci_init();
>  #ifdef CONFIG_SMP
>  	if (is_smp()) {
> -		if (mdesc->smp)
> -			smp_set_ops(mdesc->smp);
> -		else if (psci_smp_available())
> +		if (psci_smp_available())
>  			smp_set_ops(&psci_smp_ops);
> +		else if (mdesc->smp)
> +			smp_set_ops(mdesc->smp);
>  		smp_init_cpus();
>  	}
>  #endif
> -- 
> 1.7.2.5
> 
