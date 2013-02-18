From: kuninori.morimoto.gx@renesas.com (Kuninori Morimoto)
Date: Sun, 17 Feb 2013 17:33:39 -0800 (PST)
Subject: [PATCH 2/2 v3] [RFC] ARM: shmobile: r8a7779: Add TMU02 platform
 device
In-Reply-To: <1361147376-1228-3-git-send-email-horms+renesas@verge.net.au>
References: <1361147376-1228-1-git-send-email-horms+renesas@verge.net.au>
 <1361147376-1228-3-git-send-email-horms+renesas@verge.net.au>
Message-ID: <8738wuo174.wl%kuninori.morimoto.gx@renesas.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Hi Simon

> This is intended primarily to exercise the TMUO2 clock definition
> in clock-r8a7779.c. I would appreciate review before I queue it up or
> drop it.
> 
> With this patch and "ARM: shmobile: r8a7779: Correct TMU clock support
> again" in place I see the following tmu related portions of the
> bootlog on the Marzen board.
> 
>  sh_tmu.0: used for clock events
>  sh_tmu.0: used for periodic clock events
>  sh_tmu.1: used as clock source
> Switching to clocksource sh_tmu.1
> sh_tmu sh_tmu.0: kept as earlytimer
> sh_tmu sh_tmu.1: kept as earlytimer
> sh_tmu sh_tmu.2: used as clock source
> 
> Cc: Denis Oliver Kropp <dok@directfb.org>
> Cc: Magnus Damm <damm@opensource.se>
> Cc: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
> Cc: Paul Mundt <lethal@linux-sh.org>
> Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
> ---

(snip)

> +static struct resource tmu02_resources[] = {
> +	[0] = {
> +		.name	= "TMU02",
> +		.start	= 0xffd80020,
> +		.end	= 0xffd81003,
> +		.flags	= IORESOURCE_MEM,

It seems not wrong, but
.end = 0xffd8002b seems very enough ?

Best regards
---
Kuninori Morimoto
