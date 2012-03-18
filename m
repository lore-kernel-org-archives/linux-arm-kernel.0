From: shawn.guo@linaro.org (Shawn Guo)
Date: Sun, 18 Mar 2012 22:07:10 +0800
Subject: [PATCH v7 2/3] clk: introduce the common clock framework
In-Reply-To: <1331878280-2758-3-git-send-email-mturquette@linaro.org>
References: <1331878280-2758-1-git-send-email-mturquette@linaro.org>
 <1331878280-2758-3-git-send-email-mturquette@linaro.org>
Message-ID: <20120318140707.GC29638@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Another trivial comment.  But if there is an incremental patch, maybe
consider to include it.

On Thu, Mar 15, 2012 at 11:11:19PM -0700, Mike Turquette wrote:
...
> +#ifdef CONFIG_COMMON_CLK_DISABLE_UNUSED
> +static int clk_disable_unused(void)
> +{
> +	struct clk *clk;
> +	struct hlist_node *tmp;
> +
> +	mutex_lock(&prepare_lock);
> +
> +	hlist_for_each_entry(clk, tmp, &clk_root_list, child_node)
> +		clk_disable_unused_subtree(clk);
> +
> +	hlist_for_each_entry(clk, tmp, &clk_orphan_list, child_node)
> +		clk_disable_unused_subtree(clk);
> +
> +	mutex_unlock(&prepare_lock);
> +
> +	return 0;
> +}
> +late_initcall(clk_disable_unused);
> +#else
> +static inline int clk_disable_unused(struct clk *clk) { return 0; }

This #else block seems completely unnecessary to me.

> +#endif /* CONFIG_COMMON_CLK_DISABLE_UNUSED */

-- 
Regards,
Shawn
