From: grant.likely@secretlab.ca (Grant Likely)
Date: Sat, 19 May 2012 23:10:26 -0600
Subject: [PATCH v2 6/6] spi: s3c64xx: add device tree support
In-Reply-To: <1337333613-6216-7-git-send-email-thomas.abraham@linaro.org>
References: <1337333613-6216-1-git-send-email-thomas.abraham@linaro.org>
 <1337333613-6216-7-git-send-email-thomas.abraham@linaro.org>
Message-ID: <20120520051026.77D0C3E03B8@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 18 May 2012 15:03:33 +0530, Thomas Abraham <thomas.abraham@linaro.org> wrote:
> Add support for device based discovery.
> 
> Signed-off-by: Thomas Abraham <thomas.abraham@linaro.org>
> Acked-by: Jaswinder Singh <jaswinder.singh@linaro.org>

Acked-by: Grant Likely <grant.likely@secretlab.ca>

... but one nitpick below...

> +#ifdef CONFIG_OF
> +static const struct of_device_id s3c64xx_spi_dt_match[] = {
> +	{ .compatible = "samsung,exynos4210-spi",
> +			.data = (void *)EXYNOS4_SPI_PORT_CONFIG,

This looks completely backwards.  EXYNOS4_SPI_PORT_CONFIG casts a
pointer to a kernel_ulong_t, and this casts it right back to a
pointer.  The cast should be removed entirely from the macro, and the
platform_device_id table should have the cast from pointer to ulong.

g.
