From: shawn.guo@linaro.org (Shawn Guo)
Date: Mon, 18 Jun 2012 21:27:33 +0800
Subject: [PATCH] ARM: mx23: Add initial support for olinuxino board
In-Reply-To: <1339914539-4154-1-git-send-email-festevam@gmail.com>
References: <1339914539-4154-1-git-send-email-festevam@gmail.com>
Message-ID: <20120618132731.GC19249@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Jun 17, 2012 at 03:28:59AM -0300, Fabio Estevam wrote:
> From: Fabio Estevam <fabio.estevam@freescale.com>
> 
> mx23-olinuxino is a low cost board designed by Olimex.
> 
> It has the following features:
> 
> - Freescale iMX233 ARM926J processor at 454MHz
> -64 MB RAM
> -SD-card connector
> -TV PAL/NTSC video output
> -2 USB High Speed Hosts
> -Ethernet 100 Mbit
> -Stereo Audio Input
> -Stereo Headphones Audio Output
> 
> More information at:
> http://www.olimex.com/dev/imx233-olinuxino-maxi.html
> 
> Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
> ---
>  Documentation/devicetree/bindings/arm/fsl.txt |    4 ++
>  arch/arm/boot/dts/imx23-olinuxino.dts         |   45 +++++++++++++++++++++++++
>  arch/arm/boot/dts/imx23.dtsi                  |   14 ++++++++
>  arch/arm/mach-mxs/mach-mxs.c                  |    1 +
>  4 files changed, 64 insertions(+), 0 deletions(-)
>  create mode 100644 arch/arm/boot/dts/imx23-olinuxino.dts
> 
> diff --git a/Documentation/devicetree/bindings/arm/fsl.txt b/Documentation/devicetree/bindings/arm/fsl.txt
> index ac9e751..ca2bc1c 100644
> --- a/Documentation/devicetree/bindings/arm/fsl.txt
> +++ b/Documentation/devicetree/bindings/arm/fsl.txt
> @@ -5,6 +5,10 @@ i.MX23 Evaluation Kit
>  Required root node properties:
>      - compatible = "fsl,imx23-evk", "fsl,imx23";
>  
> +i.MX23 Olinuxino Low Cost Board
> +Required root node properties:
> +    - compatible = "fsl,imx23-olinuxino", "fsl,imx23";
> +

I'm not sure it's appropriate to have these in fsl.txt which should
only contain the boards made by Freescale I think.

And I even think the compatible string should be something like
"olimex,imx23-olinuxino"?

Regards,
Shawn
