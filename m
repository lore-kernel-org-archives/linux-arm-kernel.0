From: shawnguo@kernel.org (Shawn Guo)
Date: Tue, 21 Jun 2016 14:36:03 +0800
Subject: [PATCH] [V2] ARM: imx6: fix static declaration in
 include/soc/imx/cpuidle.h
In-Reply-To: <1466175101-18812-1-git-send-email-ben.dooks@codethink.co.uk>
References: <1466175101-18812-1-git-send-email-ben.dooks@codethink.co.uk>
Message-ID: <20160621063602.GD21364@tiger>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jun 17, 2016 at 03:51:41PM +0100, Ben Dooks wrote:
> If both CONFIG_CPU_IDLE or CONFIG_SOC_IMX6Q are not set
> then the imx6q_cpuidle_fec_irqs_used() and other functions
> should be marked static inline to avoid the following
> warnings whilst building drivers/net/ethernet/freescale:
> 
> include/soc/imx/cpuidle.h:21:6: warning: symbol 'imx6q_cpuidle_fec_irqs_used' was not declared. Should it be static?
> include/soc/imx/cpuidle.h:22:6: warning: symbol 'imx6q_cpuidle_fec_irqs_unused' was not declared. Should it be static?
> 
> Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>

Applied, thanks.
