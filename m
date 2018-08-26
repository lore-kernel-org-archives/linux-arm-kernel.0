From: andrew@lunn.ch (Andrew Lunn)
Date: Sun, 26 Aug 2018 21:04:45 +0200
Subject: [PATCH 1/2] gpio: ftgpio: Support optional silicon clock
In-Reply-To: <20180826110321.17723-1-linus.walleij@linaro.org>
References: <20180826110321.17723-1-linus.walleij@linaro.org>
Message-ID: <20180826190445.GB7359@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> +	g->clk = devm_clk_get(dev, NULL);
> +	if (!IS_ERR(g->clk)) {
> +		ret = clk_prepare_enable(g->clk);
> +		if (ret)
> +			return ret;
> +	}

Hi Linus

Is there any chance devm_clk_get() could return -EPROBE_DIFFERED?

   Andrew
