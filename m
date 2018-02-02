From: shawnguo@kernel.org (Shawn Guo)
Date: Fri, 2 Feb 2018 14:16:41 +0800
Subject: [PATCH v2 1/7] ARM: imx: add timer stop flag to ARM power off
 state
In-Reply-To: <20180110210453.19264-1-stefan@agner.ch>
References: <20180110210453.19264-1-stefan@agner.ch>
Message-ID: <20180202061605.GL20833@dragon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jan 10, 2018 at 10:04:47PM +0100, Stefan Agner wrote:
> When the CPU is in ARM power off state the ARM architected
> timers are stopped. The flag is already present in the higher
> power WAIT mode.
> 
> This allows to use the ARM generic timer on i.MX 6UL/6ULL SoC.
> Without the flag the kernel freezes when the timer enters the
> first time ARM power off mode.
> 
> Note: The default timer on i.MX6SX is the i.MX GPT timer which is
> not disabled during CPU idle. However, the timer is not affected
> by the CPUIDLE_FLAG_TIMER_STOP flag. The flag only affects CPU
> local timers.
> 
> Cc: Anson Huang <anson.huang@nxp.com>
> Signed-off-by: Stefan Agner <stefan@agner.ch>
> Reviewed-by: Lucas Stach <l.stach@pengutronix.de>

Applied all, thanks.
