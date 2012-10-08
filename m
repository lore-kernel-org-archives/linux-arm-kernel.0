From: tony@atomide.com (Tony Lindgren)
Date: Mon, 8 Oct 2012 13:50:53 -0700
Subject: [PATCH 1/1] ARM: Add option to configure output line for McSPI
 driver
In-Reply-To: <1348684467-5707-1-git-send-email-stanhu@gmail.com>
References: <y>
 <1348684467-5707-1-git-send-email-stanhu@gmail.com>
Message-ID: <20121008205052.GB13011@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Stan Hu <stanhu@gmail.com> [120926 11:36]:
> McSPI driver previously assumed that D0 was input (MISO) and D1 was output (MOSI).
> This forces the hardware designer to wire all SPI peripherals in this way when
> it should be a software configuration option.
> 
> Signed-off-by: Stan Hu <stanhu@gmail.com>
> ---
>  arch/arm/plat-omap/include/plat/mcspi.h |    2 ++
>  drivers/spi/spi-omap2-mcspi.c           |   11 +++++++++--
>  2 files changed, 11 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm/plat-omap/include/plat/mcspi.h b/arch/arm/plat-omap/include/plat/mcspi.h
> index a357eb2..0a6b790 100644
> --- a/arch/arm/plat-omap/include/plat/mcspi.h
> +++ b/arch/arm/plat-omap/include/plat/mcspi.h
> @@ -18,6 +18,8 @@ struct omap2_mcspi_dev_attr {
>  
>  struct omap2_mcspi_device_config {
>  	unsigned turbo_mode:1;
> +	/* 1 -> [D0 = MOSI, D1 = MISO], otherwise vice versa */
> +	unsigned d0_is_output:1;
>  };
>  
>  #endif

FYI, if this did not yet get applied, this header has now been
moved to linux/platform_data/spi-omap2-mcspi.h. So you may want
to updated it and repost.

Also, you should probably Cc spi-devel-general at lists.sourceforge.net.

Regards,

Tony
