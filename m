From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 24 Nov 2011 21:11:25 +0000
Subject: [PATCH] mx28: added LRADC and touchscreen support
In-Reply-To: <1322135394-4097-1-git-send-email-rusko.peter@prolan.hu>
References: <1322135394-4097-1-git-send-email-rusko.peter@prolan.hu>
Message-ID: <20111124211125.GY9581@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Nov 24, 2011 at 12:49:54PM +0100, Peter Rusko wrote:
> +	struct resource res[] = {
> +		{
> +			.start = MX28_LRADC_BASE_ADDR,
> +			.end = MX28_LRADC_BASE_ADDR + SZ_16K - 1,
> +			.flags = IORESOURCE_MEM,
> +		},

The other thing which I forgot to mention is...

	struct resource res[] = {
		DEFINE_RES_MEM(MX28_LRADC_BASE_ADDR, SZ_16K),
	};

is much neater.
