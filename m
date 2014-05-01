From: catalin.marinas@arm.com (Catalin Marinas)
Date: Thu, 1 May 2014 12:11:21 +0100
Subject: [RFC PATCH V4 3/7] arm: mm: Enable HAVE_RCU_TABLE_FREE logic
In-Reply-To: <1396018892-6773-4-git-send-email-steve.capper@linaro.org>
References: <1396018892-6773-1-git-send-email-steve.capper@linaro.org>
 <1396018892-6773-4-git-send-email-steve.capper@linaro.org>
Message-ID: <20140501111120.GF22316@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Mar 28, 2014 at 03:01:28PM +0000, Steve Capper wrote:
> diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
> index 1594945..7d5340d 100644
> --- a/arch/arm/Kconfig
> +++ b/arch/arm/Kconfig
> @@ -58,6 +58,7 @@ config ARM
>  	select HAVE_PERF_EVENTS
>  	select HAVE_PERF_REGS
>  	select HAVE_PERF_USER_STACK_DUMP
> +	select HAVE_RCU_TABLE_FREE if SMP

You select this if (SMP && CPU_V7). On ARMv6 SMP systems we use IPI for
TLB maintenance already.

-- 
Catalin
