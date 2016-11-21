From: mathieu.poirier@linaro.org (Mathieu Poirier)
Date: Mon, 21 Nov 2016 10:17:35 -0700
Subject: [PATCH] coresight: perf: Add a missing call to etm_free_aux
In-Reply-To: <20161119174124.20136-1-lambert.quentin@gmail.com>
References: <20161119174124.20136-1-lambert.quentin@gmail.com>
Message-ID: <20161121171735.GA12578@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Nov 19, 2016 at 06:41:24PM +0100, Quentin Lambert wrote:
> Most error branches following the call to alloc_event_data contain a call to
> etm_free_aux. This patch add a call to etm_free_aux to an error branch
> that does not call it.
> 
> This issue was found with Hector.
> 
> Signed-off-by: Quentin Lambert <lambert.quentin@gmail.com>
> ---
>  drivers/hwtracing/coresight/coresight-etm-perf.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> --- a/drivers/hwtracing/coresight/coresight-etm-perf.c
> +++ b/drivers/hwtracing/coresight/coresight-etm-perf.c
> @@ -215,7 +215,7 @@ static void *etm_setup_aux(int event_cpu
>  	 */
>  	sink = coresight_get_enabled_sink(true);
>  	if (!sink)
> -		return NULL;
> +		goto err;
>  
>  	INIT_WORK(&event_data->work, free_event_data);
>  

Applied, after wrapping the commit log to 75 characters or less.
Please run checkpatch.pl on your next submission and compiling
your work before sending a patches is highly suggested.

Thanks,
Mathieu
