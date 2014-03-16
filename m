From: ezequiel.garcia@free-electrons.com (Ezequiel Garcia)
Date: Sun, 16 Mar 2014 04:09:17 -0300
Subject: [PATCH v7 2/2] ARM hibernation / suspend-to-disk
In-Reply-To: <1394016605-24120-3-git-send-email-sebastian.capella@linaro.org>
References: <1394016605-24120-1-git-send-email-sebastian.capella@linaro.org>
 <1394016605-24120-3-git-send-email-sebastian.capella@linaro.org>
Message-ID: <20140316070917.GA3094@arch.cereza>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mar 05, Sebastian Capella wrote:
[..]
> diff --git a/arch/arm/mm/Kconfig b/arch/arm/mm/Kconfig
> index 1f8fed9..83707702 100644
> --- a/arch/arm/mm/Kconfig
> +++ b/arch/arm/mm/Kconfig
> @@ -611,6 +611,11 @@ config CPU_USE_DOMAINS
>  config IO_36
>  	bool
>  
> +config ARCH_HIBERNATION_POSSIBLE
> +	bool
> +	depends on MMU
> +	default y if CPU_ARM920T || CPU_ARM926T || CPU_SA1100 || CPU_XSCALE || CPU_XSC3 || CPU_V6 || CPU_V6K || CPU_V7
> +
>  comment "Processor Features"
>  

Is there any reason why CPU_FEROCEON is not listed here? FWIW, I've just built
(but not really tested) a Kirkwood kernel with CONFIG_HIBERNATION=y.

And is there any reason to put this config in arch/arm/mm/Kconfig, instead of
in arch/arm/Kconfig, below ARCH_SUSPEND_POSSIBLE? 

I'm also puzzled about having two separate options for suspend and hibernate,
maybe someone can explain me why a given CPU would support the former but not
the latter?

Thanks!
-- 
Ezequiel Garc?a, Free Electrons
Embedded Linux, Kernel and Android Engineering
http://free-electrons.com
