From: l.stach@pengutronix.de (Lucas Stach)
Date: Tue, 15 May 2018 10:52:36 +0200
Subject: [PATCH] ARM: dts: imx51-zii-rdu1: limit usbh1 to full-speed
In-Reply-To: <20180515084502.17148-1-nikita.yoush@cogentembedded.com>
References: <20180515084502.17148-1-nikita.yoush@cogentembedded.com>
Message-ID: <1526374356.3494.14.camel@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Dienstag, den 15.05.2018, 11:45 +0300 schrieb Nikita Yushchenko:
> On RDU1, imx51 usbh1 interface is either not used, or used via
> external
> block that breaks USB2 signalling.
> 
> To keep things working if high-speed device gets connected to that
> block, use ChipIdea feature to limit port to full speed.
> 
> Signed-off-by: Nikita Yushchenko <nikita.yoush@cogentembedded.com>

Reviewed-by: Lucas Stach <l.stach@pengutronix.de>

> ---
> ?arch/arm/boot/dts/imx51-zii-rdu1.dts | 1 +
> ?1 file changed, 1 insertion(+)
> 
> diff --git a/arch/arm/boot/dts/imx51-zii-rdu1.dts
> b/arch/arm/boot/dts/imx51-zii-rdu1.dts
> index 36a63ae52e48..c26f053f29b0 100644
> --- a/arch/arm/boot/dts/imx51-zii-rdu1.dts
> +++ b/arch/arm/boot/dts/imx51-zii-rdu1.dts
> @@ -603,6 +603,7 @@
> ?	phy_type = "ulpi";
> ?	fsl,usbphy = <&usbh1phy>;
> ?	disable-over-current;
> +	maximum-speed = "full-speed";
> ?	vbus-supply = <&reg_5p0v_main>;
> ?	status = "okay";
> ?};
