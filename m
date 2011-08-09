From: arnaud.patard@rtp-net.org (Arnaud Patard (Rtp))
Date: Tue, 09 Aug 2011 17:39:28 +0200
Subject: [PATCH] iomux-mx53: fix PAD_CTRL for I2C1_SDA and I2C1_SCL
In-Reply-To: <1312902763-15817-1-git-send-email-m.grzeschik@pengutronix.de>
	(Michael Grzeschik's message of "Tue, 9 Aug 2011 17:12:43 +0200")
References: <1312902763-15817-1-git-send-email-m.grzeschik@pengutronix.de>
Message-ID: <87liv2egr3.fsf@lebrac.rtp-net.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Michael Grzeschik <m.grzeschik@pengutronix.de> writes:

> Derived from the fsl kernel, this is needed to make connection work on
> the mx53 loco with devices connected to i2c1.
>
> Signed-off-by: Michael Grzeschik <m.grzeschik@pengutronix.de>
> ---
>  arch/arm/plat-mxc/include/mach/iomux-mx53.h |    8 ++++++--
>  1 files changed, 6 insertions(+), 2 deletions(-)
>
> diff --git a/arch/arm/plat-mxc/include/mach/iomux-mx53.h b/arch/arm/plat-mxc/include/mach/iomux-mx53.h
> index 9440b9e..281cc9c 100644
> --- a/arch/arm/plat-mxc/include/mach/iomux-mx53.h
> +++ b/arch/arm/plat-mxc/include/mach/iomux-mx53.h
> @@ -30,6 +30,10 @@
>  #define MX53_SDHC_PAD_CTRL 	(PAD_CTL_HYS | PAD_CTL_PKE | PAD_CTL_PUE | \
>  				PAD_CTL_PUS_47K_UP | PAD_CTL_DSE_HIGH | \
>  				PAD_CTL_SRE_FAST)
> +#define MX53_I2C_PAD_CTRL_2	(PAD_CTL_SRE_FAST | PAD_CTL_ODE | \
> +				PAD_CTL_PKE | PAD_CTL_PUE | \
> +				PAD_CTL_DSE_HIGH | PAD_CTL_PUS_100K_UP | \
> +				PAD_CTL_HYS)

Excuse me for theses stupid questions but why _2 ? and why is it different
than MX51_I2C_PAD_CTRL ? different SoC so different pad behaviour ?

[ arch/arm/plat-mxc/include/mach/iomux-mx51.h:
#define MX51_I2C_PAD_CTRL       (PAD_CTL_SRE_FAST | PAD_CTL_ODE | \
                                PAD_CTL_DSE_HIGH | PAD_CTL_PUS_100K_UP |\
                                PAD_CTL_HYS)
]

Thanks,
Arnaud
