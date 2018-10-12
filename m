From: jagan@openedev.com (Jagan Teki)
Date: Fri, 12 Oct 2018 13:43:32 +0530
Subject: [linux-sunxi] [PATCH v2 04/29] clk: sunxi-ng: h6: Set video PLLs
 limits
In-Reply-To: <20181007093905.11253-5-jernej.skrabec@siol.net>
References: <20181007093905.11253-1-jernej.skrabec@siol.net>
 <20181007093905.11253-5-jernej.skrabec@siol.net>
Message-ID: <a303145c-b123-d912-91d7-9830dec3244e@openedev.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sunday 07 October 2018 03:08 PM, Jernej Skrabec wrote:
> Video PLL factors can be set in a way that final PLL rate is outside
> stable range. H6 user manual specifically says that N factor should not
> be below 12. While it doesn't says anything about maximum stable rate, it

Manual says "In application, PLL_FACTOR_N should be more than or equal 
to 11" can't it be 11?

> is clear that PLL doesn't work at 6.096 GHz (254 * 24 MHz).
> 
> Set minimum allowed PLL video rate to 288 MHz (12 * 24 MHz) and maximum
> to 2.4 GHz, which is maximum in BSP driver.

Is this max freq from here [1]

[1] 
https://github.com/Allwinner-Homlet/H6-BSP4.9-linux/blob/master/drivers/clk/sunxi/clk-sun50iw6.c#L164
