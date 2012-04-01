From: dirk.behme@googlemail.com (Dirk Behme)
Date: Sun, 01 Apr 2012 17:37:47 +0200
Subject: [PATCH 2/2] ARM: dts: imx6q-sabrelite: Add bootargs field
In-Reply-To: <1333293138-2610-1-git-send-email-festevam@gmail.com>
References: <1333293138-2610-1-git-send-email-festevam@gmail.com>
Message-ID: <4F78764B.5030304@googlemail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Fabio,

On 01.04.2012 17:12, Fabio Estevam wrote:
> Add bootargs field.
>
> Signed-off-by: Fabio Estevam<fabio.estevam@freescale.com>
> ---
>   arch/arm/boot/dts/imx6q-sabrelite.dts |    4 ++++
>   1 files changed, 4 insertions(+), 0 deletions(-)
>
> diff --git a/arch/arm/boot/dts/imx6q-sabrelite.dts b/arch/arm/boot/dts/imx6q-sabrelite.dts
> index 4663a4e..73915dc 100644
> --- a/arch/arm/boot/dts/imx6q-sabrelite.dts
> +++ b/arch/arm/boot/dts/imx6q-sabrelite.dts
> @@ -17,6 +17,10 @@
>   	model = "Freescale i.MX6 Quad SABRE Lite Board";
>   	compatible = "fsl,imx6q-sabrelite", "fsl,imx6q";
>
> +	chosen {
> +		bootargs = "console=ttymxc1,115200 root=/dev/mmcblk0p3 rootwait";
> +	};
> +

Why do we need this? U-Boot adds this at runtime with the configured 
bootargs.

Best regards

Dirk
