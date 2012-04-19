From: b-cousson@ti.com (Cousson, Benoit)
Date: Thu, 19 Apr 2012 10:22:34 +0200
Subject: [PATCH v2 3/8] ARM: OMAP2+: hwmod: reorganize and document the
 setup process
In-Reply-To: <alpine.DEB.2.00.1204190214250.29048@utopia.booyaka.com>
References: <20120228053524.16278.59430.stgit@dusk>
 <20120228053651.16278.22844.stgit@dusk>
 <alpine.DEB.2.00.1204190208470.29048@utopia.booyaka.com>
 <alpine.DEB.2.00.1204190214250.29048@utopia.booyaka.com>
Message-ID: <4F8FCB4A.3080805@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Paul,

On 4/19/2012 10:17 AM, Paul Walmsley wrote:

...

>   static int __init omap_hwmod_setup_all(void)
>   {
> -	int r;
> -
> -	if (!mpu_oh) {
> -		pr_err("omap_hwmod: %s: MPU initiator hwmod %s not yet registered\n",
> -		       __func__, MPU_INITIATOR_NAME);
> -		return -EINVAL;
> -	}
> -
> -	r = omap_hwmod_for_each(_populate_mpu_rt_base, NULL);
> -
> -	r = omap_hwmod_for_each(_init_clocks, NULL);
> -	WARN(IS_ERR_VALUE(r),
> -	     "omap_hwmod: %s: _init_clocks failed\n", __func__);
> +	_ensure_mpu_hwmod_is_setup(NULL);
>
> +	omap_hwmod_for_each(_init, NULL);
>   	omap_hwmod_for_each(_setup, NULL);

Does it make sense to iterate twice? Cannot we just iterate over a _init 
+ _setup single call?

Regards,
Benoit
