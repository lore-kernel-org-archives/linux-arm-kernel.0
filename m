From: wsa-dev@sang-engineering.com (Wolfram Sang)
Date: Thu, 17 Nov 2016 22:54:40 +0100
Subject: [v4, 1/3] i2c: pxa: Add support for the I2C units found in
 Armada 3700
In-Reply-To: <20161109115715.2557-2-romain.perier@free-electrons.com>
References: <20161109115715.2557-2-romain.perier@free-electrons.com>
Message-ID: <20161117215440.GA10851@katana>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


> +	[REGS_A3700] = {
> +		.ibmr = 0x00,
> +		.idbr = 0x04,
> +		.icr =	0x08,
> +		.isr =	0x0c,
> +		.isar = 0x10,
> +	},

Can't you reuse REGS_PXA3XX?

>  static const struct platform_device_id i2c_pxa_id_table[] = {
> @@ -98,6 +106,7 @@ static const struct platform_device_id i2c_pxa_id_table[] = {
>  	{ "pxa3xx-pwri2c",	REGS_PXA3XX },
>  	{ "ce4100-i2c",		REGS_CE4100 },
>  	{ "pxa910-i2c",		REGS_PXA910 },
> +	{ "armada-3700-i2c",	REGS_A3700  },

So, you declare a platform_device_id here...

> +	if (of_device_is_compatible(np, "marvell,armada-3700-i2c")) {
> +		i2c->fm_mask = ICR_BUSMODE_FM;
> +		i2c->hs_mask = ICR_BUSMODE_HS;
> +	} else {
> +		i2c->fm_mask = ICR_FM;
> +		i2c->hs_mask = ICR_HS;
> +	}

... but don't consider this case here?

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20161117/93262221/attachment.sig>
