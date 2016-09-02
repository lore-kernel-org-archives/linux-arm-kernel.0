From: xuwei5@hisilicon.com (Wei Xu)
Date: Fri, 2 Sep 2016 11:21:43 +0100
Subject: [PATCH] arm64: dts: hi6220: add sd-uhs- properties into dwmmc_1
In-Reply-To: <1472649058-22364-1-git-send-email-guodong.xu@linaro.org>
References: <1472649058-22364-1-git-send-email-guodong.xu@linaro.org>
Message-ID: <57C952B7.3010207@hisilicon.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Guodong,

On 31/08/2016 14:10, Guodong Xu wrote:
> With these properties added, sd cards inserted into hikey can work at UHS
> mode if they have such capability.
> 
> Note, this depends on HiKey UHS-SD support patch [1] to work properly.
> If you didn't add this patch, but added sd-uhs- properties into dwmmc_1,
> then sd cards cannot work. As of this post, patch [1] has been integrated
> into maintainer's next branch [2].
> 
> [1]: [V4] mmc: dw_mmc-k3: UHS-SD card for Hisilicon Hikey,
>  https://patchwork.kernel.org/patch/9262515/
> [2]: https://git.linaro.org/people/ulf.hansson/mmc.git next
>  commit a8a5b2909cfc ("mmc: dw_mmc: k3: UHS-SD card for Hisilicon Hikey")
> 
> cc: Ulf Hansson <ulf.hansson@linaro.org>
> cc: Jaehoon Chung <jh80.chung@samsung.com>
> cc: Jinguojun <kid.jin@hisilicon.com>
> Signed-off-by: Guodong Xu <guodong.xu@linaro.org>

Applied to the hisi-dt-4.9 branch.
Thanks!

Best Regards,
Wei

> ---
>  arch/arm64/boot/dts/hisilicon/hi6220.dtsi | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/hisilicon/hi6220.dtsi b/arch/arm64/boot/dts/hisilicon/hi6220.dtsi
> index 63608e9..17839db 100644
> --- a/arch/arm64/boot/dts/hisilicon/hi6220.dtsi
> +++ b/arch/arm64/boot/dts/hisilicon/hi6220.dtsi
> @@ -785,6 +785,9 @@
>  			card-detect-delay = <200>;
>  			hisilicon,peripheral-syscon = <&ao_ctrl>;
>  			cap-sd-highspeed;
> +			sd-uhs-sdr12;
> +			sd-uhs-sdr25;
> +			sd-uhs-sdr50;
>  			reg = <0x0 0xf723e000 0x0 0x1000>;
>  			interrupts = <0x0 0x49 0x4>;
>  			#address-cells = <0x1>;
> 
