From: tomas.winkler@intel.com (Winkler, Tomas)
Date: Thu, 20 Aug 2015 08:35:22 +0000
Subject: [PATCH V3] Watchdog: Fix parent of watchdog_devices
In-Reply-To: <db7db9102158b87a4a7169e84e2272b3ba03f9f7.1439954581.git.panand@redhat.com>
References: <db7db9102158b87a4a7169e84e2272b3ba03f9f7.1439954581.git.panand@redhat.com>
Message-ID: <5B8DA87D05A7694D9FA63FD143655C1B3D42A60A@hasmsx108.ger.corp.intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> diff --git a/drivers/misc/mei/wd.c b/drivers/misc/mei/wd.c
> index 2bc0f5089f82..b346638833b0 100644
> --- a/drivers/misc/mei/wd.c
> +++ b/drivers/misc/mei/wd.c
> @@ -364,6 +364,7 @@ int mei_watchdog_register(struct mei_device *dev)
> 
>  	int ret;
> 
> +	amt_wd_dev.parent = dev->dev;
>  	/* unlock to perserve correct locking order */
>  	mutex_unlock(&dev->device_lock);
>  	ret = watchdog_register_device(&amt_wd_dev);

Acked-by: Tomas Winkler <tomas.winkler@intel.com>

Should this be got to stable as well?
