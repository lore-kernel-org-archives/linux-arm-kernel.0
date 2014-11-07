From: cw00.choi@samsung.com (Chanwoo Choi)
Date: Fri, 07 Nov 2014 20:50:56 +0900
Subject: [PATCH] ARM: dts: Fix booting on Rinato market device
In-Reply-To: <1415360662-30390-1-git-send-email-k.kozlowski@samsung.com>
References: <1415360662-30390-1-git-send-email-k.kozlowski@samsung.com>
Message-ID: <545CB220.9030007@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Krzysztof,

On 11/07/2014 08:44 PM, Krzysztof Kozlowski wrote:
> The bootloader on market Rinato (Gear 2) device checks for revision in
> compatible field of DTB. If it is not present or lower than required
> then booting fails with: "Could not do normal boot. (no DTB found)".
> 
> Log of bootloader in case of failure:
> h/w: revision  = 0x06
> h/w: schematic = SM-R380_Rev0.5_Final_0205
> date = 2000/01/01 12:00:21 (UTC)
> cmu_div:4, div:5, src_clk:800000000, pixel_clk:31860720
> load_kernel: loading boot image from 57344.. (BOOT)
> load_kernel: found zImage, size: 0x3267e8
> 0xbc Error!
> Verify_Binary_Signature: failed.
> pit_check_signature (BOOT) invalid.
> load_kernel: found custom kernel (ret:-2147483647)
>  No need to update kernel type.
> Detected board: samsung,rinato-rev06
> Could not do normal boot. (no DTB found)
> : Entering usb mode for SM-R380_EUR_XX (65535)..
> 
> Add a "rev06" suffix to compatible to satisfy the bootloader.
> 
> Signed-off-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
> ---
>  arch/arm/boot/dts/exynos3250-rinato.dts | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm/boot/dts/exynos3250-rinato.dts b/arch/arm/boot/dts/exynos3250-rinato.dts
> index 84380fa13e37..f72ba0a1d915 100644
> --- a/arch/arm/boot/dts/exynos3250-rinato.dts
> +++ b/arch/arm/boot/dts/exynos3250-rinato.dts
> @@ -18,7 +18,8 @@
>  
>  / {
>  	model = "Samsung Rinato board";
> -	compatible = "samsung,rinato", "samsung,exynos3250", "samsung,exynos3";
> +	compatible = "samsung,rinato", "samsung,rinato-rev06",
> +			"samsung,exynos3250", "samsung,exynos3";

I think it is wrong. The released bootloader from Samsung is not u-boot.
Instead, you have to update u-boot to support Exynos3250-basd Rinato board.

Thanks,
Chanwoo Choi
