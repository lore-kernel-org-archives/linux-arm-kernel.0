From: kgene.kim@samsung.com (Kukjin Kim)
Date: Fri, 01 Aug 2014 03:41:37 +0900
Subject: [PATCH v4 1/4] ARM: dts: Fix MMC pinctrl for exynos5250-snow
In-Reply-To: <1406822910-6255-2-git-send-email-afaerber@suse.de>
References: <1406822910-6255-1-git-send-email-afaerber@suse.de>
 <1406822910-6255-2-git-send-email-afaerber@suse.de>
Message-ID: <53DA8DE1.10601@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08/01/14 01:08, Andreas F?rber wrote:
> The pinctrl properties should be on the device directly and not on the
> slot sub-node.
>
> Reported-by: Doug Anderson<dianders@chromium.org>
> Cc: Jaehoon Chung<jh80.chung@samsung.com>
> Signed-off-by: Andreas F?rber<afaerber@suse.de>
> ---
>   v3 ->  v4: Unchanged
>
>   v3: New (Doug Anderson)
>   Redundant with Jaehoon Chung's general slot at 0 deprecation,
>   in case that hits the tree earlier.
>
>   arch/arm/boot/dts/exynos5250-snow.dts | 6 ++----
>   1 file changed, 2 insertions(+), 4 deletions(-)
>
> diff --git a/arch/arm/boot/dts/exynos5250-snow.dts b/arch/arm/boot/dts/exynos5250-snow.dts
> index f2b8c4116541..eb437f6afec1 100644
> --- a/arch/arm/boot/dts/exynos5250-snow.dts
> +++ b/arch/arm/boot/dts/exynos5250-snow.dts
> @@ -240,10 +240,8 @@
>   	 */
>   	mmc at 12230000 {
>   		status = "okay";
> -		slot at 0 {
> -			pinctrl-names = "default";
> -			pinctrl-0 =<&sd3_clk&sd3_cmd&sd3_bus4>;
> -		};
> +		pinctrl-names = "default";
> +		pinctrl-0 =<&sd3_clk&sd3_cmd&sd3_bus4>;
>   	};
>
>   	i2c at 12CD0000 {

Once I get Doug's reviewed tag on exynos5250-snow dt changes, I will 
take this series :) Though Doug suggested or reported...

Thanks,
Kukjin
