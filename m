From: f.fainelli@gmail.com (Florian Fainelli)
Date: Tue, 18 Jul 2017 09:49:17 -0700
Subject: [PATCH resend] Documentation: arm: Replace use of virt_to_phys
 with __pa_symbol
In-Reply-To: <1500298768-13262-1-git-send-email-geert+renesas@glider.be>
References: <1500298768-13262-1-git-send-email-geert+renesas@glider.be>
Message-ID: <d0d5568e-e70a-5576-fd0f-f01acfe8cfa2@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/17/2017 06:39 AM, Geert Uytterhoeven wrote:
> All low-level PM/SMP code using virt_to_phys() should actually use
> __pa_symbol() against kernel symbols.  Update the documentation to move
> away from virt_to_phys().
> 
> Cfr. commit 6996cbb2372189f7 ("ARM: 8641/1: treewide: Replace uses of
> virt_to_phys with __pa_symbol")
> 
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>

Acked-by: Florian Fainelli <f.fainelli@gmail.com>

Sorry for not noticing earlier.

> ---
>  Documentation/arm/firmware.txt | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/Documentation/arm/firmware.txt b/Documentation/arm/firmware.txt
> index da6713adac8acffc..7f175dbb427e631a 100644
> --- a/Documentation/arm/firmware.txt
> +++ b/Documentation/arm/firmware.txt
> @@ -60,7 +60,7 @@ Example of using a firmware operation:
>  
>  	/* some platform code, e.g. SMP initialization */
>  
> -	__raw_writel(virt_to_phys(exynos4_secondary_startup),
> +	__raw_writel(__pa_symbol(exynos4_secondary_startup),
>  		CPU1_BOOT_REG);
>  
>  	/* Call Exynos specific smc call */
> 


-- 
Florian
