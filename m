From: sboyd@kernel.org (Stephen Boyd)
Date: Fri, 06 Apr 2018 11:22:23 -0700
Subject: [PATCH] clk: imx: Set CLK_SET_RATE_GATE for gate and divider
 clocks
In-Reply-To: <1521812006-6173-1-git-send-email-abel.vesa@nxp.com>
References: <1521812006-6173-1-git-send-email-abel.vesa@nxp.com>
Message-ID: <152303894318.143116.719157250286888372@swboyd.mtv.corp.google.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Quoting Abel Vesa (2018-03-23 06:33:26)
> Add flag CLK_SET_RATE_GATE for i.MX gate and divider clocks on which the
> client drivers usually make clk_set_rate() call, so that the call will fail
> when clock is still on instead of standing the risk of running into glitch
> issue. Rate cannot be changed when the clock is enabled due to the glitchy
> multiplexers.
> 
> Signed-off-by: Shawn Guo <shawnguo@kernel.org>
> [initial patch from imx internal repo]
> Signed-off-by: Abel Vesa <abel.vesa@nxp.com>
> [carried over from 3.14 and also applied the flag to newer functions]

Is Shawn the author of this patch?
