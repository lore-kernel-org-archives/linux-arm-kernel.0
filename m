From: tony@atomide.com (Tony Lindgren)
Date: Mon, 9 Jan 2017 11:33:28 -0800
Subject: [PATCH v3] soc: ti: wkup_m3_ipc: Drop wait from
 wkup_m3_rproc_boot_thread
In-Reply-To: <1483653615-24378-1-git-send-email-spjoshi@codeaurora.org>
References: <1483653615-24378-1-git-send-email-spjoshi@codeaurora.org>
Message-ID: <20170109193328.GO2630@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Sarangdhar Joshi <spjoshi@codeaurora.org> [170105 14:01]:
> The function wkup_m3_rproc_boot_thread waits for asynchronous
> firmware loading to parse the resource table before calling
> rproc_boot(). However, as the resource table parsing has been
> moved to rproc_boot(), there's no need to wait for the
> asynchronous firmware loading completion.  So, drop this.
> 
> CC: Dave Gerlach <d-gerlach@ti.com>
> CC: Bjorn Andersson <bjorn.andersson@linaro.org>
> Tested-by: Suman Anna <s-anna@ti.com>
> Signed-off-by: Sarangdhar Joshi <spjoshi@codeaurora.org>
> ---
> 
> This patch seems to be doing an independent clean up now. Hence
> removing it from the series.
> 
> Changes from v2:
> 
> * Updated the subject line as per Suman's comment

FYI, I already have v2 applied with subject:

"soc: ti: wkup_m3_ipc: Drop wait from wkup_m3_rproc_boot_thread"

Tony


>  drivers/soc/ti/wkup_m3_ipc.c | 2 --
>  1 file changed, 2 deletions(-)
> 
> diff --git a/drivers/soc/ti/wkup_m3_ipc.c b/drivers/soc/ti/wkup_m3_ipc.c
> index 8823cc8..8bfa44b 100644
> --- a/drivers/soc/ti/wkup_m3_ipc.c
> +++ b/drivers/soc/ti/wkup_m3_ipc.c
> @@ -370,8 +370,6 @@ static void wkup_m3_rproc_boot_thread(struct wkup_m3_ipc *m3_ipc)
>  	struct device *dev = m3_ipc->dev;
>  	int ret;
>  
> -	wait_for_completion(&m3_ipc->rproc->firmware_loading_complete);
> -
>  	init_completion(&m3_ipc->sync_complete);
>  
>  	ret = rproc_boot(m3_ipc->rproc);
> -- 
> The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
> a Linux Foundation Collaborative Project
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
> 
