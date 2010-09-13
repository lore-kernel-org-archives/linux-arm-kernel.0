From: kevin.wells@nxp.com (Kevin Wells)
Date: Mon, 13 Sep 2010 18:51:57 +0200
Subject: resend: [PATCH] amba_pl022: Setup SPI configuration based on
	spi->mode
In-Reply-To: <AANLkTikbKwo9=xLWo1qEcc2E5aa2iN2F_KCokJPpnWOk@mail.gmail.com>
References: <AANLkTikbKwo9=xLWo1qEcc2E5aa2iN2F_KCokJPpnWOk@mail.gmail.com>
Message-ID: <083DF309106F364B939360100EC290F80AD49D5230@eu1rdcrdc1wx030.exi.nxp.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> + ? ? ? if (spi->mode & SPI_CPOL)
> + ? ? ? ? ? ? ? tmp = SSP_CLK_POL_IDLE_HIGH;
> + ? ? ? else
> + ? ? ? ? ? ? ? tmp = SSP_CLK_POL_IDLE_LOW;
> + ? ? ? SSP_WRITE_BITS(chip->cr0, tmp, SSP_CR0_MASK_SPO, 6);
> +
> + ? ? ? if (spi->mode & SPI_CPHA)
> + ? ? ? ? ? ? ? tmp = SSP_CLK_SECOND_EDGE;
> + ? ? ? else
> + ? ? ? ? ? ? ? tmp = SSP_CLK_FIRST_EDGE;
> + ? ? ? SSP_WRITE_BITS(chip->cr0, tmp, SSP_CR0_MASK_SPH, 6);

SSP_CR0_MASK_SPH (SPHA) should use bit 7, not bit 6.
Should be:
       SSP_WRITE_BITS(chip->cr0, tmp, SSP_CR0_MASK_SPH, 7);

> +
> ? ? ? ?SSP_WRITE_BITS(chip->cr0, chip_info->clk_freq.scr, SSP_CR0_MASK_SCR,
> 8);
> ? ? ? ?/* Loopback is available on all versions except PL023 */
