From: shc_work@mail.ru (=?UTF-8?B?QWxleGFuZGVyIFNoaXlhbg==?=)
Date: Sat, 15 Mar 2014 18:43:36 +0400
Subject: =?UTF-8?B?UmU6IFtQQVRDSCB2MiAxNi8xNl0gQVNvQzogZnNsLXNzaTogVXNlIHJlZ21h?=
 =?UTF-8?B?cA==?=
In-Reply-To: <1394887464-969-17-git-send-email-mpa@pengutronix.de>
References: <1394887464-969-1-git-send-email-mpa@pengutronix.de>
 <1394887464-969-17-git-send-email-mpa@pengutronix.de>
Message-ID: <1394894616.578942243@f331.i.mail.ru>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

???????, 15 ????? 2014, 13:44 +01:00 ?? Markus Pargmann <mpa@pengutronix.de>:
> This patch replaces the ssi specific functions write_ssi, read_ssi and
> write_ssi_mask by standard regmap function calls.
...
> diff --git a/sound/soc/fsl/fsl_ssi.c b/sound/soc/fsl/fsl_ssi.c
...
> +static const struct regmap_config fsl_ssi_regconfig = {
> +	.max_register = CCSR_SSI_SACCDIS,
> +	.reg_bits = 32,
> +	.val_bits = 32,
> +	.reg_stride = 4,
> +#ifdef PPC
> +	.val_format_endian = REGMAP_ENDIAN_BIG,
> +#endif
> +};

Why we cannot use REGMAP_ENDIAN_NATIVE here for all cases?
Theoretically, we can use for i.MX SOCs with different endianness,
so this will help us.

---
