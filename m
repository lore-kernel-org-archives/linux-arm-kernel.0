From: festevam@gmail.com (Fabio Estevam)
Date: Fri, 19 Apr 2013 12:26:33 -0300
Subject: [PATCH] ARM: mx28: add dma channels for all auarts
In-Reply-To: <1366383906-25747-1-git-send-email-eric@eukrea.com>
References: <1366383906-25747-1-git-send-email-eric@eukrea.com>
Message-ID: <CAOMZO5B9mL9rzYc9zHjJ_994u=HVerHGa+C+Lqc8VJmse8ak2Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Eric,

On Fri, Apr 19, 2013 at 12:05 PM, Eric B?nard <eric@eukrea.com> wrote:
> Only auart0 was filled.
> Tested on a custom i.MX283 board for ttyAPP1/2/3/4.
>
> Signed-off-by: Eric B?nard <eric@eukrea.com>
> ---
>  arch/arm/boot/dts/imx28.dtsi | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/arch/arm/boot/dts/imx28.dtsi b/arch/arm/boot/dts/imx28.dtsi
> index 25f2243..15933ed 100644
> --- a/arch/arm/boot/dts/imx28.dtsi
> +++ b/arch/arm/boot/dts/imx28.dtsi
> @@ -886,6 +886,7 @@
>                                 compatible = "fsl,imx28-auart", "fsl,imx23-auart";
>                                 reg = <0x8006c000 0x2000>;
>                                 interrupts = <113 72 73>;
> +                               fsl,auart-dma-channel = <10 11>;

Now we use the generic 'dmas' binding to passing such information.

If you look at linux-next tree these UART dma channels are already
been passed via the new 'dmas' method:

			auart1: serial at 8006c000 {
				compatible = "fsl,imx28-auart", "fsl,imx23-auart";
				reg = <0x8006c000 0x2000>;
				interrupts = <113 72 73>;
				dmas = <&dma_apbx 10>, <&dma_apbx 11>;
				dma-names = "rx", "tx";
				clocks = <&clks 45>;
				status = "disabled";
			};
