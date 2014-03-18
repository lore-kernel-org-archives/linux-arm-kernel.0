From: mpa@pengutronix.de (Markus Pargmann)
Date: Tue, 18 Mar 2014 09:10:19 +0100
Subject: [PATCH v2 16/16] ASoC: fsl-ssi: Use regmap
In-Reply-To: <1394894616.578942243@f331.i.mail.ru>
References: <1394887464-969-1-git-send-email-mpa@pengutronix.de>
 <1394887464-969-17-git-send-email-mpa@pengutronix.de>
 <1394894616.578942243@f331.i.mail.ru>
Message-ID: <20140318081019.GJ11360@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Mar 15, 2014 at 06:43:36PM +0400, Alexander Shiyan wrote:
> ???????, 15 ????? 2014, 13:44 +01:00 ?? Markus Pargmann <mpa@pengutronix.de>:
> > This patch replaces the ssi specific functions write_ssi, read_ssi and
> > write_ssi_mask by standard regmap function calls.
> ...
> > diff --git a/sound/soc/fsl/fsl_ssi.c b/sound/soc/fsl/fsl_ssi.c
> ...
> > +static const struct regmap_config fsl_ssi_regconfig = {
> > +	.max_register = CCSR_SSI_SACCDIS,
> > +	.reg_bits = 32,
> > +	.val_bits = 32,
> > +	.reg_stride = 4,
> > +#ifdef PPC
> > +	.val_format_endian = REGMAP_ENDIAN_BIG,
> > +#endif
> > +};
> 
> Why we cannot use REGMAP_ENDIAN_NATIVE here for all cases?
> Theoretically, we can use for i.MX SOCs with different endianness,
> so this will help us.

I can change and test it on i.MX, but I am not sure if it helps with the
PPC situation as I don't have the hardware.

Regards,

Markus

> 
> ---

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140318/7ddc868b/attachment.sig>
