From: kuninori.morimoto.gx@renesas.com (Kuninori Morimoto)
Date: Wed, 26 Jun 2013 22:19:27 -0700 (PDT)
Subject: [PATCH v5 1/3] ARM: shmobile: r8a7778: add VIN support
In-Reply-To: <201306220328.47110.sergei.shtylyov@cogentembedded.com>
References: <201306220326.46176.sergei.shtylyov@cogentembedded.com>
 <201306220328.47110.sergei.shtylyov@cogentembedded.com>
Message-ID: <877ghg2krp.wl%kuninori.morimoto.gx@renesas.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Hi

I have 2 small comments

But, basically, I have no objection to this patch.

Acked-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>

> From: Vladimir Barinov <vladimir.barinov@cogentembedded.com>
> 
> Add VIN clocks and platform devices on R8A7778 SoC; add function to register
> the VIN platform devices.
> 
> Signed-off-by: Vladimir Barinov <vladimir.barinov@cogentembedded.com>
> [Sergei: added 'id' parameter check to r8a7779_add_vin_device(), used '*pdata'
> in *sizeof* operator there, renamed some variables, annotated 'vin[01]_info' and
> vin[01]_resources[] as '__initdata'.]
> Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
> 
> ---
> Changes since version 4:
> - resolved reject, refreshed the patch.
> 
> Changes since version 3:
> - changed the VIN platform device names to be R8A7778 specific; 
> - resolved reject in <mach/r8a7778.h>  due to USB patch rework.
> 
> Changes from version 2:
> - annotated 'vin[01]_info' and vin[01]_resources[] as '__initdata' since they're
>   kmemdup()'ed while registering the platform devices anyway;
> - refreshed the patch.
> 
>  arch/arm/mach-shmobile/clock-r8a7778.c        |    5 +++
>  arch/arm/mach-shmobile/include/mach/r8a7778.h |    3 ++
>  arch/arm/mach-shmobile/setup-r8a7778.c        |   33 ++++++++++++++++++++++++++
>  3 files changed, 41 insertions(+)

Simon (or ARM Maintainer ?) will be happy if clock was separated ?

> Index: renesas/arch/arm/mach-shmobile/clock-r8a7778.c
> ===================================================================
> --- renesas.orig/arch/arm/mach-shmobile/clock-r8a7778.c
> +++ renesas/arch/arm/mach-shmobile/clock-r8a7778.c
> @@ -106,6 +106,7 @@ enum {
>  	MSTP331,
>  	MSTP323, MSTP322, MSTP321,
>  	MSTP114,
> +	MSTP110, MSTP109,
>  	MSTP100,
>  	MSTP030,

MSTP114, MSTP110
MSTP109, MSTP100

is better


Best regards
---
Kuninori Morimoto
