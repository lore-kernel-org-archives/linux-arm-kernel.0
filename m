From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Tue, 26 Jul 2016 09:48:58 +0200
Subject: [PATCH v3 1/4] hwmon: iio_hwmon: delay probing with late_initcall
In-Reply-To: <1469519027-11387-2-git-send-email-quentin.schulz@free-electrons.com>
References: <1469519027-11387-1-git-send-email-quentin.schulz@free-electrons.com>
 <1469519027-11387-2-git-send-email-quentin.schulz@free-electrons.com>
Message-ID: <20160726094858.3aa96e18@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

On Tue, 26 Jul 2016 09:43:44 +0200, Quentin Schulz wrote:

> -module_platform_driver(iio_hwmon_driver);
> +static struct platform_driver * const drivers[] = {
> +	&iio_hwmon_driver,
> +};
> +
> +static int __init iio_hwmon_late_init(void)
> +{
> +	return platform_register_drivers(drivers, ARRAY_SIZE(drivers));

Why not platform_register_driver() ?

This would avoid the need to declare an array with just one entry.

Thomas
-- 
Thomas Petazzoni, CTO, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
