From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 18 Apr 2013 16:44:25 +0100
Subject: [PATCH 1/8] ARM: shmobile:Marzen: move USB EHCI, OHCI, and PHY
 devices to R8A7779 code
In-Reply-To: <201304050257.00799.sergei.shtylyov@cogentembedded.com>
References: <201304050257.00799.sergei.shtylyov@cogentembedded.com>
Message-ID: <20130418154425.GZ14496@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Apr 05, 2013 at 02:57:00AM +0400, Sergei Shtylyov wrote:
> +/* USB PHY */
> +static struct resource usb_phy_resources[] = {
> +	[0] = {
> +		.start		= 0xffe70000,
> +		.end		= 0xffe70900 - 1,
> +		.flags		= IORESOURCE_MEM,
> +	},
> +	[1] = {
> +		.start		= 0xfff70000,
> +		.end		= 0xfff70900 - 1,
> +		.flags		= IORESOURCE_MEM,
> +	},

Please consider using the macros for these initialisers.

> +static struct resource ehci0_resources[] = {
> +	[0] = {
> +		.start	= 0xffe70000,
> +		.end	= 0xffe70400 - 1,
> +		.flags	= IORESOURCE_MEM,
> +	},
> +	[1] = {
> +		.start	= gic_iid(0x4c),
> +		.flags	= IORESOURCE_IRQ,
> +	},

Ditto.

> +static struct resource ehci1_resources[] = {
> +	[0] = {
> +		.start	= 0xfff70000,
> +		.end	= 0xfff70400 - 1,
> +		.flags	= IORESOURCE_MEM,
> +	},
> +	[1] = {
> +		.start	= gic_iid(0x4d),
> +		.flags	= IORESOURCE_IRQ,
> +	},

Ditto.

> +static struct resource ohci0_resources[] = {
> +	[0] = {
> +		.start	= 0xffe70400,
> +		.end	= 0xffe70800 - 1,
> +		.flags	= IORESOURCE_MEM,
> +	},
> +	[1] = {
> +		.start	= gic_iid(0x4c),
> +		.flags	= IORESOURCE_IRQ,
> +	},

Ditto.

> +static struct resource ohci1_resources[] = {
> +	[0] = {
> +		.start	= 0xfff70400,
> +		.end	= 0xfff70800 - 1,
> +		.flags	= IORESOURCE_MEM,
> +	},
> +	[1] = {
> +		.start	= gic_iid(0x4d),
> +		.flags	= IORESOURCE_IRQ,
> +	},

Ditto.
