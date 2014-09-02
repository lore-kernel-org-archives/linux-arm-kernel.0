From: lee.jones@linaro.org (Lee Jones)
Date: Tue, 2 Sep 2014 14:19:53 +0100
Subject: [PATCH] ARM: ux500: disable msp2 node on Snowball
In-Reply-To: <1409661681-31490-1-git-send-email-linus.walleij@linaro.org>
References: <1409661681-31490-1-git-send-email-linus.walleij@linaro.org>
Message-ID: <20140902131953.GB870@lee--X1>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 02 Sep 2014, Linus Walleij wrote:

> Analogous to commit 8858d88a25142544843869f0cd3e6654aa7b4aec
> that fixed commit 70b41abc151f9
> "ARM: ux500: move MSP pin control to the device tree"
> accidentally activated MSP2, giving rise to a boot scroll
> scream as the kernel attempts to probe a driver for it and
> fails to obtain DMA channel 14.
> 
> For some reason I forgot to fix this on the Snowball. Fix
> this up by marking the node disabled again.
> 
> Cc: Lee Jones <lee.jones@linaro.org>
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> ---
> ARM SoC folks: please apply this patch directly to fixes for
> v3.17, I have no other pending Ux500 fixes.
> ---
>  arch/arm/boot/dts/ste-snowball.dts | 1 -
>  1 file changed, 1 deletion(-)

Ah I see.  You fixed the HREF back in Feb, but I guess Snowball didn't
benefit from it.

Acked-by: Lee Jones <lee.jones@linaro.org>
 
> diff --git a/arch/arm/boot/dts/ste-snowball.dts b/arch/arm/boot/dts/ste-snowball.dts
> index 4a2000c620ad..3e97a669f15e 100644
> --- a/arch/arm/boot/dts/ste-snowball.dts
> +++ b/arch/arm/boot/dts/ste-snowball.dts
> @@ -116,7 +116,6 @@
>  		msp2: msp at 80117000 {
>  			pinctrl-names = "default";
>  			pinctrl-0 = <&msp2_default_mode>;
> -			status = "okay";
>  		};
>  
>  		msp3: msp at 80125000 {

-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
