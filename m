From: kuninori.morimoto.gx@renesas.com (Kuninori Morimoto)
Date: Wed, 03 Apr 2013 17:27:02 -0700 (PDT)
Subject: [PATCH/RFC 2/3] ARM: shmobile: initialise clock early on
 kzm9g-reference
In-Reply-To: <1365005636-17526-3-git-send-email-g.liakhovetski@gmx.de>
References: <1365005636-17526-1-git-send-email-g.liakhovetski@gmx.de>
 <1365005636-17526-3-git-send-email-g.liakhovetski@gmx.de>
Message-ID: <87zjxfdtt8.wl%kuninori.morimoto.gx@renesas.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Hi Guennadi

> To prepare to enable TWD on kzm9g-reference, clock initialisation has to be
> done early. Move it from .init_machine to .init_time stage.
> 
> Signed-off-by: Guennadi Liakhovetski <g.liakhovetski+renesas@gmail.com>
> ---
(snip)
> +static void __init timer_init(void)
> +{
> +	sh73a0_clock_init();
> +	shmobile_timer_init();
> +}

I'm not sure detail,
but, shmobile_timer_init() will be removed.

Can you check these patch/email on SH-ML or ARM ML ?

Subject: [PATCH v2 02/13] ARM: convert arm/arm64 arch timer to use CLKSRC_OF init
Date:	Mon,  1 Apr 2013 17:21:12 -0500

Subject: [PATCH v2 02/13] ARM: convert arm/arm64 arch timer to use CLKSRC_OF init
Date:	Mon,  1 Apr 2013 17:21:12 -0500



Best regards
---
Kuninori Morimoto
