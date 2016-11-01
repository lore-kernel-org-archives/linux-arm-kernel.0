From: bjorn.andersson@linaro.org (Bjorn Andersson)
Date: Mon, 31 Oct 2016 17:37:34 -0700
Subject: [PATCH -next] remoteproc: st: Fix error return code in
 st_rproc_probe()
In-Reply-To: <1476721415-20224-1-git-send-email-weiyj.lk@gmail.com>
References: <1476721415-20224-1-git-send-email-weiyj.lk@gmail.com>
Message-ID: <20161101003734.GA14397@tuxbot>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon 17 Oct 09:23 PDT 2016, Wei Yongjun wrote:

> From: Wei Yongjun <weiyongjun1@huawei.com>
> 
> Fix to return a negative error code from the st_rproc_state() error
> handling case instead of 0, as done elsewhere in this function.
> 
> Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>

Applied, with added "Fixes". Thanks!

Regards,
Bjorn

> ---
>  drivers/remoteproc/st_remoteproc.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/remoteproc/st_remoteproc.c b/drivers/remoteproc/st_remoteproc.c
> index ae8963f..da4e152 100644
> --- a/drivers/remoteproc/st_remoteproc.c
> +++ b/drivers/remoteproc/st_remoteproc.c
> @@ -245,8 +245,10 @@ static int st_rproc_probe(struct platform_device *pdev)
>  		goto free_rproc;
>  
>  	enabled = st_rproc_state(pdev);
> -	if (enabled < 0)
> +	if (enabled < 0) {
> +		ret = enabled;
>  		goto free_rproc;
> +	}
>  
>  	if (enabled) {
>  		atomic_inc(&rproc->power);
> 
