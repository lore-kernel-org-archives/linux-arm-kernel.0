From: linus.walleij@stericsson.com (Linus Walleij)
Date: Tue, 14 Sep 2010 16:45:57 +0200
Subject: resend: [PATCH] amba_pl022: Setup SPI configuration based on
	spi->mode
In-Reply-To: <083DF309106F364B939360100EC290F80AD49D5230@eu1rdcrdc1wx030.exi.nxp.com>
References: <AANLkTikbKwo9=xLWo1qEcc2E5aa2iN2F_KCokJPpnWOk@mail.gmail.com>
	<083DF309106F364B939360100EC290F80AD49D5230@eu1rdcrdc1wx030.exi.nxp.com>
Message-ID: <AANLkTim4a7eha6Z3pjrZ0kg9VNRcuH52Qs2h4XydsXi4@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2010/9/13 Kevin Wells <kevin.wells@nxp.com>:

> SSP_CR0_MASK_SPH (SPHA) should use bit 7, not bit 6.
> Should be:
> ? ? ? SSP_WRITE_BITS(chip->cr0, tmp, SSP_CR0_MASK_SPH, 7);
>
>> +
>> ? ? ? ?SSP_WRITE_BITS(chip->cr0, chip_info->clk_freq.scr, SSP_CR0_MASK_SCR,
>> 8);
>> ? ? ? ?/* Loopback is available on all versions except PL023 */

That's it!

With this correction it starts working, so
Acked-by/Tested-by/Reviewed-by: Linus Walleij <linus.walleij@stericsson.com>

Please submit the whole patch series with corrections and my tag
so Grant can pick it up, and thanks for doing this because I think
it is a great improvement to the driver!

Yours,
Linus Walleij
