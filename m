From: bjorn.andersson@linaro.org (Bjorn Andersson)
Date: Fri, 13 Jan 2017 10:15:51 -0800
Subject: [PATCH] firmware: qcom: scm: Mask APQ8064 core clk dependency
In-Reply-To: <1484175483-25333-1-git-send-email-andy.gross@linaro.org>
References: <1484175483-25333-1-git-send-email-andy.gross@linaro.org>
Message-ID: <20170113181551.GL10531@minitux>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed 11 Jan 14:58 PST 2017, Andy Gross wrote:

> This patch masks the core clk requirement for the APQ8064.  Until the
> other peripherals correctly describe their clock dependencies or the
> bus driver is put in place to handle the RPM dependencies, this bit
> will remain masked.
> 
> Signed-off-by: Andy Gross <andy.gross@linaro.org>

Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>

Regards,
Bjorn

> ---
>  drivers/firmware/qcom_scm.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/firmware/qcom_scm.c b/drivers/firmware/qcom_scm.c
> index 893f953ea..65d0d9d 100644
> --- a/drivers/firmware/qcom_scm.c
> +++ b/drivers/firmware/qcom_scm.c
> @@ -387,7 +387,7 @@ static int qcom_scm_probe(struct platform_device *pdev)
>  
>  static const struct of_device_id qcom_scm_dt_match[] = {
>  	{ .compatible = "qcom,scm-apq8064",
> -	  .data = (void *) SCM_HAS_CORE_CLK,
> +	  /* FIXME: This should have .data = (void *) SCM_HAS_CORE_CLK */
>  	},
>  	{ .compatible = "qcom,scm-msm8660",
>  	  .data = (void *) SCM_HAS_CORE_CLK,
> -- 
> 1.9.1
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-arm-msm" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
