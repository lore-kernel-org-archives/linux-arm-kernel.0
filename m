From: s.nawrocki@samsung.com (Sylwester Nawrocki)
Date: Tue, 20 May 2014 13:49:39 +0200
Subject: [PATCH/RFC V6 2/2] clk: Add handling of clk parent and rate
 assigned from DT
In-Reply-To: <1400520171-6698-3-git-send-email-s.nawrocki@samsung.com>
References: <1400520171-6698-1-git-send-email-s.nawrocki@samsung.com>
 <1400520171-6698-3-git-send-email-s.nawrocki@samsung.com>
Message-ID: <537B4153.8030203@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 19/05/14 19:22, Sylwester Nawrocki wrote:
> @@ -2620,7 +2639,10 @@ void __init of_clk_init(const struct of_device_id *matches)
>  		list_for_each_entry_safe(clk_provider, next,
>  					&clk_provider_list, node) {
>  			if (force || parent_ready(clk_provider->np)) {
> +
>  				clk_provider->clk_init_cb(clk_provider->np);
> +				of_clk_set_defaults(np, true);

There is an error in this patch, this line should read:

+				of_clk_set_defaults(clk_provider->np, true);

>  				list_del(&clk_provider->node);
>  				kfree(clk_provider);
>  				is_init_done = true;
