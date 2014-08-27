From: mark.rutland@arm.com (Mark Rutland)
Date: Wed, 27 Aug 2014 15:54:06 +0100
Subject: [PATCH 1/6] ARM: dts: hix5hd2: add gmac node
In-Reply-To: <1409143114-23311-2-git-send-email-zhangfei.gao@linaro.org>
References: <1409143114-23311-1-git-send-email-zhangfei.gao@linaro.org>
 <1409143114-23311-2-git-send-email-zhangfei.gao@linaro.org>
Message-ID: <20140827145406.GA9737@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Aug 27, 2014 at 01:38:29PM +0100, Zhangfei Gao wrote:
> Signed-off-by: Zhangfei Gao <zhangfei.gao@linaro.org>
> ---
>  arch/arm/boot/dts/hisi-x5hd2-dkb.dts |   26 ++++++++++++++++++++++++++
>  arch/arm/boot/dts/hisi-x5hd2.dtsi    |   16 ++++++++++++++++
>  2 files changed, 42 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/hisi-x5hd2-dkb.dts b/arch/arm/boot/dts/hisi-x5hd2-dkb.dts
> index 05b44c2..0344de0 100644
> --- a/arch/arm/boot/dts/hisi-x5hd2-dkb.dts
> +++ b/arch/arm/boot/dts/hisi-x5hd2-dkb.dts
> @@ -51,3 +51,29 @@
>  &uart0 {
>  	status = "okay";
>  };
> +
> +&gmac0 {
> +	#address-cells = <1>;
> +	#size-cells = <0>;
> +	phy-handle = <&phy2>;
> +	phy-mode = "mii";
> +	mac-address = [00 00 00 00 00 00];

If this is just so space is pre-allocated for the bootloader to patch
this, please place a comment to that effect.

Otherwise that doesn't look right.

Mark.
