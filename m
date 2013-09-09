From: shawn.guo@linaro.org (Shawn Guo)
Date: Mon, 9 Sep 2013 22:37:16 +0800
Subject: [PATCH] ARM: mach-imx: clk-imx51-imx53: Fix 'spdif1_pred' clock
 registration
In-Reply-To: <1378407777-26546-1-git-send-email-fabio.estevam@freescale.com>
References: <1378407777-26546-1-git-send-email-fabio.estevam@freescale.com>
Message-ID: <20130909143715.GE4624@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Sep 05, 2013 at 04:02:57PM -0300, Fabio Estevam wrote:
> Since commit beb2d1c1ba (ARM i.MX5: Add S/PDIF clocks), the following clock 
> error appears on mx51:
> 
> TrustZone Interrupt Controller (TZIC) initialized
> i.MX51 clk 180: register failed with -17
> i.MX5 clk 180: register failed with -17
> sched_clock: 32 bits at 24MHz, resolution 41ns, wraps every 178956ms
> CPU identified as i.MX51, silicon rev 3.0
> ...
> 
> Clock 180 corresponds to 'spdif1_podf' and this clock is getting registered 
> twice.
> 
> Fix it, by properly registering the 'spdif1_pred' clock, which should not 
> reference 'spdif1_podf'.
> 
> Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>

Applied, thanks.

Shawn
