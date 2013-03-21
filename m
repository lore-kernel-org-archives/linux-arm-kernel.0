From: andrew@lunn.ch (Andrew Lunn)
Date: Thu, 21 Mar 2013 20:18:05 +0100
Subject: [PATCH 2/5] arm: mvebu: Select DMA_BOUNCE when LPAE is selected
 in Kconfig
In-Reply-To: <1363883179-1361-3-git-send-email-gregory.clement@free-electrons.com>
References: <1363883179-1361-1-git-send-email-gregory.clement@free-electrons.com>
 <1363883179-1361-3-git-send-email-gregory.clement@free-electrons.com>
Message-ID: <20130321191805.GM21478@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Mar 21, 2013 at 05:26:15PM +0100, Gregory CLEMENT wrote:
> From: Lior Amsalem <alior@marvell.com>
> 
> For mvebu IOs are 32 bits and we have 40 bits memory due to LPAE so
> make sure we give 32 bits addresses to the IOs.

Hi Gregory, Lior

I don't really understand what this comment is supposed to mean. I
would of expect DMA and bounce to appear at least....

> Signed-off-by: Lior Amsalem <alior@marvell.com>
> Tested-by: Franklin <flin@marvell.com>
> Signed-off-by: Gregory CLEMENT <gregory.clement@free-electrons.com>
> ---
>  arch/arm/mach-mvebu/Kconfig |    1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/arch/arm/mach-mvebu/Kconfig b/arch/arm/mach-mvebu/Kconfig
> index 440b13e..617da94 100644
> --- a/arch/arm/mach-mvebu/Kconfig
> +++ b/arch/arm/mach-mvebu/Kconfig
> @@ -13,6 +13,7 @@ config ARCH_MVEBU
>  	select MVEBU_CLK_CORE
>  	select MVEBU_CLK_CPU
>  	select MVEBU_CLK_GATING
> +	select DMABOUNCE if ARM_LPAE
>  
>  if ARCH_MVEBU
>  
> -- 
> 1.7.9.5
> 
