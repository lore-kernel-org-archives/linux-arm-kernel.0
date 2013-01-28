From: robherring2@gmail.com (Rob Herring)
Date: Mon, 28 Jan 2013 08:17:05 -0600
Subject: [PATCH] arm: zynq: Add missing irqchip.h to common.c
In-Reply-To: <1359376250-18841-1-git-send-email-michal.simek@xilinx.com>
References: <1359376250-18841-1-git-send-email-michal.simek@xilinx.com>
Message-ID: <51068861.8060309@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 01/28/2013 06:30 AM, Michal Simek wrote:
> The patch: "ARM: use common irqchip_init for GIC init"
> (sha1: 0529e315bbda5d502c93df2cfafba9bb337fbdf4)
> should also add linux/irqchip.h header.
> 
> Error message:
> arch/arm/mach-zynq/common.c:99:14: error: 'irqchip_init'
>   undeclared here (not in a function)
> 
> Signed-off-by: Michal Simek <michal.simek@xilinx.com>

FYI, there's already a patch posted for this:

http://www.spinics.net/lists/arm-kernel/msg219556.html

Rob
> ---
>  arch/arm/mach-zynq/common.c |    1 +
>  1 files changed, 1 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/arm/mach-zynq/common.c b/arch/arm/mach-zynq/common.c
> index 6472a69..cf3ec54 100644
> --- a/arch/arm/mach-zynq/common.c
> +++ b/arch/arm/mach-zynq/common.c
> @@ -24,6 +24,7 @@
>  #include <linux/of_irq.h>
>  #include <linux/of_platform.h>
>  #include <linux/of.h>
> +#include <linux/irqchip.h>
>  
>  #include <asm/mach/arch.h>
>  #include <asm/mach/map.h>
> 
