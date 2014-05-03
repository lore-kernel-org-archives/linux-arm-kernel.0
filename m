From: iivanov@mm-sol.com (Ivan T. Ivanov)
Date: Sat, 03 May 2014 09:40:52 +0300
Subject: [PATCH] i2c: qup: Fix pm_runtime_get_sync usage
In-Reply-To: <1399082069-6666-1-git-send-email-agross@codeaurora.org>
References: <1399082069-6666-1-git-send-email-agross@codeaurora.org>
Message-ID: <1399099252.4310.1.camel@violet>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 2014-05-02 at 20:54 -0500, Andy Gross wrote:
> This patch corrects the error check on the call to pm_runtime_get_sync.
> 
> Signed-off-by: Andy Gross <agross@codeaurora.org>


Reviewed-by: Ivan T. Ivanov <iivanov@mm-sol.com>

> ---
>  drivers/i2c/busses/i2c-qup.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/i2c/busses/i2c-qup.c b/drivers/i2c/busses/i2c-qup.c
> index 1b4cf14..2a5efb5 100644
> --- a/drivers/i2c/busses/i2c-qup.c
> +++ b/drivers/i2c/busses/i2c-qup.c
> @@ -479,7 +479,7 @@ static int qup_i2c_xfer(struct i2c_adapter *adap,
>  	int ret, idx;
>  
>  	ret = pm_runtime_get_sync(qup->dev);
> -	if (ret)
> +	if (ret < 0)
>  		goto out;
>  
>  	writel(1, qup->base + QUP_SW_RESET);
