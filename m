From: rabin@rab.in (Rabin Vincent)
Date: Mon, 21 Jun 2010 21:11:21 +0530
Subject: [PATCH V2] GPIO PL061: Adding Clk framework support
In-Reply-To: <1277103463-7311-1-git-send-email-viresh.kumar@st.com>
References: <1277103463-7311-1-git-send-email-viresh.kumar@st.com>
Message-ID: <20100621154121.GA4290@debian>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jun 21, 2010 at 12:27:43PM +0530, Viresh KUMAR wrote:
> GPIO Clk is never enabled on Platforms, like: SPEAr, which are based upon clock
> framework and use PL061 driver. This patch adds support for Clk enabling and
> disabling as and when gpios are requested and freed.
[...]
> +	chip->clk = clk_get(&dev->dev, NULL);
> +	if (IS_ERR(chip->clk)) {
> +		ret = PTR_ERR(chip->clk);
> +		goto iounmap;
> +	}

Have you verified that all platforms using this driver already have
clocks with the appropriate names?   Otherwise this patch will break
those platforms.

Rabin
