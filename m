From: sboyd@codeaurora.org (Stephen Boyd)
Date: Thu, 30 Apr 2015 16:20:02 -0700
Subject: [PATCH v3 1/2] clk: track the orphan status of clocks and their
 children
In-Reply-To: <1429735986-18592-2-git-send-email-heiko@sntech.de>
References: <1429735986-18592-1-git-send-email-heiko@sntech.de>
 <1429735986-18592-2-git-send-email-heiko@sntech.de>
Message-ID: <20150430232002.GA32407@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/22, Heiko Stuebner wrote:
> @@ -1401,18 +1402,40 @@ static int clk_fetch_parent_index(struct clk_core *clk,
>  	return -EINVAL;
>  }
>  
> +/*
> + * Update the orphan status of @clk and all its children.
> + */
> +static void clk_core_update_orphan_status(struct clk_core *clk, bool is_orphan)

Missed s/clk/core/ here. I did it, no need to resend.

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
