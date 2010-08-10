From: mcuos.com@gmail.com (Wan ZongShun)
Date: Tue, 10 Aug 2010 09:45:49 +0800
Subject: [rtc-linux] [PATCH 2/2] rtc: Add support in Makefile/Kconfig for
	the LPC32XX RTC
In-Reply-To: <1281370650-29520-3-git-send-email-wellsk40@gmail.com>
References: <1281370650-29520-1-git-send-email-wellsk40@gmail.com>
	<1281370650-29520-3-git-send-email-wellsk40@gmail.com>
Message-ID: <AANLkTim5HDRi7+ONM4kxKeKda3gZziUiuuK_ohnrwrAP@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Kevin ,

2010/8/10  <wellsk40@gmail.com>:
> From: Kevin Wells <wellsk40@gmail.com>
>
> Enable build RTC support for the LPC32XX in makefile/Kconfig
>

I think you can intergrate two patches [PATCH 1/2 2/2] into one rtc
driver patch.

> Signed-off-by: Kevin Wells <wellsk40@gmail.com>
> Signed-off-by: Durgesh Pattamatta <durgesh.pattamatta@nxp.com>
> ---
> ?drivers/rtc/Kconfig ?| ? ?9 +++++++++
> ?drivers/rtc/Makefile | ? ?1 +
> ?2 files changed, 10 insertions(+), 0 deletions(-)
>
> diff --git a/drivers/rtc/Kconfig b/drivers/rtc/Kconfig
> index 4301a6c..8452788 100644
> --- a/drivers/rtc/Kconfig
> +++ b/drivers/rtc/Kconfig
> @@ -916,4 +916,13 @@ config RTC_DRV_JZ4740
> ? ? ? ? ?This driver can also be buillt as a module. If so, the module
> ? ? ? ? ?will be called rtc-jz4740.
>
> +config RTC_DRV_LPC32XX
> + ? ? ? ?depends on ARCH_LPC32XX
> + ? ? ? ?tristate "NXP LPC32XX RTC"
> + ? ? ? ?help
> + ? ? ? ? ?This enables support for the NXP RTC in the LPC32XX
> +
> + ? ? ? ? This driver can also be buillt as a module. If so, the module
> + ? ? ? ? will be called rtc-lpc32xx.
> +
> ?endif # RTC_CLASS
> diff --git a/drivers/rtc/Makefile b/drivers/rtc/Makefile
> index fedf9bb..3b8af95 100644
> --- a/drivers/rtc/Makefile
> +++ b/drivers/rtc/Makefile
> @@ -48,6 +48,7 @@ obj-$(CONFIG_RTC_DRV_FM3130) ?+= rtc-fm3130.o
> ?obj-$(CONFIG_RTC_DRV_GENERIC) ?+= rtc-generic.o
> ?obj-$(CONFIG_RTC_DRV_ISL1208) ?+= rtc-isl1208.o
> ?obj-$(CONFIG_RTC_DRV_JZ4740) ? += rtc-jz4740.o
> +obj-$(CONFIG_RTC_DRV_LPC32XX) ? += rtc-lpc32xx.o
> ?obj-$(CONFIG_RTC_DRV_M41T80) ? += rtc-m41t80.o
> ?obj-$(CONFIG_RTC_DRV_M41T94) ? += rtc-m41t94.o
> ?obj-$(CONFIG_RTC_DRV_M48T35) ? += rtc-m48t35.o
> --
> 1.7.1.1
>
> --
> You received this message because you are subscribed to "rtc-linux".
> Membership options at http://groups.google.com/group/rtc-linux .
> Please read http://groups.google.com/group/rtc-linux/web/checklist
> before submitting a driver.



-- 
*linux-arm-kernel mailing list
mail addr:linux-arm-kernel at lists.infradead.org
you can subscribe by:
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

* linux-arm-NUC900 mailing list
mail addr:NUC900 at googlegroups.com
main web: https://groups.google.com/group/NUC900
you can subscribe it by sending me mail:
mcuos.com at gmail.com
