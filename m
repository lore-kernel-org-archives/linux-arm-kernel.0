From: ben.dooks@codethink.co.uk (Ben Dooks)
Date: Fri, 17 Jun 2016 15:52:07 +0100
Subject: [PATCH] ARM: imx6: fix static declaration in
 include/soc/imx/cpuidle.h
In-Reply-To: <1466174835-17703-1-git-send-email-ben.dooks@codethink.co.uk>
References: <1466174835-17703-1-git-send-email-ben.dooks@codethink.co.uk>
Message-ID: <8568541a-e58c-5331-9b1b-638e760a394c@codethink.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 17/06/16 15:47, Ben Dooks wrote:
> If both CONFIG_CPU_IDLE or CONFIG_SOC_IMX6Q are not set
> then the imx6q_cpuidle_fec_irqs_used() and other functions
> should be marked static inline to avoid the following
> warnings whilst building drivers/net/ethernet/freescale:
> 
> include/soc/imx/cpuidle.h:21:6: warning: symbol 'imx6q_cpuidle_fec_irqs_used' was not declared. Should it be static?
> include/soc/imx/cpuidle.h:22:6: warning: symbol 'imx6q_cpuidle_fec_irqs_unused' was not declared. Should it be static?
> 
> Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>

Apologies, failed to properly merge the inline fix in.
Resend as V2.

-- 
Ben Dooks				http://www.codethink.co.uk/
Senior Engineer				Codethink - Providing Genius
