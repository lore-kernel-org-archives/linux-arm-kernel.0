From: shawn.guo@linaro.org (Shawn Guo)
Date: Thu, 24 Jul 2014 11:17:55 +0800
Subject: [PATCH] ARM: dts: imx: Add alias for ethernet controller
In-Reply-To: <1406167639-6911-1-git-send-email-marex@denx.de>
References: <1406167639-6911-1-git-send-email-marex@denx.de>
Message-ID: <20140724031753.GA6827@dragon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jul 24, 2014 at 04:07:19AM +0200, Marek Vasut wrote:
> commit 22970070e027cbbb9b2878f8f7c31d0d7f29e94d upstream.
> 
> Add alias for FEC ethernet on i.MX25, i.MX27, i.MX51 and i.MX53 to allow
> bootloaders (like U-Boot) patch-in the MAC address for FEC using this
> alias.
> 
> Signed-off-by: Marek Vasut <marex@denx.de>
> Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
> Cc: <stable@vger.kernel.org> # 3.14.x

Since the patch is already on mainline, and the submitting target is
3.14.x stable kernel, you should really send it to Greg.

Shawn

> ---
>  arch/arm/boot/dts/imx25.dtsi | 1 +
>  arch/arm/boot/dts/imx27.dtsi | 1 +
>  arch/arm/boot/dts/imx51.dtsi | 1 +
>  arch/arm/boot/dts/imx53.dtsi | 1 +
>  4 files changed, 4 insertions(+)
> 
> NOTE: Without this backport, the ethernet adapter on most of the boards
>       with the i.MX CPUs does not know it's MAC address (the controller
>       does not have an EEPROM). Without MAC address, the ethernet cannot
>       be brought up and this makes such board unusable when booting from
>       NFS. This patch lets the bootloader pass the MAC address via DT to
>       the kernel properly, thus letting me boot from NFS again.
> 
> diff --git a/arch/arm/boot/dts/imx25.dtsi b/arch/arm/boot/dts/imx25.dtsi
> index 737ed5d..de16119 100644
> --- a/arch/arm/boot/dts/imx25.dtsi
> +++ b/arch/arm/boot/dts/imx25.dtsi
> @@ -30,6 +30,7 @@
>  		spi2 = &spi3;
>  		usb0 = &usbotg;
>  		usb1 = &usbhost1;
> +		ethernet0 = &fec;
>  	};
>  
>  	cpus {
> diff --git a/arch/arm/boot/dts/imx27.dtsi b/arch/arm/boot/dts/imx27.dtsi
> index 826231e..da2eb7f 100644
> --- a/arch/arm/boot/dts/imx27.dtsi
> +++ b/arch/arm/boot/dts/imx27.dtsi
> @@ -30,6 +30,7 @@
>  		spi0 = &cspi1;
>  		spi1 = &cspi2;
>  		spi2 = &cspi3;
> +		ethernet0 = &fec;
>  	};
>  
>  	aitc: aitc-interrupt-controller at e0000000 {
> diff --git a/arch/arm/boot/dts/imx51.dtsi b/arch/arm/boot/dts/imx51.dtsi
> index 4bcdd3a..e1b6015 100644
> --- a/arch/arm/boot/dts/imx51.dtsi
> +++ b/arch/arm/boot/dts/imx51.dtsi
> @@ -27,6 +27,7 @@
>  		spi0 = &ecspi1;
>  		spi1 = &ecspi2;
>  		spi2 = &cspi;
> +		ethernet0 = &fec;
>  	};
>  
>  	tzic: tz-interrupt-controller at e0000000 {
> diff --git a/arch/arm/boot/dts/imx53.dtsi b/arch/arm/boot/dts/imx53.dtsi
> index 7abe6c4..86df3f5 100644
> --- a/arch/arm/boot/dts/imx53.dtsi
> +++ b/arch/arm/boot/dts/imx53.dtsi
> @@ -34,6 +34,7 @@
>  		spi0 = &ecspi1;
>  		spi1 = &ecspi2;
>  		spi2 = &cspi;
> +		ethernet0 = &fec;
>  	};
>  
>  	cpus {
> -- 
> 2.0.1
> 
