From: tomasz.figa@gmail.com (Tomasz Figa)
Date: Tue, 15 Apr 2014 21:06:35 +0200
Subject: [PATCH V2 3/3] ARM: dts: Add node for GPIO keys on SMDK5420
In-Reply-To: <1395900785-11334-4-git-send-email-vikas.sajjan@samsung.com>
References: <1395900785-11334-1-git-send-email-vikas.sajjan@samsung.com>
 <1395900785-11334-4-git-send-email-vikas.sajjan@samsung.com>
Message-ID: <534D833B.8030607@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On 27.03.2014 07:13, Vikas Sajjan wrote:
> From: Abhilash Kesavan <a.kesavan@samsung.com>
>
> Add support for the suspend/resume button (SW7) on SMDK5420 using
> gpio-keys driver.
>
> Signed-off-by: Abhilash Kesavan <a.kesavan@samsung.com>
> Signed-off-by: Vikas Sajjan <vikas.sajjan@samsung.com>
> ---
>   arch/arm/boot/dts/exynos5420-smdk5420.dts |   11 +++++++++++
>   1 file changed, 11 insertions(+)
>
> diff --git a/arch/arm/boot/dts/exynos5420-smdk5420.dts b/arch/arm/boot/dts/exynos5420-smdk5420.dts
> index 6910485..5ae0dd4 100644
> --- a/arch/arm/boot/dts/exynos5420-smdk5420.dts
> +++ b/arch/arm/boot/dts/exynos5420-smdk5420.dts
> @@ -158,6 +158,17 @@
>   		};
>   	};
>
> +	gpio-keys {
> +		compatible = "gpio-keys";
> +
> +		wakeup {

Is wakeup the label of this key on the PCB? The "label" property below 
would suggest otherwise. This should probably be called key-sw7 or 
something like this.

Moreover, is this the only GPIO key on the board? If there are also 
SW0-SW6, you should add them too.

> +			label = "SW7";
> +			gpios = <&gpx0 0 1>;
> +			linux,code = <143>;	/* KEY_WAKEUP */

Why not use KEY_WAKEUP defined in include/dt-bindings/input/input.h 
directly?

Best regards,
Tomasz
