From: pawel.moll@arm.com (Pawel Moll)
Date: Mon, 08 Oct 2012 13:15:56 +0100
Subject: [PATCH] ARM: Push selects for TWD/SCU into machine entries
In-Reply-To: <1349340644-13937-1-git-send-email-sboyd@codeaurora.org>
References: <1349340644-13937-1-git-send-email-sboyd@codeaurora.org>
Message-ID: <1349698556.4322.18.camel@hornet>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 2012-10-04 at 09:50 +0100, Stephen Boyd wrote:
> The TWD and SCU configs are selected by default as long as
> SCORPIONMP is false and/or MCT is false. Implementing the logic
> this way certainly saves lines in the Kconfig but it precludes
> those machines which select SCORPIONMP or MCT from participating
> in the single zImage effort because when those machines are
> combined with other SMP capable machines the TWD and SCU are no
> longer selected.
> 
> Push the select out to the machine entries so that we can compile
> these machines together and still select the appropriate configs.
[...]
> diff --git a/arch/arm/mach-vexpress/Kconfig b/arch/arm/mach-vexpress/Kconfig
> index c952960..4f8e0db 100644
> --- a/arch/arm/mach-vexpress/Kconfig
> +++ b/arch/arm/mach-vexpress/Kconfig
> @@ -11,6 +11,8 @@ config ARCH_VEXPRESS
>  	select HAVE_CLK
>  	select HAVE_PATA_PLATFORM
>  	select HAVE_SMP
> +	select HAVE_ARM_SCU if SMP
> +	select HAVE_ARM_TWD if LOCAL_TIMERS
>  	select ICST
>  	select MIGHT_HAVE_CACHE_L2X0
>  	select NO_IOPORT

If you move these two lines before HAVE_CLK so everything stays in
alphabetical order ;-) you can add my Acked-by for vexpress:

Acked-by: Pawel Moll <pawel.moll@arm.com>

Thanks!

Pawel
