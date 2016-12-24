From: festevam@gmail.com (Fabio Estevam)
Date: Sat, 24 Dec 2016 11:00:59 -0200
Subject: [PATCH v1] watchdog: imx2: fix hang-up on boot for i.MX21, i.MX27
 and i.MX31 SoCs
In-Reply-To: <20161211010648.6591-1-vz@mleia.com>
References: <20161211010648.6591-1-vz@mleia.com>
Message-ID: <CAOMZO5CqpfH6nq_mqPitztfSX4-oR4-61z7PnYhvOYAVnYF0yA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Dec 10, 2016 at 11:06 PM, Vladimir Zapolskiy <vz@mleia.com> wrote:

>  static const struct of_device_id imx2_wdt_dt_ids[] = {
> -       { .compatible = "fsl,imx21-wdt", },
> +       { .compatible = "fsl,imx21-wdt", .data = IMX2_WDT_NO_WMCR },
> +       { .compatible = "fsl,imx25-wdt",  },
> +       { .compatible = "fsl,imx27-wdt", .data = IMX2_WDT_NO_WMCR },
> +       { .compatible = "fsl,imx31-wdt", .data = IMX2_WDT_NO_WMCR },
> +       { .compatible = "fsl,imx35-wdt",  },
> +       { .compatible = "fsl,imx50-wdt",  },
> +       { .compatible = "fsl,imx51-wdt",  },
> +       { .compatible = "fsl,imx53-wdt",  },
> +       { .compatible = "fsl,imx6q-wdt",  },
> +       { .compatible = "fsl,imx6sl-wdt", },
> +       { .compatible = "fsl,imx6sx-wdt", },
> +       { .compatible = "fsl,imx6ul-wdt", },
> +       { .compatible = "fsl,imx7d-wdt",  },
> +       { .compatible = "fsl,vf610-wdt",  },
>         { /* sentinel */ }

I understand this compatible list is not very nice, but in order to
keep old dtb's working I don't see a better solution, so:

Reviewed-by: Fabio Estevam <fabio.estevam@nxp.com>
