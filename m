From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Fri, 7 Mar 2014 19:22:13 +0100
Subject: [PATCH 6/7] regulator: AXP20x: Add support for regulators
 subsystem
In-Reply-To: <1393692352-10839-7-git-send-email-carlo@caione.org>
References: <1393692352-10839-1-git-send-email-carlo@caione.org>
 <1393692352-10839-7-git-send-email-carlo@caione.org>
Message-ID: <20140307182213.GC607@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Mar 01, 2014 at 05:45:51PM +0100, Carlo Caione wrote:
> +static struct platform_driver axp20x_regulator_driver = {
> +	.probe	= axp20x_regulator_probe,
> +	.remove	= axp20x_regulator_remove,
> +	.driver	= {
> +		.name		= "axp20x-regulator",
> +		.owner		= THIS_MODULE,
> +	},
> +};
> +
> +static int __init axp20x_regulator_init(void)
> +{
> +	return platform_driver_register(&axp20x_regulator_driver);
> +}
> +
> +subsys_initcall(axp20x_regulator_init);

Hmmm, really?

I thought the AXP was only connected through I2C? How is that a
platform device then?

-- 
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140307/f0704cd2/attachment.sig>
