From: davidb@codeaurora.org (David Brown)
Date: Fri, 21 Sep 2012 11:44:18 -0700
Subject: [PATCH] msm: clock: fix return value check in msm_clock_init()
In-Reply-To: <CAPgLHd9Fx-y8oqy0Ux85AUA9fbYvJYjS=FLs7z+ivdqOVtLqhQ@mail.gmail.com>
References: <CAPgLHd9Fx-y8oqy0Ux85AUA9fbYvJYjS=FLs7z+ivdqOVtLqhQ@mail.gmail.com>
Message-ID: <20120921184418.GB25508@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Sep 21, 2012 at 02:23:13PM +0800, Wei Yongjun wrote:
> From: Wei Yongjun <yongjun_wei@trendmicro.com.cn>
> 
> In case of error, the function clk_get() returns ERR_PTR() not
> NULL pointer. The NULL test in return value check should be
> replaced with IS_ERR().
> 
> dpatch engine is used to auto generated this patch.
> (https://github.com/weiyj/dpatch)
> 
> Signed-off-by: Wei Yongjun <yongjun_wei@trendmicro.com.cn>
> ---
>  arch/arm/mach-msm/clock.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm/mach-msm/clock.c b/arch/arm/mach-msm/clock.c
> index d9145df..fd52891 100644
> --- a/arch/arm/mach-msm/clock.c
> +++ b/arch/arm/mach-msm/clock.c
> @@ -148,7 +148,7 @@ void __init msm_clock_init(struct clk_lookup *clock_tbl, unsigned num_clocks)
>  	mutex_unlock(&clocks_mutex);
>  
>  	ebi1_clk = clk_get(NULL, "ebi1_clk");
> -	BUG_ON(ebi1_clk == NULL);
> +	BUG_ON(IS_ERR(ebi1_clk));

It looks like this code is being removed entirely by a patch that just
was sent out by Stephen Boyd.  Stephen, can you make sure that this
gets included if this comes back, but for now I think this is already
taken care of.

Thanks,
David

-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
hosted by The Linux Foundation
