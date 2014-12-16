From: shawn.guo@linaro.org (Shawn Guo)
Date: Tue, 16 Dec 2014 17:02:20 +0800
Subject: [PATCH V3] arm: imx: correct the hardware clock gate setting for
 shared nodes
In-Reply-To: <1418205102-14598-1-git-send-email-b20788@freescale.com>
References: <1418205102-14598-1-git-send-email-b20788@freescale.com>
Message-ID: <20141216090218.GI2411@dragon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Dec 10, 2014 at 05:51:42PM +0800, Anson Huang wrote:
> For those clk gates which hold share count, since its is_enabled
> callback is only checking the share count rather than reading
> the hardware register setting, in the late phase of kernel bootup,
> the clk_disable_unused action will NOT handle the scenario of
> share_count is 0 but the hardware setting is enabled, actually,
> U-Boot normally enables all clk gates, then those shared clk gates
> will be always enabled until they are used by some modules.
> 
> So the problem would be: when kernel boot up, the usecount cat
> from clk tree is 0, but the clk gates actually is enabled in
> hardware register, it will confuse user and bring unnecessary power
> consumption.
> 
> This patch adds .disable_unused callback and using hardware register
> check for .is_enabled callback of shared nodes to handle such scenario
> in late phase of kernel boot up, then the hardware status will match the
> clk tree info.
> 
> Signed-off-by: Anson Huang <b20788@freescale.com>

Applied, thanks.
