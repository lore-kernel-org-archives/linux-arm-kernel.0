From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Thu, 31 May 2012 14:57:40 +0100
Subject: [PATCH 2/2] MFD: mc13xxx workaround SPI hardware bug on i.Mx
In-Reply-To: <2358422.efTs8lXp1l@laptop>
References: <1338282389-26177-1-git-send-email-philippe.retornaz@epfl.ch>
 <1338282389-26177-3-git-send-email-philippe.retornaz@epfl.ch>
 <20120530170837.GR9947@opensource.wolfsonmicro.com>
 <2358422.efTs8lXp1l@laptop>
Message-ID: <20120531135739.GH2666@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, May 31, 2012 at 09:08:39AM +0200, Philippe R?tornaz wrote:

> I already put it in struct regmap_config, should I put it elsewhere ? 

> @@ -54,6 +54,67 @@ static struct regmap_config mc13xxx_regmap_spi_config = {
>         .max_register = MC13XXX_NUMREGS,
>  
>         .cache_type = REGCACHE_NONE,
> +       .use_single_rw = 1,
> +};

That's fine, I'd just expected to see it here.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120531/9f8a5d68/attachment.sig>
