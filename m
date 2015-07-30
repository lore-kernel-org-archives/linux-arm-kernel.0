From: sboyd@codeaurora.org (Stephen Boyd)
Date: Wed, 29 Jul 2015 17:27:54 -0700
Subject: [PATCH v5 06/10] clk: mediatek: mt8173: Fix enabling of critical
 clocks
In-Reply-To: <1438152754-11970-7-git-send-email-jamesjj.liao@mediatek.com>
References: <1438152754-11970-1-git-send-email-jamesjj.liao@mediatek.com>
 <1438152754-11970-7-git-send-email-jamesjj.liao@mediatek.com>
Message-ID: <20150730002754.GG3159@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/29, James Liao wrote:
> From: Sascha Hauer <s.hauer@pengutronix.de>
> 
> On the MT8173 the clocks are provided by different units. To enable
> the critical clocks we must be sure that all parent clocks are already
> registered, otherwise the parents of the critical clocks end up being
> unused and get disabled later.
> 
> On MT8173, for example, it is the CLK_TOP clocks that have CLK_APMIXED
> PLLs as their parents, so we cannot enable the CLK_TOP critical clocks
> until the CLK_APMIXED clocks have all been registered.
> 
> To find a place where all parents are registered we try each time
> after we've registered some clocks if all known providers are present
> now and only then we enable the critical clocks.
> 
> Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
> Signed-off-by: James Liao <jamesjj.liao@mediatek.com>
> ---

Please move up to v4.2-rc2 so that this patch can be dropped. I
already applied this and sent it off to Linus so it's in -rc2.

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
