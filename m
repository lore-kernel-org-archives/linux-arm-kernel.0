From: vinod.koul@linux.intel.com (Vinod Koul)
Date: Thu, 14 Jun 2012 16:13:58 +0530
Subject: [PATCH v2 1/5] dmaengine: mmp_tdma: add mmp tdma support
In-Reply-To: <1339409081-10097-2-git-send-email-zhangfei.gao@marvell.com>
References: <1339409081-10097-1-git-send-email-zhangfei.gao@marvell.com>
 <1339409081-10097-2-git-send-email-zhangfei.gao@marvell.com>
Message-ID: <1339670638.1927.1641.camel@vkoul-udesk3>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 2012-06-11 at 18:04 +0800, Zhangfei Gao wrote:
> +static int mmp_tdma_clear_chan_irq(struct mmp_tdma_chan *tdmac)
> +{
> +       u32 reg = readl(tdmac->reg_base + TDISR);
> +
> +       if (reg & TDISR_COMP) {
> +               /* clear irq */
> +               reg &= ~TDISR_COMP;
> +               writel(reg, tdmac->reg_base + TDISR);
> +
> +               return 0;
> +       }
> +       return -1;
> +} 
-1?
Please return a proper linux error code.


-- 
~Vinod
