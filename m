From: Jonathan.Austin@arm.com (Jonathan Austin)
Date: Thu, 15 Aug 2013 15:01:49 +0100
Subject: [PATCH Resend 1/3] PSCI: add missing dependency on CONFIG_OF
 for PSCI.
In-Reply-To: <1376500987-12797-2-git-send-email-jonathan.austin@arm.com>
References: <1376500987-12797-1-git-send-email-jonathan.austin@arm.com>
 <1376500987-12797-2-git-send-email-jonathan.austin@arm.com>
Message-ID: <520CDF4D.6050702@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 14/08/13 18:23, Jonathan Austin wrote:
> The PSCI initialisation depends on data found in the DT. Without this the
> including PSCI support makes little sense, and furthermore the of_* stub
> functions aren't broad enough to ensure that this builds without CONFIG_OF.
>
> As there is little enthusiasm for extending these stubs without useful use-cases
> (of which this is *not* an example) this patch prevents building of PSCI
> without CONFIG_OF.
>
> Signed-off-by: Jonathan Austin <jonathan.austin@arm.com>
> ---
>   arch/arm/Kconfig |    1 +
>   1 file changed, 1 insertion(+)
>
> diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
> index ba412e0..972ec25 100644
> --- a/arch/arm/Kconfig
> +++ b/arch/arm/Kconfig
> @@ -1577,6 +1577,7 @@ config HOTPLUG_CPU
>   config ARM_PSCI
>       bool "Support for the ARM Power State Coordination Interface (PSCI)"
>       depends on CPU_V7
> +     depends on CONFIG_OF
>       help
>         Say Y here if you want Linux to communicate with system firmware
>         implementing the PSCI specification for CPU-centric power
>

As Sergei pointed out, this should just be OF not CONFIG_OF....

------8<-------

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 43594d5..f004de7 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -1577,6 +1577,7 @@ config HOTPLUG_CPU
 config ARM_PSCI
        bool "Support for the ARM Power State Coordination Interface (PSCI)"
        depends on CPU_V7
+       depends on OF
        help
          Say Y here if you want Linux to communicate with system firmware
          implementing the PSCI specification for CPU-centric power

---->8---------------

-- IMPORTANT NOTICE: The contents of this email and any attachments are confidential and may also be privileged. If you are not the intended recipient, please notify the sender immediately and do not disclose the contents to any other person, use it for any purpose, or store or copy the information in any medium.  Thank you.

ARM Limited, Registered office 110 Fulbourn Road, Cambridge CB1 9NJ, Registered in England & Wales, Company No:  2557590
ARM Holdings plc, Registered office 110 Fulbourn Road, Cambridge CB1 9NJ, Registered in England & Wales, Company No:  2548782
