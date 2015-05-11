From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 11 May 2015 15:07:37 +0100
Subject: [PATCH] arm-cci: Do not enable CCI-400 PMU by default
In-Reply-To: <1431348626-2767-1-git-send-email-suzuki.poulose@arm.com>
References: <1431348626-2767-1-git-send-email-suzuki.poulose@arm.com>
Message-ID: <20150511140736.GF2067@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, May 11, 2015 at 01:50:26PM +0100, Suzuki K. Poulose wrote:
>  config ARM_CCI400_PMU
>  	bool "ARM CCI400 PMU support"
> -	default y
>  	depends on ARM || ARM64
> -	depends on HW_PERF_EVENTS
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

This still needs to be better.  How do I know whether it should be enabled
for my platform or not?

Presumably, we can say that CCI-400 does not appear on CPUs older than X,
which means we can add "The CCI-400 may be provided on ARM CPUs X or
later."

I doubt that you'll find CCI-400 on ARMv6 or older ARM architectures for
example.  Maybe then we need "depends on ARM || ARM64" to be tighter?
"depends on (ARM && CPU_V7) || ARM64" ?

-- 
FTTC broadband for 0.8mile line: currently at 10.5Mbps down 400kbps up
according to speedtest.net.
