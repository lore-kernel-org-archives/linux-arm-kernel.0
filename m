From: nicolas.ferre@microchip.com (Nicolas Ferre)
Date: Thu, 24 Aug 2017 14:09:08 +0200
Subject: [PATCH] ARM: at91: Replace uses of virt_to_phys with __pa_symbol
In-Reply-To: <20170824114454.22812-1-alexandre.belloni@free-electrons.com>
References: <20170824114454.22812-1-alexandre.belloni@free-electrons.com>
Message-ID: <062c5218-3370-905a-d113-4d9526d13cd1@microchip.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 24/08/2017 at 13:44, Alexandre Belloni wrote:
> The PM code wrongly uses virt_to_phys() instead of __pa_symbol() and was
> not updated by commit 64fc2a947a98 ("ARM: 8641/1: treewide: Replace uses of
> virt_to_phys with __pa_symbol") because it was not yet in tree.
> 
> Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>

Acked-by: Nicolas Ferre <nicolas.ferre@microchip.com>

> ---
>  arch/arm/mach-at91/pm.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm/mach-at91/pm.c b/arch/arm/mach-at91/pm.c
> index b1a59d638321..ccaaaa138d13 100644
> --- a/arch/arm/mach-at91/pm.c
> +++ b/arch/arm/mach-at91/pm.c
> @@ -535,8 +535,8 @@ static void __init at91_pm_backup_init(void)
>  	}
>  
>  	pm_bu->suspended = 0;
> -	pm_bu->canary = virt_to_phys(&canary);
> -	pm_bu->resume = virt_to_phys(cpu_resume);
> +	pm_bu->canary = __pa_symbol(&canary);
> +	pm_bu->resume = __pa_symbol(cpu_resume);
>  
>  	return;
>  
> 


-- 
Nicolas Ferre
