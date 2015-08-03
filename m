From: sboyd@codeaurora.org (Stephen Boyd)
Date: Mon, 3 Aug 2015 12:24:27 -0700
Subject: [PATCH v7 01/13] clk: qcom: Add support for GDSCs
In-Reply-To: <1438076046-4706-2-git-send-email-rnayak@codeaurora.org>
References: <1438076046-4706-1-git-send-email-rnayak@codeaurora.org>
 <1438076046-4706-2-git-send-email-rnayak@codeaurora.org>
Message-ID: <20150803192427.GA7096@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/28, Rajendra Nayak wrote:
> +
> +#define PWR_ON_MASK		BIT(31)
> +#define EN_REST_WAIT_MASK	GENMASK(23, 20)
> +#define EN_FEW_WAIT_MASK	GENMASK(19, 16)
> +#define CLK_DIS_WAIT_MASK	GENMASK(15, 12)

This trips up some static checker...

drivers/clk/qcom/gdsc.c:234:53: warning: cast truncates bits from
constant value (fffffffffff006 becomes fffff006)

So I think we can use GENMASK_ULL here instead.

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
