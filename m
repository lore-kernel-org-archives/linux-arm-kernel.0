From: richard.zhao@freescale.com (Richard Zhao)
Date: Mon, 19 Mar 2012 09:54:34 +0800
Subject: [PATCH 1/2] ARM: imx6q: add pll round_rate support
In-Reply-To: <1331713379-8437-2-git-send-email-richard.zhao@linaro.org>
References: <1331713379-8437-1-git-send-email-richard.zhao@linaro.org>
 <1331713379-8437-2-git-send-email-richard.zhao@linaro.org>
Message-ID: <20120319015433.GB2603@b20223-02.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> +static unsigned long pll_av_round_rate(struct clk *clk, unsigned long rate)
> +{
> +	unsigned long parent_rate = clk_get_rate(clk->parent);
> +	u32 div;
> +	u32 mfn, mfd = 1000000;
> +	s64 temp64;
> +
> +	rate = rate < FREQ_650M ? FREQ_650M : rate;
> +	rate = rate > FREQ_1300M ? FREQ_1300M : rate;
> +
> +	div = rate / parent_rate;
> +	temp64 = (u64) (parent_rate - (div * parent_rate));
Be			rate here.
Sorry.
> +        temp64 *= mfd;
> +        do_div(temp64, parent_rate);
> +        mfn = temp64;
> +
> +        return (parent_rate * div) + ((parent_rate / mfd) * mfn);
> +}
> +
 
Thanks
Richard
