From: bjorn.andersson@linaro.org (Bjorn Andersson)
Date: Tue, 9 Aug 2016 21:34:24 -0700
Subject: [RFC][PATCH 3/4] arm64: dts: hikey: Add hikey support for
 syscon-reboot-mode
In-Reply-To: <1470697426-16426-3-git-send-email-john.stultz@linaro.org>
References: <1470697426-16426-1-git-send-email-john.stultz@linaro.org>
 <1470697426-16426-3-git-send-email-john.stultz@linaro.org>
Message-ID: <20160810043424.GH26240@tuxbot>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon 08 Aug 16:03 PDT 2016, John Stultz wrote:

[..]
> diff --git a/arch/arm64/boot/dts/hisilicon/hi6220-hikey.dts b/arch/arm64/boot/dts/hisilicon/hi6220-hikey.dts
[..]
>  	memory at 0 {
>  		device_type = "memory";
>  		reg = <0x00000000 0x00000000 0x00000000 0x05e00000>,
> -		      <0x00000000 0x05f00000 0x00000000 0x00eff000>,
> +		      <0x00000000 0x05f00000 0x00000000 0x00001000>,
> +		      <0x00000000 0x05f02000 0x00000000 0x00efd000>,
>  		      <0x00000000 0x06e00000 0x00000000 0x0060f000>,
>  		      <0x00000000 0x07410000 0x00000000 0x36bf0000>;
>  	};

As I said when talked about this, I don't think you should punch holes
in the /memory node, but rather add these regions as no-map in a
/reserved-memory node. But that's a unrelated matter.

>  
> +	reboot-mode-syscon at 5f01000 {
> +		compatible = "syscon", "simple-mfd";
> +		reg = <0x0 0x05f01000 0x0 0x00001000>;
> +
> +		reboot-mode at 0 {

Drop the @0

Other than that:
Acked-by: Bjorn Andersson <bjorn.andersson@linaro.org>

> +			compatible = "syscon-reboot-mode";
> +			offset = <0x0>;
> +
> +			mode-normal	= <0x77665501>;
> +			mode-bootloader	= <0x77665500>;
> +			mode-recovery	= <0x77665502>;
> +		};
> +	};
> +
>  	soc {
>  		spi0: spi at f7106000 {
>  			status = "ok";

Regards,
Bjorn
