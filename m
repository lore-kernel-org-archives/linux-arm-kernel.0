From: bjorn.andersson@linaro.org (Bjorn Andersson)
Date: Tue, 9 Aug 2016 10:32:25 -0700
Subject: [PATCH 2/9] remoteproc: core: Trivial: Improve error checking,
 spelling and debug prints
In-Reply-To: <20160804092153.23032-3-lee.jones@linaro.org>
References: <20160804092153.23032-1-lee.jones@linaro.org>
 <20160804092153.23032-3-lee.jones@linaro.org>
Message-ID: <20160809173225.GC26240@tuxbot>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu 04 Aug 02:21 PDT 2016, Lee Jones wrote:

> Trivial patch to clean up a couple of minor misgivings.
> 
> Signed-off-by: Lee Jones <lee.jones@linaro.org>

Acked-by: Bjorn Andersson <bjorn.andersson@linaro.org>

Although as I hope to stack this series ontop of the auto-boot there
will be some minor conflicts here.

Regards,
Bjorn

> ---
>  drivers/remoteproc/remoteproc_core.c | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/remoteproc/remoteproc_core.c b/drivers/remoteproc/remoteproc_core.c
> index 3566dc9..5654a81 100644
> --- a/drivers/remoteproc/remoteproc_core.c
> +++ b/drivers/remoteproc/remoteproc_core.c
> @@ -457,8 +457,8 @@ static int rproc_handle_trace(struct rproc *rproc, struct fw_rsc_trace *rsc,
>  
>  	rproc->num_traces++;
>  
> -	dev_dbg(dev, "%s added: va %p, da 0x%x, len 0x%x\n", name, ptr,
> -						rsc->da, rsc->len);
> +	dev_dbg(dev, "%s added: va %p, da 0x%x, len 0x%x\n",
> +		name, ptr, rsc->da, rsc->len);
>  
>  	return 0;
>  }
> @@ -581,8 +581,8 @@ static int rproc_handle_carveout(struct rproc *rproc,
>  		return -EINVAL;
>  	}
>  
> -	dev_dbg(dev, "carveout rsc: da %x, pa %x, len 0x%x, flags %x\n",
> -			rsc->da, rsc->pa, rsc->len, rsc->flags);
> +	dev_dbg(dev, "carveout rsc: name: %s, da %x, pa %x, len 0x%x, flags %x\n",
> +		rsc->name, rsc->da, rsc->pa, rsc->len, rsc->flags);
>  
>  	carveout = kzalloc(sizeof(*carveout), GFP_KERNEL);
>  	if (!carveout)
> @@ -700,7 +700,7 @@ static rproc_handle_resource_t rproc_loading_handlers[RSC_LAST] = {
>  	[RSC_CARVEOUT] = (rproc_handle_resource_t)rproc_handle_carveout,
>  	[RSC_DEVMEM] = (rproc_handle_resource_t)rproc_handle_devmem,
>  	[RSC_TRACE] = (rproc_handle_resource_t)rproc_handle_trace,
> -	[RSC_VDEV] = NULL, /* VDEVs were handled upon registrarion */
> +	[RSC_VDEV] = NULL, /* VDEVs were handled upon registration */
>  };
>  
>  static rproc_handle_resource_t rproc_vdev_handler[RSC_LAST] = {
> @@ -918,7 +918,7 @@ static void rproc_fw_config_virtio(const struct firmware *fw, void *context)
>  	 * Create a copy of the resource table. When a virtio device starts
>  	 * and calls vring_new_virtqueue() the address of the allocated vring
>  	 * will be stored in the cached_table. Before the device is started,
> -	 * cached_table will be copied into devic memory.
> +	 * cached_table will be copied into device memory.
>  	 */
>  	rproc->cached_table = kmemdup(table, tablesz, GFP_KERNEL);
>  	if (!rproc->cached_table)
> -- 
> 2.9.0
> 
