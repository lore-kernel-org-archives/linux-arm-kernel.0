From: festevam@gmail.com (Fabio Estevam)
Date: Thu, 28 Jun 2018 15:43:52 -0300
Subject: [RFC] ARM: dts: imx7s: Fix the port reg properties
In-Reply-To: <1526306996-25045-1-git-send-email-festevam@gmail.com>
References: <1526306996-25045-1-git-send-email-festevam@gmail.com>
Message-ID: <CAOMZO5DPdzQVtSHfp3RtgLPsUi_aTJG7J-OrJpUz0Kk3U86zzQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Rob,

On Mon, May 14, 2018 at 11:09 AM, Fabio Estevam <festevam@gmail.com> wrote:
> From: Fabio Estevam <fabio.estevam@nxp.com>
>
> The 'reg' property must match the unit address, so fix them
> to avoid the following DTC warnings with W=1:
>
> arch/arm/boot/dts/imx7d-cl-som-imx7.dtb: Warning (graph_port): /replicator/ports/port at 2: graph node unit address error, expected "0"
> arch/arm/boot/dts/imx7d-cl-som-imx7.dtb: Warning (graph_port): /soc/funnel at 30041000/ports/port at 2: graph node unit address error, expected "0"
> arch/arm/boot/dts/imx7d-cl-som-imx7.dtb: Warning (graph_port): /soc/funnel at 30083000/ports/port at 2: graph node unit address error, expected "0"
> arch/arm/boot/dts/imx7d-cl-som-imx7.dtb: Warning (graph_port): /soc/etf at 30084000/ports/port at 1: graph node unit address error, expected "0"
>
> Signed-off-by: Fabio Estevam <fabio.estevam@nxp.com>
> ---
> Hi Rob,
>
> Is this the correct way to fix these warnings?

Any suggestions, please? I would like to clean up these dtc warnings.

Thanks


>
>  arch/arm/boot/dts/imx7s.dtsi | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/arch/arm/boot/dts/imx7s.dtsi b/arch/arm/boot/dts/imx7s.dtsi
> index 7d33993..55b6241 100644
> --- a/arch/arm/boot/dts/imx7s.dtsi
> +++ b/arch/arm/boot/dts/imx7s.dtsi
> @@ -126,7 +126,7 @@
>
>                         /* replicator input port */
>                         port at 2 {
> -                               reg = <0>;
> +                               reg = <2>;
>                                 replicator_in_port0: endpoint {
>                                         slave-mode;
>                                         remote-endpoint = <&etf_out_port>;
> @@ -183,7 +183,7 @@
>
>                                 /* funnel output port */
>                                 port at 2 {
> -                                       reg = <0>;
> +                                       reg = <2>;
>                                         ca_funnel_out_port0: endpoint {
>                                                 remote-endpoint = <&hugo_funnel_in_port0>;
>                                         };
> @@ -234,7 +234,7 @@
>                                 };
>
>                                 port at 2 {
> -                                       reg = <0>;
> +                                       reg = <2>;
>                                         hugo_funnel_out_port0: endpoint {
>                                                 remote-endpoint = <&etf_in_port>;
>                                         };
> @@ -263,7 +263,7 @@
>                                 };
>
>                                 port at 1 {
> -                                       reg = <0>;
> +                                       reg = <1>;
>                                         etf_out_port: endpoint {
>                                                 remote-endpoint = <&replicator_in_port0>;
>                                         };
> --
> 2.7.4
>
