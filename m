From: hartleys@visionengravers.com (H Hartley Sweeten)
Date: Mon, 16 Apr 2012 11:40:01 -0500
Subject: [PATCH 3/3] ARM: orion5x: ts78xx debugging changes
In-Reply-To: <1334426454-3206-4-git-send-email-alex@digriz.org.uk>
References: <1334426454-3206-1-git-send-email-alex@digriz.org.uk>
 <1334426454-3206-4-git-send-email-alex@digriz.org.uk>
Message-ID: <ADE657CA350FB648AAC2C43247A983F00206987A3B49@AUSP01VMBX24.collaborationhost.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Saturday, April 14, 2012 11:01 AM, Alexander Clouter wrote:
> Moved to using a redefined pr_fmt to spare having to manually
> prefix every message line with 'ts78xx'.
>
> Signed-off-by: Alexander Clouter <alex@digriz.org.uk>
> ---
>  arch/arm/mach-orion5x/ts78xx-setup.c |   34 ++++++++++++++++++----------------
>  1 file changed, 18 insertions(+), 16 deletions(-)
>
> diff --git a/arch/arm/mach-orion5x/ts78xx-setup.c b/arch/arm/mach-orion5x/ts78xx-setup.c
> index 4ae822b..f6d1232 100644
> --- a/arch/arm/mach-orion5x/ts78xx-setup.c
> +++ b/arch/arm/mach-orion5x/ts78xx-setup.c
> @@ -26,6 +26,9 @@
>  #include "mpp.h"
>  #include "ts78xx-fpga.h"
>  
> +#undef pr_fmt
> +#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt

Put the #define pr_fmt line in front of  the #includes and you will not need
the #undef.

Regards,
Hartley
