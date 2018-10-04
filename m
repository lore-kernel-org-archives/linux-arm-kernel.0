From: boris.brezillon@bootlin.com (Boris Brezillon)
Date: Thu, 4 Oct 2018 11:18:22 +0200
Subject: [PATCH 4/4] arm64: dts: lx2160a: update fspi node
In-Reply-To: <1538642920-3843-5-git-send-email-yogeshnarayan.gaur@nxp.com>
References: <1538642920-3843-1-git-send-email-yogeshnarayan.gaur@nxp.com>
 <1538642920-3843-5-git-send-email-yogeshnarayan.gaur@nxp.com>
Message-ID: <20181004111822.48ab1f5c@bbrezillon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu,  4 Oct 2018 14:18:40 +0530
Yogesh Gaur <yogeshnarayan.gaur@nxp.com> wrote:

> Flash mt35xu512aba connected to FlexSPI controller supports
> 1-1-8 protocol.
> Added flag spi-rx-bus-width and spi-tx-bus-width with values as
> 8 and 1 respectively for both flashes connected at CS0 and CS1.
> 
> Signed-off-by: Yogesh Gaur <yogeshnarayan.gaur@nxp.com>
> ---
>  arch/arm64/boot/dts/freescale/fsl-lx2160a-rdb.dts | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/freescale/fsl-lx2160a-rdb.dts b/arch/arm64/boot/dts/freescale/fsl-lx2160a-rdb.dts
> index 901ca346..817175a 100644
> --- a/arch/arm64/boot/dts/freescale/fsl-lx2160a-rdb.dts
> +++ b/arch/arm64/boot/dts/freescale/fsl-lx2160a-rdb.dts
> @@ -42,6 +42,8 @@
>  		m25p,fast-read;
>  		spi-max-frequency = <20000000>;
>  		reg = <0>;
> +		spi-rx-bus-width = <8>;
> +		spi-tx-bus-width = <1>;

Why 1? The flash is already flagged with SPI_NOR_OCTAL_READ, which
means only the read path will use 1-1-8 mode, so you can safely set
spi-tx-bus-width here and let the framework choose the appropriate mode
based on the flash capabilities.

>  	};
>  
>  	mt35xu512aba1: flash at 1 {
> @@ -51,6 +53,8 @@
>  		m25p,fast-read;
>  		spi-max-frequency = <20000000>;
>  		reg = <1>;
> +		spi-rx-bus-width = <8>;
> +		spi-tx-bus-width = <1>;
>  	};
>  };
>  
