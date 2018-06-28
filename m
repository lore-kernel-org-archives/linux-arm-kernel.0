From: xuwei5@hisilicon.com (Wei Xu)
Date: Thu, 28 Jun 2018 21:25:31 +0100
Subject: [PATCH] arm64: dts: hikey: Define wl1835 power capabilities
In-Reply-To: <20180613151305.17240-1-ryan@edited.us>
References: <20180613151305.17240-1-ryan@edited.us>
Message-ID: <5B35443B.2060903@hisilicon.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Ryan,

On 2018/6/13 16:13, Ryan Grachek wrote:
> These properties are required for compatibility with runtime PM.
> Without these properties, MMC host controller will not be aware
> of power capabilities. When the wlcore driver attempts to power
> on the device, it will erroneously fail with -EACCES.
> 
> Signed-off-by: Ryan Grachek <ryan@edited.us>
> ---

Applied to hisilicon fix tree.
Thanks!

Best Regards,
Wei

>  arch/arm64/boot/dts/hisilicon/hi6220-hikey.dts | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/hisilicon/hi6220-hikey.dts b/arch/arm64/boot/dts/hisilicon/hi6220-hikey.dts
> index 38f881955217..c5feca8cd10b 100644
> --- a/arch/arm64/boot/dts/hisilicon/hi6220-hikey.dts
> +++ b/arch/arm64/boot/dts/hisilicon/hi6220-hikey.dts
> @@ -323,6 +323,8 @@
>  			bus-width = <0x4>;
>  			cap-sd-highspeed;
>  			non-removable;
> +			cap-power-off-card;
> +			keep-power-in-suspend;
>  			vmmc-supply = <&reg_vdd_3v3>;
>  			mmc-pwrseq = <&wl1835_pwrseq>;
>  
> 
