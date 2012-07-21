From: shawn.guo@linaro.org (Shawn Guo)
Date: Sat, 21 Jul 2012 15:03:49 +0800
Subject: [alsa-devel] [PATCH 1/4] ASoC: mxs-saif: fix clock prepare and
 enable unbalance issue
In-Reply-To: <1342776027-31758-2-git-send-email-b29396@freescale.com>
References: <1342776027-31758-1-git-send-email-b29396@freescale.com>
 <1342776027-31758-2-git-send-email-b29396@freescale.com>
Message-ID: <20120721070346.GA923@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jul 20, 2012 at 05:20:24PM +0800, Dong Aisheng wrote:
> From: Dong Aisheng <dong.aisheng@linaro.org>
> 
> Currently we directly call a clock_enable in trigger function without
> a clk_prepare as pair first.
> This will cause system hang immediately when run capture because
> the clock was not prepared(playback does not hang because the clock was
> prepared already by get_mclk before), a warning message in clock framework
> may cause a deadlock to reclaim clock lock (see: pl011_console_write).
> 
> Here we prepare clock first in hw_param, then enable it in trigger
> function to guarantee the balance.
> 
> Cc: Mark Brown <broonie@opensource.wolfsonmicro.com>
> Cc: Liam Girdwood <lrg@ti.com>
> Cc: Wolfram Sang <w.sang@pengutronix.de>
> Cc: Shawn Guo <shawn.guo@linaro.org>

Acked-by: Shawn Guo <shawn.guo@linaro.org>
