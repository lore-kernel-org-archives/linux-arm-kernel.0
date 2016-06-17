From: tony@atomide.com (Tony Lindgren)
Date: Fri, 17 Jun 2016 02:55:55 -0700
Subject: [PATCH] ARM: OMAP2+: timer: add probe for clocksources
In-Reply-To: <1466079918-6810-1-git-send-email-t-kristo@ti.com>
References: <1466079918-6810-1-git-send-email-t-kristo@ti.com>
Message-ID: <20160617095554.GC22406@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Tero Kristo <t-kristo@ti.com> [160616 05:27]:
> A few platforms are currently missing clocksource_probe() completely
> in their time_init functionality. On OMAP3430 for example, this is
> causing cpuidle to be pretty much dead, as the counter32k is not
> going to be registered and instead a gptimer is used as a clocksource.
> This will tick in periodic mode, preventing any deeper idle states.
> 
> While here, also drop one unnecessary check for populated DT before
> existing clocksource_probe() call.

Good catch, applying into omap-for-v4.7/fixes thanks.

Tony
