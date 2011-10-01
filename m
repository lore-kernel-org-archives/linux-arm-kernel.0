From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Sat, 1 Oct 2011 16:29:38 +0100
Subject: [PATCH 1/2] ARM: CLKDEV: Add Common Macro for clk_lookup
In-Reply-To: <1317381097-2691-2-git-send-email-padma.v@samsung.com>
References: <1317381097-2691-1-git-send-email-padma.v@samsung.com>
	<1317381097-2691-2-git-send-email-padma.v@samsung.com>
Message-ID: <20111001152938.GD11710@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Sep 30, 2011 at 04:41:36PM +0530, Padmavathi Venna wrote:
> +#define CLKDEV_INIT(d, n, c) \
> +	{ \
> +		.dev_id = d, \
> +		.con_id = n, \
> +		.clk = &c, \
> +	},
> +

As Heartley says, the trailing , and the end should not be there - it
should be with each use of CLKDEV_INIT().  The reasoning is that it
makes the use of macros much more conventional and consistent throughout
the kernel:

struct cl_lookup foo_lookups[] = {
	CLKDEV_INIT(...),
	CLKDEV_INIT(...),
};

struct cl_lookup bar_lookup = CLKDEV_INIT(...);

Could you re-spin with that change please?

Thanks.
