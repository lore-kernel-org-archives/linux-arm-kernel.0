From: shawnguo@kernel.org (Shawn Guo)
Date: Thu, 31 Mar 2016 19:37:28 +0800
Subject: [PATCH 06/18] ARM: imx: clk-gate2: allow custom gate configuration
In-Reply-To: <1457576219-7971-7-git-send-email-stefan@agner.ch>
References: <1457576219-7971-1-git-send-email-stefan@agner.ch>
 <1457576219-7971-7-git-send-email-stefan@agner.ch>
Message-ID: <20160331113728.GA18833@tiger>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Mar 09, 2016 at 06:16:47PM -0800, Stefan Agner wrote:
> The 2-bit gates found i.MX and Vybrid SoC support different clock
> configuration:
> 
> 0b00: clk disabled
> 0b01: clk enabled in RUN mode but disabled in WAIT and STOP mode
> 0b10: clk enabled in RUN, WAIT and STOP mode (only Vybrid)
> 0b11: clk enabled in RUN and WAIT mode
> 
> For some clocks, we might want to configure different behaviour,
> e.g. a memory clock should be on even in STOP mode. Add a new
> function imx_clk_gate2_cgr which allow to configure specific
> gate values through the cgr_val parameter.
> 
> Signed-off-by: Stefan Agner <stefan@agner.ch>

It's not appropriate to use 'ARM:' as subject prefix any more, since
clock drivers had been moved to drivers/clk.

I applied patch 6 ~ 9 with updating the subject prefix as below.

clk: imx: vf610: add suspend/resume support
clk: imx: vf610: add WKPU unit
clk: imx: vf610: leave DDR clock on
clk: imx: clk-gate2: allow custom gate configuration

Shawn
