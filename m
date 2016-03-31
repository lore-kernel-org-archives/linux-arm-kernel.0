From: shawnguo@kernel.org (Shawn Guo)
Date: Thu, 31 Mar 2016 19:39:25 +0800
Subject: [PATCH 09/18] ARM: vf610: clk: add suspend/resume support
In-Reply-To: <1457576219-7971-10-git-send-email-stefan@agner.ch>
References: <1457576219-7971-1-git-send-email-stefan@agner.ch>
 <1457576219-7971-10-git-send-email-stefan@agner.ch>
Message-ID: <20160331113925.GB18833@tiger>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Mar 09, 2016 at 06:16:50PM -0800, Stefan Agner wrote:
> @@ -414,9 +460,12 @@ static void __init vf610_clocks_init(struct device_node *ccm_node)
>  	for (i = 0; i < ARRAY_SIZE(clks_init_on); i++)
>  		clk_prepare_enable(clk[clks_init_on[i]]);
>  
> +	register_syscore_ops(&vf610_clk_syscore_ops);
> +
>  	/* Add the clocks to provider list */
>  	clk_data.clks = clk;
>  	clk_data.clk_num = ARRAY_SIZE(clk);
>  	of_clk_add_provider(np, of_clk_src_onecell_get, &clk_data);
>  }
>  CLK_OF_DECLARE(vf610, "fsl,vf610-ccm", vf610_clocks_init);
> +

This is an unrelated change and brings in an 'new blank line at EOF'
warning.  I dropped it when applying the patch.

Shawn
