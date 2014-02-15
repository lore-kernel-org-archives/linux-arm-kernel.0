From: b.brezillon@overkiz.com (Boris BREZILLON)
Date: Sat, 15 Feb 2014 17:35:44 +0100
Subject: [PATCH] clk: at91: Fix memory leak
In-Reply-To: <1392480848-17866-1-git-send-email-shc_work@mail.ru>
References: <1392480848-17866-1-git-send-email-shc_work@mail.ru>
Message-ID: <52FF9760.8000800@overkiz.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Alexander,

Thanks for reporting and fixing this memory leak.

Unfortunately you're a bit late: this was already fixed, and I acked it 
;-) (see http://www.gossamer-threads.com/lists/linux/kernel/1865947).

Best Regards,

Boris

On 15/02/2014 17:14, Alexander Shiyan wrote:
> Signed-off-by: Alexander Shiyan <shc_work@mail.ru>
> ---
>   drivers/clk/at91/clk-master.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/clk/at91/clk-master.c b/drivers/clk/at91/clk-master.c
> index bd313f7..c1af80b 100644
> --- a/drivers/clk/at91/clk-master.c
> +++ b/drivers/clk/at91/clk-master.c
> @@ -242,7 +242,7 @@ of_at91_clk_master_setup(struct device_node *np, struct at91_pmc *pmc,
>   
>   	irq = irq_of_parse_and_map(np, 0);
>   	if (!irq)
> -		return;
> +		goto out_free_characteristics;
>   
>   	clk = at91_clk_register_master(pmc, irq, name, num_parents,
>   				       parent_names, layout,
