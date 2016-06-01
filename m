From: timur@codeaurora.org (Timur Tabi)
Date: Wed, 1 Jun 2016 11:03:41 -0500
Subject: [PATCH v5 5/6] clocksource/drivers/arm_arch_timer: Simplify ACPI
 support code.
In-Reply-To: <1464096633-9309-6-git-send-email-fu.wei@linaro.org>
References: <1464096633-9309-1-git-send-email-fu.wei@linaro.org>
 <1464096633-9309-6-git-send-email-fu.wei@linaro.org>
Message-ID: <574F075D.1010007@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

fu.wei at linaro.org wrote:
> diff --git a/drivers/clocksource/Kconfig b/drivers/clocksource/Kconfig
> index 47352d2..5a5baa1 100644
> --- a/drivers/clocksource/Kconfig
> +++ b/drivers/clocksource/Kconfig
> @@ -8,6 +8,7 @@ config CLKSRC_OF
>   config CLKSRC_ACPI
>   	bool
>   	select CLKSRC_PROBE
> +	select ACPI_GTDT

I think this should be under the ARM64 Kconfig option 
(arch/arm64/Kconfig), perhaps like this:

	select ACPI_SPCR_TABLE if ACPI
+	select ACPI_GTDT if ACPI

We want GTDT to be parsed on ARM64 if we have ACPI, even if we don't 
have CLKSRC enabled.

-- 
Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora
Forum, a Linux Foundation collaborative project.
