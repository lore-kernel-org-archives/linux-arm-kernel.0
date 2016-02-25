From: sboyd@codeaurora.org (Stephen Boyd)
Date: Thu, 25 Feb 2016 15:42:44 -0800
Subject: [PATCH v9 1/6] clk: hisilicon: export some hisilicon APIs to
 modules
In-Reply-To: <1456127280-23275-2-git-send-email-xuejiancheng@huawei.com>
References: <1456127280-23275-1-git-send-email-xuejiancheng@huawei.com>
 <1456127280-23275-2-git-send-email-xuejiancheng@huawei.com>
Message-ID: <20160225234244.GL28849@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 02/22, Jiancheng Xue wrote:
> Change some arguments to constant type.
> Export some hisilicon APIs to modules.
> 
> Signed-off-by: Jiancheng Xue <xuejiancheng@huawei.com>
> ---
>  drivers/clk/hisilicon/clk.c | 23 +++++++++++++++--------
>  drivers/clk/hisilicon/clk.h | 14 +++++++-------
>  2 files changed, 22 insertions(+), 15 deletions(-)
> 
> diff --git a/drivers/clk/hisilicon/clk.c b/drivers/clk/hisilicon/clk.c
> index 9f8e766..06ec3fe 100644
> --- a/drivers/clk/hisilicon/clk.c
> +++ b/drivers/clk/hisilicon/clk.c
> @@ -37,7 +37,7 @@
>  
>  static DEFINE_SPINLOCK(hisi_clk_lock);
>  
> -struct hisi_clock_data __init *hisi_clk_init(struct device_node *np,
> +struct hisi_clock_data *hisi_clk_init(struct device_node *np,
>  					     int nr_clks)
>  {
>  	struct hisi_clock_data *clk_data;
> @@ -71,8 +71,9 @@ err_data:
>  err:
>  	return NULL;
>  }
> +EXPORT_SYMBOL(hisi_clk_init);

Why not EXPORT_SYMBOL_GPL?

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
