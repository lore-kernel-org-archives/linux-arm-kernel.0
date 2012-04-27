From: shawn.guo@linaro.org (Shawn Guo)
Date: Fri, 27 Apr 2012 14:21:22 +0800
Subject: [PATCH 22/33] ARM: imx: add common clock support for pllv3
In-Reply-To: <1335367703-19929-23-git-send-email-s.hauer@pengutronix.de>
References: <1335367703-19929-1-git-send-email-s.hauer@pengutronix.de>
 <1335367703-19929-23-git-send-email-s.hauer@pengutronix.de>
Message-ID: <20120427062120.GL2234@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Apr 25, 2012 at 05:28:12PM +0200, Sascha Hauer wrote:
> +static long clk_pllv3_round_rate(struct clk_hw *hw, unsigned long rate,
> +				 unsigned long *prate)
> +{
> +	unsigned long parent_rate = __clk_get_rate(__clk_get_parent(hw->clk));

With patch 81536e0 (clk: always pass parent_rate into .round_rate) in
there, *prate is just the parent_rate.  That said, we do not need to
call __clk_get_rate and __clk_get_parent anywhere in this file.

> +
> +	return (rate >= parent_rate * 22) ? parent_rate * 22 :
> +					    parent_rate * 20;
> +}

-- 
Regards,
Shawn
