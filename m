From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 18 Apr 2013 16:36:11 +0100
Subject: [PATCH v2 1/2] ARM: shmobile: R8A7779: add Ether support
In-Reply-To: <201304042253.50662.sergei.shtylyov@cogentembedded.com>
References: <201304042253.50662.sergei.shtylyov@cogentembedded.com>
Message-ID: <20130418153611.GX14496@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Apr 04, 2013 at 10:53:50PM +0400, Sergei Shtylyov wrote:
> +/* Ether */
> +static struct resource ether_resources[] = {
> +	{
> +		.start	= 0xfde00000,
> +		.end	= 0xfde003ff,
> +		.flags	= IORESOURCE_MEM,
> +	}, {
> +		.start	= gic_iid(0xb4),
> +		.flags	= IORESOURCE_IRQ,
> +	},

There are macros for initializing these which have been around for a
few years now.  Please consider using them in future.
