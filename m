From: mark.rutland@arm.com (Mark Rutland)
Date: Thu, 17 Oct 2013 15:06:59 +0100
Subject: [RESEND PATCH v2 5/6] ARM: dts: Specify clocks for timer on
 bcm11351
In-Reply-To: <1381960030-1640-6-git-send-email-tim.kryger@linaro.org>
References: <1381960030-1640-1-git-send-email-tim.kryger@linaro.org>
 <1381960030-1640-6-git-send-email-tim.kryger@linaro.org>
Message-ID: <20131017140659.GF24056@e106331-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> diff --git a/arch/arm/boot/dts/bcm11351.dtsi b/arch/arm/boot/dts/bcm11351.dtsi
> index 193659c..39c1395 100644
> --- a/arch/arm/boot/dts/bcm11351.dtsi
> +++ b/arch/arm/boot/dts/bcm11351.dtsi
> @@ -95,7 +95,7 @@
>  		compatible = "brcm,kona-timer";
>  		reg = <0x35006000 0x1000>;
>  		interrupts = <GIC_SPI 7 IRQ_TYPE_LEVEL_HIGH>;
> -		clock-frequency = <32768>;
> +		clocks = <&hub_timer_clk>;

This should probably be after the code change that enables support for a
clocks property.

Thanks,
Mark.
