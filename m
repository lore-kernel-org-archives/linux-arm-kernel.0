From: timur@tabi.org (Timur Tabi)
Date: Thu, 27 Feb 2014 10:06:33 -0600
Subject: [PATCH 01/15] ASoC: fsl-ssi: Use regmap
In-Reply-To: <20140227152332.GA30791@pengutronix.de>
References: <1393430538-32333-1-git-send-email-mpa@pengutronix.de>
 <1393430538-32333-2-git-send-email-mpa@pengutronix.de>
 <6dc5873dcdf54e13aecbf7c6be03f8bf@BY2PR03MB505.namprd03.prod.outlook.com>
 <20140227152332.GA30791@pengutronix.de>
Message-ID: <530F6289.7030805@tabi.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 02/27/2014 09:23 AM, Markus Pargmann wrote:
>>> > >+static const struct regmap_config fsl_ssi_regconfig = {
>>> > >+	.max_register = CCSR_SSI_SACCDIS,
>>> > >+	.reg_bits = 32,
>>> > >+	.val_bits = 32,
>>> > >+	.reg_stride = 4,
>>> > >+#ifdef PPC
>>> > >+	.val_format_endian = REGMAP_ENDIAN_BIG,
>>> > >+#endif
>> >
>> >Is this really needed for your PPC platforms?
> I don't know if this is necessary. I don't have any PPC hardware where I
> could test this driver. This is just a guess how regmap for this driver
> and PPC should look like based on the previous code. So it would be
> great if anyone could test this regmap config on PPC.

I will *try* to test this out.
