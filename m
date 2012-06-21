From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Thu, 21 Jun 2012 11:15:36 +0100
Subject: [V2 1/3] regulator: add pre-regulator support for 88pm860x
In-Reply-To: <1340259538-24239-1-git-send-email-jtzhou@marvell.com>
References: <1340259538-24239-1-git-send-email-jtzhou@marvell.com>
Message-ID: <20120621101536.GR4037@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jun 21, 2012 at 02:18:58PM +0800, Jett.Zhou wrote:

> +static struct regulator_consumer_supply preg_supply[] = {
> +	REGULATOR_SUPPLY("preg", NULL),
> +};

This looks wrong, why is there no dev_name being specified?

> +static struct regulator_init_data preg_init_data = {
> +	.num_consumer_supplies	= 1,
> +	.consumer_supplies	= &preg_supply[0],
> +};

Use ARRAY_SIZE() since it's an array.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120621/bea6d848/attachment.sig>
