From: lee.jones@linaro.org (Lee Jones)
Date: Thu, 17 Mar 2016 13:29:43 +0000
Subject: [PATCH] ARM: Rockchip: Fix use of plain integer as NULL pointer
In-Reply-To: <1458213099-13786-1-git-send-email-peter.griffin@linaro.org>
References: <1458213099-13786-1-git-send-email-peter.griffin@linaro.org>
Message-ID: <20160317132943.GC13692@x1>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Nit: Subject line doesn't match the preferred format for the sub-arch.

On Thu, 17 Mar 2016, Peter Griffin wrote:

> This fixes the following sparse build warning
> mach-rockchip/platsmp.c:68:43: Using plain integer as NULL pointer

Nit: I would insert a '\n' between your wording and the quoted
warning.  For added clarity, I usually stick a tab before the quote.

> Signed-off-by: Peter Griffin <peter.griffin@linaro.org>
> ---
>  arch/arm/mach-rockchip/platsmp.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Patch looks good though:

Acked-by: Lee Jones <lee.jones@linaro.org>

> diff --git a/arch/arm/mach-rockchip/platsmp.c b/arch/arm/mach-rockchip/platsmp.c
> index d42a07e..4d827a0 100644
> --- a/arch/arm/mach-rockchip/platsmp.c
> +++ b/arch/arm/mach-rockchip/platsmp.c
> @@ -65,7 +65,7 @@ static struct reset_control *rockchip_get_core_reset(int cpu)
>  	if (dev)
>  		np = dev->of_node;
>  	else
> -		np = of_get_cpu_node(cpu, 0);
> +		np = of_get_cpu_node(cpu, NULL);
>  
>  	return of_reset_control_get(np, NULL);
>  }

-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
