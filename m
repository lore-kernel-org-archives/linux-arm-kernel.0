From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 29 Oct 2012 12:17:23 +0000
Subject: [PATCH] MMCI: fetch pinctrl handle and set default state
In-Reply-To: <1350892326-5125-1-git-send-email-linus.walleij@stericsson.com>
References: <1350892326-5125-1-git-send-email-linus.walleij@stericsson.com>
Message-ID: <20121029121723.GG21164@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Oct 22, 2012 at 09:52:06AM +0200, Linus Walleij wrote:
> +	/* enable pins to be muxed in and configured */
> +	if (!IS_ERR(host->pins_default)) {
> +		ret = pinctrl_select_state(host->pinctrl, host->pins_default);
> +		if (ret)
> +			dev_err(&dev->dev, "could not set default pins\n");
> +	} else
> +		dev_err(&dev->dev, "could not get default pinstate\n");

Umm, are these errors or warnings?  Arguably, because we continue,
these seem to me to be warnings.

In my mind, a warning message is one which is reporting a condition which
we can continue from, whereas an error message is a condition which causes
immediate failure.  (Think about GCC... with warnings you still get code,
but the code may not be correct, but if you see an error message you don't
get any code.)
