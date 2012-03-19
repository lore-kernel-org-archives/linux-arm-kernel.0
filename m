From: robherring2@gmail.com (Rob Herring)
Date: Mon, 19 Mar 2012 13:10:25 -0500
Subject: [PATCH] ARM: tegra: Include assembler.h in sleep.S to fix build
 break
In-Reply-To: <1332176863-12537-1-git-send-email-swarren@wwwdotorg.org>
References: <1332176863-12537-1-git-send-email-swarren@wwwdotorg.org>
Message-ID: <4F677691.8020307@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 03/19/2012 12:07 PM, Stephen Warren wrote:
> Commit 6f6f6a7 "ARM: create a common IOMEM definition" moved macro
> IOMEM(), and requires users to include <asm/assembler.h>. Fix Tegra's
> sleep.S to do so.
> 
> Signed-off-by: Stephen Warren <swarren@wwwdotorg.org>

Acked-by: Rob Herring <rob.herring@calxeda.com>

> ---
> v2: Fix linux/ vs. asm/ include ordering. Remove include of io.h too.
> 
>  arch/arm/mach-tegra/sleep.S |    4 +++-
>  1 files changed, 3 insertions(+), 1 deletions(-)
> 
> diff --git a/arch/arm/mach-tegra/sleep.S b/arch/arm/mach-tegra/sleep.S
> index 8f9fde1..5b20197 100644
> --- a/arch/arm/mach-tegra/sleep.S
> +++ b/arch/arm/mach-tegra/sleep.S
> @@ -23,7 +23,9 @@
>   */
>  
>  #include <linux/linkage.h>
> -#include <mach/io.h>
> +
> +#include <asm/assembler.h>
> +
>  #include <mach/iomap.h>
>  
>  #include "flowctrl.h"
