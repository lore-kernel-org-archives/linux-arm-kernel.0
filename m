From: sboyd@codeaurora.org (Stephen Boyd)
Date: Thu, 28 Dec 2017 14:57:13 -0800
Subject: [PATCH v1 2/4] clk: iproc: Fix error in the pll post divider
 rate calculation
In-Reply-To: <1502737241-2040-3-git-send-email-lori.hikichi@broadcom.com>
References: <1502737241-2040-1-git-send-email-lori.hikichi@broadcom.com>
 <1502737241-2040-3-git-send-email-lori.hikichi@broadcom.com>
Message-ID: <20171228225713.GU7997@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08/14, Lori Hikichi wrote:
> The pll post divider code was using DIV_ROUND_UP when determining the
> divider value best suited to produce the target frequency.
> Using DIV_ROUND_CLOSEST will give us better divider values when
> the division results in a small remainder.
> Also, change the post divider clock over to the determine_rate api
> instead of round_rate.
> 
> Signed-off-by: Simran Rai <ssimran@broadcom.com>
> Signed-off-by: Lori Hikichi <lori.hikichi@broadcom.com>
> ---

Applied to clk-next

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
