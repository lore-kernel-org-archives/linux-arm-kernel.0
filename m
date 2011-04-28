From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 28 Apr 2011 10:05:28 +0100
Subject: [PATCH v2] pxa/hx4700: use gpio arrays for global gpio
	initialization
In-Reply-To: <1303930220.14964.8.camel@flow>
References: <1303329317.21545.5.camel@flow> <20110421150226.GA10052@rainbow>
	<1303930220.14964.8.camel@flow>
Message-ID: <20110428090528.GN17290@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Apr 27, 2011 at 08:50:19PM +0200, Philipp Zabel wrote:
> -	hx4700_gpio_request(ARRAY_AND_SIZE(global_gpios));
> +	ret = gpio_request_array(ARRAY_AND_SIZE(global_gpios));
> +	if (ret)
> +		pr_err ("hx4700: Failed to request GPIOs.\n");

No space between pr_err and (.

Does the return code convey useful information as to _why_ it failed?  If
yes, you really should print its value.  Knowing whether it's -EBUSY
(eg, already in use) instead of -EINVAL (eg, invalid GPIO number) really
helps to debug problems.
