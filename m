From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 12 Aug 2015 08:44:39 +0100
Subject: [PATCH v2 1/2] soc/fsl: add freescale dir for SOC specific drivers
In-Reply-To: <1439358807-9024-1-git-send-email-dongsheng.wang@freescale.com>
References: <1439358807-9024-1-git-send-email-dongsheng.wang@freescale.com>
Message-ID: <20150812074439.GF7557@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Aug 12, 2015 at 01:53:26PM +0800, Dongsheng Wang wrote:
> diff --git a/drivers/soc/fsl/Kconfig b/drivers/soc/fsl/Kconfig
> new file mode 100644
> index 0000000..863d1ef
> --- /dev/null
> +++ b/drivers/soc/fsl/Kconfig
> @@ -0,0 +1,18 @@
> +#
> +# Freescale SOC drivers
> +#
> +menuconfig FSL_SOC_DRIVERS
> +	bool "Freescale Soc Drivers"
> +	default n

No need for default n.

> diff --git a/drivers/soc/fsl/Kconfig.arm b/drivers/soc/fsl/Kconfig.arm
> new file mode 100644
> index 0000000..8c90b82
> --- /dev/null
> +++ b/drivers/soc/fsl/Kconfig.arm
> @@ -0,0 +1,16 @@
> +#
> +# Freescale ARM SOC Drivers
> +#
> +
> +config	LS1_SOC_DRIVERS
> +	bool "LS1021A Soc Drivers"
> +	depends on SOC_LS1021A
> +	default n

Ditto.

> +	help
> +	Say y here to enable Freescale LS1021A Soc Device Drivers support.
> +	The Soc Drivers provides the device driver that is a specific block
> +	or feature on LS1021A platform.

Help text should be indented by two spaces as per almost every other
help text.

> +
> +if LS1_SOC_DRIVERS
> +	source "drivers/soc/fsl/ls1/Kconfig"
> +endif
> diff --git a/drivers/soc/fsl/Makefile b/drivers/soc/fsl/Makefile
> new file mode 100644
> index 0000000..b4215dd
> --- /dev/null
> +++ b/drivers/soc/fsl/Makefile
> @@ -0,0 +1,6 @@
> +#
> +# Makefile for Freescale Soc specific device drivers.
> +#
> +
> +obj-$(CONFIG_LS1_SOC_DRIVERS) += ls1/
> +
> diff --git a/drivers/soc/fsl/ls1/Kconfig b/drivers/soc/fsl/ls1/Kconfig
> new file mode 100644
> index 0000000..7556f44
> --- /dev/null
> +++ b/drivers/soc/fsl/ls1/Kconfig
> @@ -0,0 +1,3 @@
> +#
> +# LS-1 Soc drivers
> +#

Doesn't this directory need a Makefile as well?

-- 
FTTC broadband for 0.8mile line: currently at 10.5Mbps down 400kbps up
according to speedtest.net.
