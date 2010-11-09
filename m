From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Tue, 9 Nov 2010 10:34:44 +0100
Subject: [PATCH 1/2] mx25: fix spi device registration typo
In-Reply-To: <6c16c084bfda41cd104613bed66bbad7b5433c6d.1289285160.git.baruch@tkos.co.il>
References: <6c16c084bfda41cd104613bed66bbad7b5433c6d.1289285160.git.baruch@tkos.co.il>
Message-ID: <20101109093444.GT16938@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Nov 09, 2010 at 08:47:54AM +0200, Baruch Siach wrote:
> Commit 35bab0589b9a71533b37280eefa430c21dc102fe (ARM: imx: change the way
> spi-imx devices are registered) contained a typo in mx25, leading to link time
> failure.
> 
> Cc: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
s/Cc/Acked-by/

hm, and I thought my testing strategy was good (enough). :-/

Thanks
Uwe

> Signed-off-by: Baruch Siach <baruch@tkos.co.il>
> ---
>  arch/arm/mach-mx25/devices-imx25.h |    4 ++--
>  1 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm/mach-mx25/devices-imx25.h b/arch/arm/mach-mx25/devices-imx25.h
> index 93afa10..d94d282 100644
> --- a/arch/arm/mach-mx25/devices-imx25.h
> +++ b/arch/arm/mach-mx25/devices-imx25.h
> @@ -42,9 +42,9 @@ extern const struct imx_mxc_nand_data imx25_mxc_nand_data __initconst;
>  #define imx25_add_mxc_nand(pdata)	\
>  	imx_add_mxc_nand(&imx25_mxc_nand_data, pdata)
>  
> -extern const struct imx_spi_imx_data imx25_spi_imx_data[] __initconst;
> +extern const struct imx_spi_imx_data imx25_cspi_data[] __initconst;
>  #define imx25_add_spi_imx(id, pdata)	\
> -	imx_add_spi_imx(&imx25_spi_imx_data[id], pdata)
> +	imx_add_spi_imx(&imx25_cspi_data[id], pdata)
>  #define imx25_add_spi_imx0(pdata)	imx25_add_spi_imx(0, pdata)
>  #define imx25_add_spi_imx1(pdata)	imx25_add_spi_imx(1, pdata)
>  #define imx25_add_spi_imx2(pdata)	imx25_add_spi_imx(2, pdata)

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
