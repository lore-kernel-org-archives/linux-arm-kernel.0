From: icenowy@aosc.io (Icenowy Zheng)
Date: Thu, 28 Dec 2017 21:01:26 +0800
Subject: [PATCH] ARM: dts: sun8i: Fix power for USB Ethernet controller
In-Reply-To: <20171228125222.12942-1-hauke@hauke-m.de>
References: <20171228125222.12942-1-hauke@hauke-m.de>
Message-ID: <137686441.91VTU2W72k@ice-x220i>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

? 2017?12?28???? CST ??8:52:22?Hauke Mehrtens ???
> The RTL8152B USB controller needs a 3.3 volt power supply which is
> controlled by PAD20. Without this patch Linux will not see that there is
> a device connected to the USB bus and the 2. USB port will not work.
> 
> I do not of a better solution to add a regulator to a USB device.

I have one.

Please check the patch I will send you soon.

> 
> Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
> ---
>  arch/arm/boot/dts/sun8i-h2-plus-orangepi-r1.dts | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/sun8i-h2-plus-orangepi-r1.dts
> b/arch/arm/boot/dts/sun8i-h2-plus-orangepi-r1.dts index
> 32a6d312422e..1d5db0e0bd12 100644
> --- a/arch/arm/boot/dts/sun8i-h2-plus-orangepi-r1.dts
> +++ b/arch/arm/boot/dts/sun8i-h2-plus-orangepi-r1.dts
> @@ -47,13 +47,15 @@
>  	model = "Xunlong Orange Pi R1";
>  	compatible = "xunlong,orangepi-r1", "allwinner,sun8i-h2-plus";
> 
> -	/delete-node/ reg_vcc_wifi;
> -
>  	aliases {
>  		ethernet1 = &rtl8189etv;
>  	};
>  };
> 
> +&reg_vcc_wifi {
> +	regulator-always-on;
> +};
> +
>  &ohci1 {
>  	/*
>  	 * RTL8152B USB-Ethernet adapter is connected to USB1,
