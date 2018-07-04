From: Jisheng.Zhang@synaptics.com (Jisheng Zhang)
Date: Wed, 4 Jul 2018 17:14:35 +0800
Subject: [PATCH] ARM: dts: berlin: switch to earlycon
In-Reply-To: <7f67507ad697fc8c6d012f734c4d9a631d1afad1.1527608389.git.tommyhebb@gmail.com>
References: <7f67507ad697fc8c6d012f734c4d9a631d1afad1.1527608389.git.tommyhebb@gmail.com>
Message-ID: <20180704171435.6b6113de@xhacker.debian>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Thomas,

On Tue, 29 May 2018 11:41:42 -0400 Thomas Hebb wrote:

> The Synopsys DesignWare 8250 UART in Berlin SoCs is now supported by
> 8250_early, so we can use earlycon for early console output instead
> of earlyprintk, which requires an SoC-specific kernel.

IIRC, earlyprintk still works during the decompress progress while the
earlycon doesn't.

> 
> Signed-off-by: Thomas Hebb <tommyhebb@gmail.com>
> ---
>  arch/arm/boot/dts/berlin2-sony-nsz-gs7.dts        | 2 +-
>  arch/arm/boot/dts/berlin2cd-google-chromecast.dts | 2 +-
>  arch/arm/boot/dts/berlin2q-marvell-dmp.dts        | 2 +-
>  3 files changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/berlin2-sony-nsz-gs7.dts b/arch/arm/boot/dts/berlin2-sony-nsz-gs7.dts
> index 1c475796d17f..f98798bb684f 100644
> --- a/arch/arm/boot/dts/berlin2-sony-nsz-gs7.dts
> +++ b/arch/arm/boot/dts/berlin2-sony-nsz-gs7.dts
> @@ -45,7 +45,7 @@
>  	compatible = "sony,nsz-gs7", "marvell,berlin2", "marvell,berlin";
>  
>  	chosen {
> -		bootargs = "earlyprintk";
> +		bootargs = "earlycon";

Is there something missing here? example, uart8250,mmio,<addr>?

>  		stdout-path = "serial0:115200n8";
>  	};
>  
> diff --git a/arch/arm/boot/dts/berlin2cd-google-chromecast.dts b/arch/arm/boot/dts/berlin2cd-google-chromecast.dts
> index ca24def0ce13..20f31cdeaf38 100644
> --- a/arch/arm/boot/dts/berlin2cd-google-chromecast.dts
> +++ b/arch/arm/boot/dts/berlin2cd-google-chromecast.dts
> @@ -46,7 +46,7 @@
>  	compatible = "google,chromecast", "marvell,berlin2cd", "marvell,berlin";
>  
>  	chosen {
> -		bootargs = "earlyprintk";
> +		bootargs = "earlycon";
>  		stdout-path = "serial0:115200n8";
>  	};
>  
> diff --git a/arch/arm/boot/dts/berlin2q-marvell-dmp.dts b/arch/arm/boot/dts/berlin2q-marvell-dmp.dts
> index 57aa5f8a7c77..9834e84a0797 100644
> --- a/arch/arm/boot/dts/berlin2q-marvell-dmp.dts
> +++ b/arch/arm/boot/dts/berlin2q-marvell-dmp.dts
> @@ -49,7 +49,7 @@
>  	};
>  
>  	chosen {
> -		bootargs = "earlyprintk";
> +		bootargs = "earlycon";
>  		stdout-path = "serial0:115200n8";
>  	};
>  
