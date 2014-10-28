From: broonie@kernel.org (Mark Brown)
Date: Tue, 28 Oct 2014 22:31:21 +0000
Subject: [PATCH v5 3/4] regulator: max77686: Add suspend disable for some
 LDOs
In-Reply-To: <1414411911-5539-4-git-send-email-k.kozlowski@samsung.com>
References: <1414411911-5539-1-git-send-email-k.kozlowski@samsung.com>
 <1414411911-5539-4-git-send-email-k.kozlowski@samsung.com>
Message-ID: <20141028223121.GH18557@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Oct 27, 2014 at 01:11:49PM +0100, Krzysztof Kozlowski wrote:

> @@ -247,6 +250,8 @@ static struct regulator_ops max77686_ldo_ops = {
>  	.set_voltage_sel	= regulator_set_voltage_sel_regmap,
>  	.set_voltage_time_sel	= regulator_set_voltage_time_sel,
>  	.set_suspend_mode	= max77686_ldo_set_suspend_mode,
> +	.set_suspend_disable	= max77686_set_suspend_disable,
> +	.set_suspend_enable	= max77686_enable,

This looks wrong, you're using the regular enable operation as suspend
enable.  How does that work without disrupting the current runtime
state?
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20141028/0fc88ae1/attachment.sig>
