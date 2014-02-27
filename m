From: mpa@pengutronix.de (Markus Pargmann)
Date: Thu, 27 Feb 2014 16:23:32 +0100
Subject: [PATCH 01/15] ASoC: fsl-ssi: Use regmap
In-Reply-To: <6dc5873dcdf54e13aecbf7c6be03f8bf@BY2PR03MB505.namprd03.prod.outlook.com>
References: <1393430538-32333-1-git-send-email-mpa@pengutronix.de>
 <1393430538-32333-2-git-send-email-mpa@pengutronix.de>
 <6dc5873dcdf54e13aecbf7c6be03f8bf@BY2PR03MB505.namprd03.prod.outlook.com>
Message-ID: <20140227152332.GA30791@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Thu, Feb 27, 2014 at 02:08:45AM +0000, Li.Xiubo at freescale.com wrote:
> 
> > @@ -134,6 +115,15 @@ struct fsl_ssi_rxtx_reg_val {
> >  	struct fsl_ssi_reg_val rx;
> >  	struct fsl_ssi_reg_val tx;
> >  };
> > +static const struct regmap_config fsl_ssi_regconfig = {
> > +	.max_register = CCSR_SSI_SACCDIS,
> > +	.reg_bits = 32,
> > +	.val_bits = 32,
> > +	.reg_stride = 4,
> > +#ifdef PPC
> > +	.val_format_endian = REGMAP_ENDIAN_BIG,
> > +#endif
> 
> Is this really needed for your PPC platforms?

I don't know if this is necessary. I don't have any PPC hardware where I
could test this driver. This is just a guess how regmap for this driver
and PPC should look like based on the previous code. So it would be
great if anyone could test this regmap config on PPC.

Thanks,

Markus

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140227/d03bbcd4/attachment-0001.sig>
