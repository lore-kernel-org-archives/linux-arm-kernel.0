From: tony@atomide.com (Tony Lindgren)
Date: Thu, 17 Aug 2017 16:42:19 -0700
Subject: [PATCH 1/3] ARM: OMAP2+: Separate dra7 cpuidle from omap5
In-Reply-To: <20170817230122.30655-2-tony@atomide.com>
References: <20170817230122.30655-1-tony@atomide.com>
 <20170817230122.30655-2-tony@atomide.com>
Message-ID: <20170817234218.GC6008@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Tony Lindgren <tony@atomide.com> [170817 16:01]:
> As omap5 supports deeper idle states compared to dra7, let's
> separate dra7 from omap5 in preparation for adding more support
> for omap5.

Oops, sorry this first patch can be ignored. I forgot we already
separated out things for dra7 when we added omap5 cpu
retention mode support earlir. So there's nothing left
to move away for dra7.

> @@ -303,6 +342,9 @@ int __init omap4_idle_init(void)
>  	if (soc_is_omap54xx()) {
>  		state_ptr = &omap5_idle_data[0];
>  		idle_driver = &omap5_idle_driver;
> +	} else if (soc_is_dra7xx()) {
> +		state_ptr = &dra7_idle_data[0];
> +		idle_driver = &dra7_idle_driver;
>  	} else {
>  		state_ptr = &omap4_idle_data[0];
>  		idle_driver = &omap4_idle_driver;

And then this part now wrongly enables things for dra7 while
it can't be done.

Regards,

Tony
