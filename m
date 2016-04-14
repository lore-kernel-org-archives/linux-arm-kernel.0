From: tharvey@gateworks.com (Tim Harvey)
Date: Thu, 14 Apr 2016 08:13:39 -0700
Subject: [PATCH 2/2] ARM: imx_v6_v7_defconfig: enable PCI_MSI
In-Reply-To: <1448902811-11399-2-git-send-email-l.stach@pengutronix.de>
References: <1448902811-11399-1-git-send-email-l.stach@pengutronix.de>
 <1448902811-11399-2-git-send-email-l.stach@pengutronix.de>
Message-ID: <CAJ+vNU2Fb7gpO0LsoVpPbUX5rSyH3yC4K30JpAf5j7aQkDH9tw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Nov 30, 2015 at 9:00 AM, Lucas Stach <l.stach@pengutronix.de> wrote:
> This has been stable on i.MX6 for a good while now and there is no
> reason to keep it disabled, as it allows to allocate non-shared
> IRQs if several PCIe devices are connected to a single host.
>
> Signed-off-by: Lucas Stach <l.stach@pengutronix.de>
> ---
>  arch/arm/configs/imx_v6_v7_defconfig | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/arch/arm/configs/imx_v6_v7_defconfig b/arch/arm/configs/imx_v6_v7_defconfig
> index 4187f69f6630..e2ce60d00e8a 100644
> --- a/arch/arm/configs/imx_v6_v7_defconfig
> +++ b/arch/arm/configs/imx_v6_v7_defconfig
> @@ -45,6 +45,7 @@ CONFIG_SOC_IMX7D=y
>  CONFIG_SOC_LS1021A=y
>  CONFIG_SOC_VF610=y
>  CONFIG_PCI=y
> +CONFIG_PCI_MSI=y
>  CONFIG_PCI_IMX6=y
>  CONFIG_SMP=y
>  CONFIG_PREEMPT_VOLUNTARY=y
> --
> 2.6.2
>
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

Lucas,

Any thoughts on why enabling MSI on IMX6 breaks legacy interrupts?

Again, many PCI devices/drivers don't support MSI and thus enabling
MSI as this patch does makes this config break many PCI devices on
IMX6.

I have found that MSI does indeed work on the IMX6 for cards/drivers
that use MSI, but for those that don't the legacy interrupts never
fire regardless of going through a bridge or directly hanging off the
IMX6. I assume you can confirm this on your boards/devices as well?

Regards,

Tim
