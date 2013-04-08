From: shawn.guo@linaro.org (Shawn Guo)
Date: Mon, 8 Apr 2013 14:35:59 +0800
Subject: [PATCH 2/3] ARM: dts: Add SPI support for i.MX27 Phytec PCM038
 module
In-Reply-To: <1365348554-24345-2-git-send-email-shc_work@mail.ru>
References: <1365348554-24345-1-git-send-email-shc_work@mail.ru>
 <1365348554-24345-2-git-send-email-shc_work@mail.ru>
Message-ID: <20130408063557.GC5047@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Apr 07, 2013 at 07:29:13PM +0400, Alexander Shiyan wrote:
> Added SPI node to imx27-phytec-phycore DT file.
> 
> Signed-off-by: Alexander Shiyan <shc_work@mail.ru>
> ---
>  arch/arm/boot/dts/imx27-phytec-phycore.dtsp | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/imx27-phytec-phycore.dtsp b/arch/arm/boot/dts/imx27-phytec-phycore.dtsp
> index 7228153..354dc77 100644
> --- a/arch/arm/boot/dts/imx27-phytec-phycore.dtsp
> +++ b/arch/arm/boot/dts/imx27-phytec-phycore.dtsp
> @@ -77,3 +77,9 @@
>  	nand-ecc-mode = "hw";
>  	status = "okay";
>  };
> +
> +&cspi1 {
> +	fsl,spi-num-chipselects = <1>;
> +	cs-gpios = <&gpio4 28 0>;
> +	status = "okay";
> +};

I would suggest these codes be sorted in alphabet order of label name.
IOW, &cspi1 should be put before &nfc. 

Shawn

> -- 
> 1.8.1.5
> 
> _______________________________________________
> devicetree-discuss mailing list
> devicetree-discuss at lists.ozlabs.org
> https://lists.ozlabs.org/listinfo/devicetree-discuss
