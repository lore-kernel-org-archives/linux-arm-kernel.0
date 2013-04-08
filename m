From: timur@tabi.org (Timur Tabi)
Date: Sun, 07 Apr 2013 21:52:17 -0500
Subject: [PATCH v2 01/11] ASoC: phycore-ac97: Add DT support
In-Reply-To: <1365362721-3731-2-git-send-email-mpa@pengutronix.de>
References: <1365362721-3731-1-git-send-email-mpa@pengutronix.de>
 <1365362721-3731-2-git-send-email-mpa@pengutronix.de>
Message-ID: <516230E1.3070509@tabi.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Markus Pargmann wrote:
> Notes:
>     Changes in v2:
>      - Simplify the driver, by combining audmux port configurations. The
>        audmux driver actually knows on which platform he is running and
>        will return the appropriate error code if we use functions for
>        another platform. So we don't need to have the knowledge about it
>        in phycore-ac97 and can try both functions. This removes the need
>        of different compatibilities and renames it to imx27-ac97.
>      - Use a phandle for the cpu_dai link.
>      - Add devicetree binding documentation.
>      - Rename binding to phytec,phycore-ac97 and fsl,ssi to phytec,ssi

I think some of this information belongs in the changelog.

> +#ifdef CONFIG_MACH_IMX27_DT
> +		.platform_name	= "imx-fiq-pcm-audio",
> +#else
>   		.cpu_dai_name	= "imx-ssi.0",
>   		.platform_name	= "imx-fiq-pcm-audio.0",
> +#endif

What's the difference between "imx-fiq-pcm-audio" and "imx-fiq-pcm-audio.0"?

-- 
Timur Tabi
