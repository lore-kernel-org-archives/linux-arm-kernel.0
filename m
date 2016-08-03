From: festevam@gmail.com (Fabio Estevam)
Date: Wed, 3 Aug 2016 11:26:48 -0300
Subject: [PATCH 2/2] imx53.dtsi : Add DMA configuration for UART
In-Reply-To: <1470233593-4513-2-git-send-email-fabien.lahoudere@collabora.co.uk>
References: <1470233593-4513-1-git-send-email-fabien.lahoudere@collabora.co.uk>
 <1470233593-4513-2-git-send-email-fabien.lahoudere@collabora.co.uk>
Message-ID: <CAOMZO5BoRsrHv-+5c9bAXO2NCya8sPqmmpy9DOfav6NvQ+VMLQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Fabien,

On Wed, Aug 3, 2016 at 11:13 AM, Fabien Lahoudere
<fabien.lahoudere@collabora.co.uk> wrote:
> In order to use sdma with UART, we need to add DMA configuration in device tree.
>
> Signed-off-by: Fabien Lahoudere <fabien.lahoudere@collabora.co.uk>
> ---
>  arch/arm/boot/dts/imx53.dtsi | 8 ++++++++
>  1 file changed, 8 insertions(+)
>
> diff --git a/arch/arm/boot/dts/imx53.dtsi b/arch/arm/boot/dts/imx53.dtsi
> index cd17037..de545e2 100644
> --- a/arch/arm/boot/dts/imx53.dtsi
> +++ b/arch/arm/boot/dts/imx53.dtsi
> @@ -217,6 +217,8 @@
>                                         clocks = <&clks IMX5_CLK_UART3_IPG_GATE>,
>                                                  <&clks IMX5_CLK_UART3_PER_GATE>;
>                                         clock-names = "ipg", "per";
> +                                       dmas = <&sdma 42 4 0>, <&sdma 43 4 0>;
> +                                       dma-names = "rx", "tx";
>                                         status = "disabled";
>                                 };

Care to add the dma channels for uart1 as well?

Thanks
