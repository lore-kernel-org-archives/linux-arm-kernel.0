From: tony@atomide.com (Tony Lindgren)
Date: Mon, 1 Feb 2016 15:44:05 -0800
Subject: PM regression with commit 5de85b9d57ab PM runtime re-init in
 v4.5-rc1
In-Reply-To: <20160201232833.GR19432@atomide.com>
References: <20160126235222.GF19432@atomide.com>
 <CAPDyKFqD6Y6HcgVds_oWBZ8L7Kdh2VX_WZCGApf-1a_6GHCQ5g@mail.gmail.com>
 <20160128165810.GA19432@atomide.com>
 <CAPDyKFoQHpqdCa4fzHycP0OT2KsNTxWm7JZSe8Mauh+rxqGtGg@mail.gmail.com>
 <20160201181135.GL19432@atomide.com>
 <20160201220657.GO19432@atomide.com>
 <CAJZ5v0gOtJE24Hu8R9jx7kBktmd__qFUNF_KnsCDLwgidskUvw@mail.gmail.com>
 <20160201222926.GQ19432@atomide.com>
 <CAJZ5v0jN3uK8q46N1Sp6xR2U=MpJZj=PX8uh9Kp+n75J4UZCZQ@mail.gmail.com>
 <20160201232833.GR19432@atomide.com>
Message-ID: <20160201234404.GS19432@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Tony Lindgren <tony@atomide.com> [160201 15:29]:
> --- a/drivers/base/power/runtime.c
> +++ b/drivers/base/power/runtime.c
> @@ -1419,17 +1419,28 @@ void pm_runtime_init(struct device *dev)
>   */
>  void pm_runtime_reinit(struct device *dev)
>  {
> -	if (!pm_runtime_enabled(dev)) {
> -		if (dev->power.runtime_status == RPM_ACTIVE)
> +	int (*callback)(struct device *);
> +	int err;

The callback and err are not needed here FYI, forgot to remove
them..

Tony
