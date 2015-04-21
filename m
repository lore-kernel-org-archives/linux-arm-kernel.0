From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 21 Apr 2015 10:55:43 +0100
Subject: [PATCH v4 07/11] ARM: imx: add msl support for imx7d
In-Reply-To: <1429563933-3129-8-git-send-email-Frank.Li@freescale.com>
References: <1429563933-3129-1-git-send-email-Frank.Li@freescale.com>
 <1429563933-3129-8-git-send-email-Frank.Li@freescale.com>
Message-ID: <20150421095543.GQ12732@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This looks a lot better, thanks - just one remaining comment:

On Tue, Apr 21, 2015 at 05:05:29AM +0800, Frank.Li at freescale.com wrote:
> +static void __init imx7d_map_io(void)
> +{
> +	debug_ll_io_init();
> +}

If that's all that you need here, please get rid of it; the generic code
will make that call for you if you don't provide a .map_io method below:

> +DT_MACHINE_START(IMX7D, "Freescale i.MX7 Dual (Device Tree)")
> +	.map_io		= imx7d_map_io,
> +	.smp            = smp_ops(imx_ca7_smp_ops),
> +	.init_irq	= imx7d_init_irq,
> +	.init_machine	= imx7d_init_machine,
> +	.dt_compat	= imx7d_dt_compat,
> +	.restart	= mxc_restart,
> +MACHINE_END

-- 
FTTC broadband for 0.8mile line: currently at 10.5Mbps down 400kbps up
according to speedtest.net.
