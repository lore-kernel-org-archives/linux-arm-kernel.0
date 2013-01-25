From: nsekhar@ti.com (Sekhar Nori)
Date: Fri, 25 Jan 2013 11:55:43 +0530
Subject: [PATCH 2/2] ARM: davinci: da850: add OF_DEV_AUXDATA entry for
 eth0.
In-Reply-To: <1358749759-20517-3-git-send-email-prabhakar.lad@ti.com>
References: <1358749759-20517-1-git-send-email-prabhakar.lad@ti.com>
 <1358749759-20517-3-git-send-email-prabhakar.lad@ti.com>
Message-ID: <51022567.7050700@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 1/21/2013 11:59 AM, Prabhakar Lad wrote:
> From: Lad, Prabhakar <prabhakar.lad@ti.com>
> 
> Add OF_DEV_AUXDATA for eth0  driver in da850 board dt
> file to use emac clock.
> 
> Signed-off-by: Lad, Prabhakar <prabhakar.lad@ti.com>
> Cc: linux-arm-kernel at lists.infradead.org
> Cc: linux-kernel at vger.kernel.org
> Cc: davinci-linux-open-source at linux.davincidsp.com
> Cc: netdev at vger.kernel.org
> Cc: devicetree-discuss at lists.ozlabs.org
> Cc: Sekhar Nori <nsekhar@ti.com>
> Cc: Heiko Schocher <hs@denx.de>
> ---
>  arch/arm/mach-davinci/da8xx-dt.c |    9 ++++++++-
>  1 files changed, 8 insertions(+), 1 deletions(-)
> 
> diff --git a/arch/arm/mach-davinci/da8xx-dt.c b/arch/arm/mach-davinci/da8xx-dt.c
> index 37c27af..d548a38 100644
> --- a/arch/arm/mach-davinci/da8xx-dt.c
> +++ b/arch/arm/mach-davinci/da8xx-dt.c
> @@ -37,11 +37,18 @@ static void __init da8xx_init_irq(void)
>  	of_irq_init(da8xx_irq_match);
>  }
>  
> +struct of_dev_auxdata da850_evm_auxdata_lookup[] __initdata = {

This is specific to da850 and not da850_evm so it should be named so.
You can call it da8xx_auxdata keeping with the file naming.

Thanks,
Sekhar
