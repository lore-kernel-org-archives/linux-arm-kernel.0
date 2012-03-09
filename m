From: axel.lin@gmail.com (Axel Lin)
Date: Fri, 9 Mar 2012 11:45:15 +0800
Subject: [PATCH v10] Regulator: Add Anatop regulator driver
In-Reply-To: <1331200744-5986-1-git-send-email-paul.liu@linaro.org>
References: <1331200744-5986-1-git-send-email-paul.liu@linaro.org>
Message-ID: <CAF+7xWm4R02eK0a-q-yTF16fm4tGQUf7XUQK8+KtPNhjnzff5A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> --- a/drivers/regulator/Kconfig
> +++ b/drivers/regulator/Kconfig
> @@ -213,6 +213,14 @@ config REGULATOR_PCAP
> ? ? ? ? This driver provides support for the voltage regulators of the
> ? ? ? ? PCAP2 PMIC.
>
> +config REGULATOR_ANATOP
> + ? ? ? tristate "Freescale i.MX on-chip ANATOP LDO regulators"
> + ? ? ? depends on MFD_ANATOP
> + ? ? ? help
> + ? ? ? ? Say y here to support Freescale i.MX on-chip ANATOP LDOs
> + ? ? ? ? regulators. It is recommended that this option be
> + ? ? ? ? enabled on i.MX6 platform.
> +
> ?config REGULATOR_MC13XXX_CORE
> ? ? ? ?tristate
>
> diff --git a/drivers/regulator/Makefile b/drivers/regulator/Makefile
> index 503bac8..8440871 100644
> --- a/drivers/regulator/Makefile
> +++ b/drivers/regulator/Makefile
> @@ -48,5 +48,6 @@ obj-$(CONFIG_REGULATOR_AB8500) ? ? ? ?+= ab8500.o
> ?obj-$(CONFIG_REGULATOR_DB8500_PRCMU) += db8500-prcmu.o
> ?obj-$(CONFIG_REGULATOR_TPS65910) += tps65910-regulator.o
> ?obj-$(CONFIG_REGULATOR_AAT2870) += aat2870-regulator.o
> +obj-$(CONFIG_REGULATOR_ANATOP) += anatop-regulator.o
>
> ?ccflags-$(CONFIG_REGULATOR_DEBUG) += -DDEBUG

Looks like your patch is against Linus' tree.
Currently, we have sorted the Kconfig entries and Makefile entries in
Mark's tree.
The Kconfig entries are sorted by vender name first, then driver name.
The Makefile entries are sorted by by alphabetical order.

Regards,
Axel
