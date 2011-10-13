From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 13 Oct 2011 11:02:06 +0100
Subject: [PATCH V2 1/2] ARM: EXYNOS4: Add SPI support
In-Reply-To: <1318234084-19960-2-git-send-email-padma.v@samsung.com>
References: <1318234084-19960-1-git-send-email-padma.v@samsung.com>
	<1318234084-19960-2-git-send-email-padma.v@samsung.com>
Message-ID: <20111013100206.GP21648@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Oct 10, 2011 at 01:38:04PM +0530, Padmavathi Venna wrote:
> +void __init exynos4_spi_set_info(int cntrlr, int src_clk_nr, int num_cs)
> +{
> +	struct s3c64xx_spi_info *pd;
> +
> +	/* Reject invalid configuration */
> +	if (!num_cs || src_clk_nr < 0
> +			|| src_clk_nr > EXYNOS4_SPI_SRCCLK_SCLK) {
> +		printk(KERN_ERR "%s: Invalid SPI configuration\n", __func__);

Let's start using pr_err() rather than printk(KERN_ERR...) in ARM code
please.
