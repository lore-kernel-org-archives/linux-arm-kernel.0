From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Sun, 2 Aug 2015 23:06:26 +0100
Subject: [PATCH 3/4] ARM: nomadik: move l2x0 setup to device tree
In-Reply-To: <1438552593-4578-1-git-send-email-linus.walleij@linaro.org>
References: <1438552593-4578-1-git-send-email-linus.walleij@linaro.org>
Message-ID: <20150802220626.GG7557@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Aug 02, 2015 at 11:56:33PM +0200, Linus Walleij wrote:
> -	/* At full speed latency must be >=2, so 0x249 in low bits */
> -	.l2c_aux_val	= 0x00700249,
> -	.l2c_aux_mask	= 0xfe0fefff,
> +	.l2c_aux_val	= 0x0,
> +	.l2c_aux_mask	= ~0x0UL,

It always amazes me by the things people come up with... what prompted
the addition of "UL" on that constant?  Why do you think it needs it?

A simple:

	.l2c_aux_val	= 0,
	.l2c_aux_mask	= ~0,

will suffice.

-- 
FTTC broadband for 0.8mile line: currently at 10.5Mbps down 400kbps up
according to speedtest.net.
