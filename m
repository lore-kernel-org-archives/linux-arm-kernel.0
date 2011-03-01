From: tony@atomide.com (Tony Lindgren)
Date: Mon, 28 Feb 2011 17:58:18 -0800
Subject: [PATCH] OMAP2+: sdrc: fix compile break on OMAP4-only config
	on current omap-for-linus
In-Reply-To: <4D6B8BB2.2010503@ru.mvista.com>
References: <alpine.DEB.2.00.1102251839360.6198@utopia.booyaka.com>
	<4D6916D0.1080501@ru.mvista.com>
	<alpine.DEB.2.00.1102271701450.4608@utopia.booyaka.com>
	<4D6B8BB2.2010503@ru.mvista.com>
Message-ID: <20110301015818.GM20560@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Sergei Shtylyov <sshtylyov@mvista.com> [110228 03:48]:
> 
> On 28-02-2011 3:03, Paul Walmsley wrote:
> 
> >Tony, do you want to take this one?

Applying..
 
> >+#if defined(CONFIG_ARCH_OMAP2) || defined(CONFIG_ARCH_OMAP3)
> >  void __init omap2_sdrc_init(struct omap_sdrc_params *sdrc_cs0,
> >  			    struct omap_sdrc_params *sdrc_cs1);
> >+#else
> >+static inline void __init omap2_sdrc_init(struct omap_sdrc_params *sdrc_cs0,
> 
>    No need to annotate it as __init.

..modified this.

Tony
