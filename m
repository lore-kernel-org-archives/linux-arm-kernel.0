From: punit.agrawal@arm.com (Punit Agrawal)
Date: Mon, 18 May 2015 17:06:26 +0100
Subject: [PATCHv2] arm-cci: Do not enable CCI-400 PMU by default
In-Reply-To: <1431425521-10639-1-git-send-email-suzuki.poulose@arm.com>
 (Suzuki K. Poulose's message of "Tue, 12 May 2015 11:12:01 +0100")
References: <1431425521-10639-1-git-send-email-suzuki.poulose@arm.com>
Message-ID: <9hhd21xx43h.fsf@e105922-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

"Suzuki K. Poulose" <suzuki.poulose@arm.com> writes:

> From: "Suzuki K. Poulose" <suzuki.poulose@arm.com>
>
> Do not enable CCI-400 PMU by default and fix the dependency on PERF_EVENTS
> than HW_PERF_EVENTS.
>
> Reported-by: Russell King <rmk+kernel@arm.linux.org.uk>
> Cc: Will Deacon <will.deacon@arm.com>
> Cc: arm at kernel.org
> Cc: Russell King <rmk+kernel@arm.linux.org.uk>
> Signed-off-by: Suzuki K. Poulose <suzuki.poulose@arm.com>

This seems fine. Assuming Russell has no further comments -

Acked-by: Punit Agrawal <punit.agrawal@arm.com>

> ---
> Changes since V1:
>  - Make CCI400_PMU depend on CPU_V7 for ARM (Suggested by: Russell)
> ---
>  drivers/bus/Kconfig |   12 +++++-------
>  1 file changed, 5 insertions(+), 7 deletions(-)
>
> diff --git a/drivers/bus/Kconfig b/drivers/bus/Kconfig
> index a1d4af6..a6b37d4 100644
> --- a/drivers/bus/Kconfig
> +++ b/drivers/bus/Kconfig
> @@ -13,15 +13,13 @@ config ARM_CCI400_COMMON
>  
>  config ARM_CCI400_PMU
>  	bool "ARM CCI400 PMU support"
> -	default y
> -	depends on ARM || ARM64
> -	depends on HW_PERF_EVENTS
> +	depends on (ARM && CPU_V7) || ARM64
> +	depends on PERF_EVENTS
>  	select ARM_CCI400_COMMON
>  	help
> -	  Support for PMU events monitoring on the ARM CCI cache coherent
> -	  interconnect.
> -
> -	  If unsure, say Y
> +	  Support for PMU events monitoring on the ARM CCI-400 (cache coherent
> +	  interconnect). CCI-400 supports counting events related to the
> +	  connected slave/master interfaces.
>  
>  config ARM_CCI400_PORT_CTRL
>  	bool
