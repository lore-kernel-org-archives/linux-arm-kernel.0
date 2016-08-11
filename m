From: bjorn.andersson@linaro.org (Bjorn Andersson)
Date: Thu, 11 Aug 2016 11:40:56 -0700
Subject: [PATCH 2/2] remoteproc: core: Rework obtaining a rproc from a DT
 phandle
In-Reply-To: <20160719154905.23344-2-lee.jones@linaro.org>
References: <20160719154905.23344-1-lee.jones@linaro.org>
 <20160719154905.23344-2-lee.jones@linaro.org>
Message-ID: <20160811184056.GZ26240@tuxbot>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue 19 Jul 08:49 PDT 2016, Lee Jones wrote:

> diff --git a/drivers/remoteproc/remoteproc_core.c b/drivers/remoteproc/remoteproc_core.c
[..]
> -struct rproc *rproc_get_by_phandle(phandle phandle)
> +struct rproc *of_get_rproc_by_phandle(struct device_node *np)
>  {
> -	return NULL;
> +	return of_get_rproc_by_index(np, 0);

I agree with Suman, that this should be moved to the static inline
function in remoteproc.h

Giving it some more thought, based on the naming discussion, I think
this should be called "of_get_rproc()". Better keep the "default
accessor" short and simple and the _by_phandle() is confusing.

>  }
> +EXPORT_SYMBOL(of_get_rproc_by_phandle);
>  #endif
> -EXPORT_SYMBOL(rproc_get_by_phandle);
[..]
> diff --git a/include/linux/remoteproc.h b/include/linux/remoteproc.h
[..]
>  static inline
> -struct rproc *rproc_get_by_phandle(phandle phandle)
> +struct rproc *of_get_rproc_by_phandle(struct device_node *np)
>  {
>  	return NULL;
>  }

Regards,
Bjorn
