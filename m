From: broonie@kernel.org (Mark Brown)
Date: Wed, 5 Mar 2014 14:21:14 +0800
Subject: [PATCH 01/15] ASoC: fsl-ssi: Use regmap
In-Reply-To: <6dc5873dcdf54e13aecbf7c6be03f8bf@BY2PR03MB505.namprd03.prod.outlook.com>
References: <1393430538-32333-1-git-send-email-mpa@pengutronix.de>
 <1393430538-32333-2-git-send-email-mpa@pengutronix.de>
 <6dc5873dcdf54e13aecbf7c6be03f8bf@BY2PR03MB505.namprd03.prod.outlook.com>
Message-ID: <20140305062114.GT13126@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Feb 27, 2014 at 02:08:45AM +0000, Li.Xiubo at freescale.com wrote:

> > +static const struct regmap_config fsl_ssi_regconfig = {
> > +	.max_register = CCSR_SSI_SACCDIS,
> > +	.reg_bits = 32,
> > +	.val_bits = 32,
> > +	.reg_stride = 4,
> > +#ifdef PPC
> > +	.val_format_endian = REGMAP_ENDIAN_BIG,
> > +#endif

> Is this really needed for your PPC platforms?

> If so, I think this should depend on one specified platform, which
> the CPU is in LE mode while the SSI is in BE mode...

Since the entire series depends on this patch due to the fact that it
makes changes throughout the driver we need this resolving to make any
progress here.  Perhaps it makes sense to restructure the series so that
this is at the end rather than start of the series?
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140305/34f299ed/attachment.sig>
