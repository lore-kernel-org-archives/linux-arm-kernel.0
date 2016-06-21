From: kaloz@openwrt.org (Imre Kaloz)
Date: Tue, 21 Jun 2016 14:22:05 +0200
Subject: [PATCH] ARM: BCM5301X: Set GPIO enabling USB power on Netgear
 R7000
In-Reply-To: <1466509358-25498-1-git-send-email-zajec5@gmail.com>
References: <1466509358-25498-1-git-send-email-zajec5@gmail.com>
Message-ID: <op.yjepy3mr2s3iss@ecaz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Is there any reason you are not handling this properly as a regulator with  
usb-nop-xceiv?


Imre

On Tue, 21 Jun 2016 13:42:38 +0200, Rafa? Mi?ecki <zajec5@gmail.com> wrote:

> There is one GPIO controlling power for both USB ports.
>
> Signed-off-by: Rafa? Mi?ecki <zajec5@gmail.com>
> ---
>  arch/arm/boot/dts/bcm4709-netgear-r7000.dts | 8 ++++++++
>  1 file changed, 8 insertions(+)
>
> diff --git a/arch/arm/boot/dts/bcm4709-netgear-r7000.dts  
> b/arch/arm/boot/dts/bcm4709-netgear-r7000.dts
> index a22ed14..a76486b 100644
> --- a/arch/arm/boot/dts/bcm4709-netgear-r7000.dts
> +++ b/arch/arm/boot/dts/bcm4709-netgear-r7000.dts
> @@ -104,3 +104,11 @@
>  &uart0 {
>  	status = "okay";
>  };
> +
> +&usb2 {
> +	vcc-gpio = <&chipcommon 0 GPIO_ACTIVE_HIGH>;
> +};
> +
> +&usb3 {
> +	vcc-gpio = <&chipcommon 0 GPIO_ACTIVE_HIGH>;
> +};
