From: sboyd@codeaurora.org (Stephen Boyd)
Date: Thu, 21 Dec 2017 16:34:08 -0800
Subject: [PATCH v6 1/3] clk: at91: pmc: Wait for clocks when resuming
In-Reply-To: <20171211165535.5126-2-romain.izard.pro@gmail.com>
References: <20171211165535.5126-1-romain.izard.pro@gmail.com>
 <20171211165535.5126-2-romain.izard.pro@gmail.com>
Message-ID: <20171222003408.GV7997@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 12/11, Romain Izard wrote:
> Wait for the syncronization of all clocks when resuming, not only the
> UPLL clock. Do not use regmap_read_poll_timeout, as it will call BUG()
> when interrupts are masked, which is the case in here.
> 
> Signed-off-by: Romain Izard <romain.izard.pro@gmail.com>
> Acked-by: Ludovic Desroches <ludovic.desroches@microchip.com>
> Acked-by: Nicolas Ferre <nicolas.ferre@microchip.com>
> ---

Applied to clk-next

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
