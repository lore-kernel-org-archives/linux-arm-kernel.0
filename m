From: tarun.kanti@ti.com (DebBarma, Tarun Kanti)
Date: Mon, 22 Nov 2010 16:37:28 +0530
Subject: [PATCH 1/3] OMAP2+: wd_timer: separate watchdog disable code
	from the	rest of mach-omap2/devices.c
In-Reply-To: <20101116102512.27991.28535.stgit@twilight.localdomain>
References: <20101116102205.27991.37909.stgit@twilight.localdomain>
	<20101116102512.27991.28535.stgit@twilight.localdomain>
Message-ID: <5A47E75E594F054BAF48C5E4FC4B92AB0372E400F0@dbde02.ent.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Paul,

<<snip>>
...
> +
> +int omap2_wd_timer_disable(struct omap_hwmod *oh)
> +{
> +	void __iomem *base;
> +	int ret;
> +
> +	if (!oh) {
> +		pr_err("%s: Could not look up wdtimer_hwmod\n", __func__);
> +		return -EINVAL;
> +	}
> +
Just a minor observation. I was wondering if we need this check because
omap_hwmod_for_each_by_class(...) would call this only for valid oh.


        list_for_each_entry(temp_oh, &omap_hwmod_list, node) {
                if (!strcmp(temp_oh->class->name, classname)) {
                        pr_debug("omap_hwmod: %s: %s: calling callback fn\n",
                                 __func__, temp_oh->name);
                        ret = (*fn)(temp_oh, user);

--
Tarun
