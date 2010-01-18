From: daniel@caiaq.de (Daniel Mack)
Date: Mon, 18 Jan 2010 22:51:24 +0100
Subject: [PATCH - 3rd attempt] ARM: Support for Embedian MXM-8x10 eval kit
In-Reply-To: <201001182134.14226.epeer@tmtservices.co.za>
References: <201001182134.14226.epeer@tmtservices.co.za>
Message-ID: <20100118215124.GE8970@buzzloop.caiaq.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jan 18, 2010 at 09:34:14PM +0200, Edwin Peer wrote:
> I believe we have finally managed to address all your review points - third time's a charm. :)
> 
> Here's the diffstat against 2.6.33-rc4:

One more thing that caught my eye.

[...]

> +void __init mxm_8x10_mmc_init(void)
> +{
> +	pxa_set_mci_info(&mxm_8x10_mci_platform_data);
> +}
> +#else
> +inline void mxm_8x10_mmc_init(void)
> +{
> +}

You should make that inline function static.

[...]

> +void __init mxm_8x10_nand_init(void)
> +{
> +	pxa3xx_set_nand_info(&mxm_8x10_nand_info);
> +}
> +#else
> +inline mxm_8x10_nand_init(void)
> +{
> +}

Same here, and it should return void. Without any return type, it will
default to int, which is not what you want. And as you're on it, you can
also put the whole thing in one line (but that's really nit-picking).

Daniel
