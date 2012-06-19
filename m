From: sshtylyov@mvista.com (Sergei Shtylyov)
Date: Tue, 19 Jun 2012 16:46:32 +0400
Subject: [PATCHv3 6/7] ARM: OMAP2+: CM: increase the module disable timeout
In-Reply-To: <20120618061611.30632.51094.stgit@dusk>
References: <20120618061037.30632.28539.stgit@dusk>
 <20120618061611.30632.51094.stgit@dusk>
Message-ID: <4FE074A8.5010109@mvista.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello.

On 18-06-2012 10:16, Paul Walmsley wrote:

> Increase the timeout for disabling an IP block to five milliseconds.
> This is to handle the usb_host_fs idle latency, which takes almost
> four milliseconds after a host controller reset.

> This is the second of two patches needed to resolve the following
> boot warning:

> omap_hwmod: usb_host_fs: _wait_target_disable failed

> Signed-off-by: Paul Walmsley<paul@pwsan.com>
> Cc: Tero Kristo<t-kristo@ti.com>
[...]

> diff --git a/arch/arm/mach-omap2/omap_hwmod_44xx_data.c b/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
> index 6b0aedc..a428305 100644
> --- a/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
> +++ b/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
> @@ -30,6 +30,7 @@
>   #include<plat/mmc.h>
>   #include<plat/dmtimer.h>
>   #include<plat/common.h>
> +#include<plat/usb.h>

    How this hunk is related?

WBR, Sergei
