From: sboyd@codeaurora.org (Stephen Boyd)
Date: Wed, 21 Oct 2015 16:15:46 -0700
Subject: [PATCH 4/5] clk: imx31: add missing of_node_put
In-Reply-To: <1445460100-26727-5-git-send-email-Julia.Lawall@lip6.fr>
References: <1445460100-26727-1-git-send-email-Julia.Lawall@lip6.fr>
 <1445460100-26727-5-git-send-email-Julia.Lawall@lip6.fr>
Message-ID: <20151021231546.GK19782@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/21, Julia Lawall wrote:
> for_each_compatible_node performs an of_node_get on each iteration, so a
> break out of the loop requires an of_node_put.
> 
> The semantic patch that fixes this problem is as follows
> (http://coccinelle.lip6.fr):
> 
> // <smpl>
> @@
> local idexpression n;
> expression e;
> @@
> 
>  for_each_compatible_node(n,...) {
>    ...
> (
>    of_node_put(n);
> |
>    e = n
> |
> +  of_node_put(n);
> ?  break;
> )
>    ...
>  }
> ... when != n
> // </smpl>
> 
> Signed-off-by: Julia Lawall <Julia.Lawall@lip6.fr>
> 
> ---

Applied to clk-next

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
