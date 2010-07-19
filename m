From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 19 Jul 2010 09:57:30 +0100
Subject: [PATCH 3/4] ARM: SAMSUNG SoC: Clock Framework: Flag Support
	for struct clk.
In-Reply-To: <1279528236-6076-4-git-send-email-myungjoo.ham@samsung.com>
References: <1279528236-6076-1-git-send-email-myungjoo.ham@samsung.com>
	<1279528236-6076-2-git-send-email-myungjoo.ham@samsung.com>
	<1279528236-6076-3-git-send-email-myungjoo.ham@samsung.com>
	<1279528236-6076-4-git-send-email-myungjoo.ham@samsung.com>
Message-ID: <20100719085730.GA8641@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jul 19, 2010 at 05:30:35PM +0900, MyungJoo Ham wrote:
> +#ifdef CONFIG_SAMSUNG_POWERDOMAIN
> +		if ((clk->flags | CLKFLAGS_BOOT_ON) &&

This is always true if CLKFLAGS_BOOT_ON is non-zero.

> +				!(clk->flags | CLKFLAGS_CANNOT_DISABLE)) {

This is always false if CLKFLAGS_CANNOT_DISABLE is non-zero.

> +		if (clk->enable && !(clk->flags | CLKFLAGS_CANNOT_DISABLE))

Always false...
