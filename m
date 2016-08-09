From: bjorn.andersson@linaro.org (Bjorn Andersson)
Date: Tue, 9 Aug 2016 10:36:53 -0700
Subject: [PATCH 3/9] remoteproc: core: Remove pointless OOM print
In-Reply-To: <20160804092153.23032-4-lee.jones@linaro.org>
References: <20160804092153.23032-1-lee.jones@linaro.org>
 <20160804092153.23032-4-lee.jones@linaro.org>
Message-ID: <20160809173653.GD26240@tuxbot>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu 04 Aug 02:21 PDT 2016, Lee Jones wrote:

> These types of error prints are superfluous.  The system will
> pick up on OOM issues and let the user know.
> 
> Signed-off-by: Lee Jones <lee.jones@linaro.org>

Acked-by: Bjorn Andersson <bjorn.andersson@linaro.org>

Although, I think we should drop the "mapping" object. We have all the
information in the carveout object to reverse the mapping at cleanup.

Regards,
Bjorn

> ---
>  drivers/remoteproc/remoteproc_core.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/drivers/remoteproc/remoteproc_core.c b/drivers/remoteproc/remoteproc_core.c
> index 5654a81..4914482 100644
> --- a/drivers/remoteproc/remoteproc_core.c
> +++ b/drivers/remoteproc/remoteproc_core.c
> @@ -619,7 +619,6 @@ static int rproc_handle_carveout(struct rproc *rproc,
>  	if (rproc->domain) {
>  		mapping = kzalloc(sizeof(*mapping), GFP_KERNEL);
>  		if (!mapping) {
> -			dev_err(dev, "kzalloc mapping failed\n");
>  			ret = -ENOMEM;
>  			goto dma_free;
>  		}
> -- 
> 2.9.0
> 
