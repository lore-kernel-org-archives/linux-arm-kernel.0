From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 25 Feb 2010 21:58:54 +0000
Subject: [PATCH v2] MXC: mach_armadillo5x0: Add USB Host support.
In-Reply-To: <1267090904.2722.8.camel@realization>
References: <1267090904.2722.8.camel@realization>
Message-ID: <20100225215854.GD24043@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Feb 25, 2010 at 10:41:44AM +0100, Alberto Panizzo wrote:
> +	if (gpio_direction_output(OTG_RESET, 1/*HIGH*/)) {
> +		pr_warning("Failed to reset usbotg phy \n");
> +		return -1;

Always propagate error codes.  Don't invent your own - especially when
they mean "permission denied".

> +	if (gpio_direction_output(USBH2_RESET, 1/*HIGH*/)) {
> +		pr_warning("Failed to reset usbh2 phy \n");
> +		return -1;

Ditto.

Never use -1 as an error code - always use a proper error code from errno*.h
