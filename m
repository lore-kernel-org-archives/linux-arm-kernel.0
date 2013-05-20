From: sboyd@codeaurora.org (Stephen Boyd)
Date: Mon, 20 May 2013 14:17:16 -0700
Subject: [PATCH v4 3/5] clk: add support for clock reparent on set_rate
In-Reply-To: <1369056507-32521-4-git-send-email-james.hogan@imgtec.com>
References: <1369056507-32521-1-git-send-email-james.hogan@imgtec.com>
 <1369056507-32521-4-git-send-email-james.hogan@imgtec.com>
Message-ID: <519A92DC.2030208@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05/20/13 06:28, James Hogan wrote:
> diff --git a/Documentation/clk.txt b/Documentation/clk.txt
> index b9911c2..3110ba4 100644
> --- a/Documentation/clk.txt
> +++ b/Documentation/clk.txt
> @@ -70,6 +70,10 @@ the operations defined in clk.h:
>  						unsigned long parent_rate);
>  		long		(*round_rate)(struct clk_hw *hw, unsigned long,
>  						unsigned long *);
> +		long		(*determine_rate)(struct clk_hw *hw,
> +						unsigned long rate,
> +						unsigned long *best_parent_rate,
> +						struct clk **best_parent_clk);
>  		int		(*set_parent)(struct clk_hw *hw, u8 index);
>  		u8		(*get_parent)(struct clk_hw *hw);
>  		int		(*set_rate)(struct clk_hw *hw, unsigned long);

Can you update the clock hardware characteristics table as well?

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
hosted by The Linux Foundation
