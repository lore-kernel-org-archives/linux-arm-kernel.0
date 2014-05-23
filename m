From: matthias.bgg@gmail.com (Matthias Brugger)
Date: Fri, 23 May 2014 18:39:39 +0200
Subject: [PATCH v2 4/4] ARM: debug: qcom: add UART addresses to Kconfig
 help
In-Reply-To: <1400857952-6963-5-git-send-email-gdjakov@mm-sol.com>
References: <1400857952-6963-1-git-send-email-gdjakov@mm-sol.com>
 <1400857952-6963-5-git-send-email-gdjakov@mm-sol.com>
Message-ID: <CABuKBe+B_Ga-w4aA4dApDTa26rCuhetRTJku27Madm+fHtDcLA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2014-05-23 17:12 GMT+02:00 Georgi Djakov <gdjakov@mm-sol.com>:
> Add information about the APQ8084 debug UART physical and virtual
> addresses in the DEBUG_QCOM_UARTDM Kconfig help section.
> Requires: https://lkml.org/lkml/2014/4/14/312
>
> Signed-off-by: Georgi Djakov <gdjakov@mm-sol.com>
> ---
>  arch/arm/Kconfig.debug |    1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/arch/arm/Kconfig.debug b/arch/arm/Kconfig.debug
> index 40ee328..e71723d 100644
> --- a/arch/arm/Kconfig.debug
> +++ b/arch/arm/Kconfig.debug
> @@ -376,6 +376,7 @@ choice
>                   their output to the serial port on Qualcomm devices.
>
>                   ARCH      DEBUG_UART_PHYS   DEBUG_UART_BASE
> +                 APQ8084   0xf995e000        0xfa75e000
>                   MSM8X60   0x19c40000        0xf0040000
>                   MSM8960   0x16440000        0xf0040000
>                   MSM8974   0xf991e000        0xfa71e000

You don't have any uart defined in your dts. You should add them
before any adding low level debug support.
Otherwise there might be problems in booting a multi-platform kernel.

Regards,
Matthias

> --
> 1.7.9.5
>
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel



-- 
motzblog.wordpress.com
