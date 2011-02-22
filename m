From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 22 Feb 2011 20:56:34 +0000
Subject: [PATCH 5/7] ARM: tegra: timer: Enable timer and rtc clocks
In-Reply-To: <1298342392-21236-6-git-send-email-ccross@android.com>
References: <1298342392-21236-1-git-send-email-ccross@android.com>
	<1298342392-21236-6-git-send-email-ccross@android.com>
Message-ID: <20110222205634.GF29559@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Feb 21, 2011 at 06:39:50PM -0800, Colin Cross wrote:
> +	struct clk *clk;
>  	unsigned long rate = clk_measure_input_freq();
>  	int ret;
>  
> +	clk = clk_get_sys("timer", NULL);
> +	BUG_ON(IS_ERR(clk));
> +	clk_enable(clk);
> +	clk_put(clk);
> +
> +	clk = clk_get_sys("rtc-tegra", NULL);
> +	BUG_ON(IS_ERR(clk));
> +	clk_enable(clk);
> +	clk_put(clk);

It's probably better to leave them get'd if you're continuing to use
them and just forget the reference.
