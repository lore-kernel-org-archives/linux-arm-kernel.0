From: sboyd@codeaurora.org (Stephen Boyd)
Date: Fri, 15 Apr 2016 17:31:28 -0700
Subject: [PATCH v3 1/9] ARM: imx: clk-vf610: fix DCU clock tree
In-Reply-To: <1459834121-25997-2-git-send-email-stefan@agner.ch>
References: <1459834121-25997-1-git-send-email-stefan@agner.ch>
 <1459834121-25997-2-git-send-email-stefan@agner.ch>
Message-ID: <20160416003128.GJ26353@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/04, Stefan Agner wrote:
> Similar to an earlier fix for the SAI clocks, the DCU clock hierarchy
> mixes the bus clock with the display controllers pixel clock. Tests
> have shown that the gates in CCM_CCGR3/9 registers do not control
> the DCU pixel clock, but only the register access clock (bus clock).
> 
> Fix this by defining the parent clock of VF610_CLK_DCUx to be the bus
> clock (ipg_bus).
> 
> Since the clock has not been used far, there are no further changes
> needed.
> 
> Signed-off-by: Stefan Agner <stefan@agner.ch>
> ---

Acked-by: Stephen Boyd <sboyd@codeaurora.org>

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
