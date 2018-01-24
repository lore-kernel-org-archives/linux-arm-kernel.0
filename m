From: festevam@gmail.com (Fabio Estevam)
Date: Wed, 24 Jan 2018 10:44:11 -0200
Subject: [PATCH v2 1/3] ARM: dts: imx: Pass empty memory size on board dts
In-Reply-To: <1516796485-24912-1-git-send-email-marcofrk@gmail.com>
References: <1516796485-24912-1-git-send-email-marcofrk@gmail.com>
Message-ID: <CAOMZO5B3pr5-93qafFnB1DJYHGW7_CeVhHwjA9xhJgc+dJ-FYw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Marco,

On Wed, Jan 24, 2018 at 10:21 AM, Marco Franchi <marcofrk@gmail.com> wrote:
> In preparation for removing 'reg = <0 0>;' from the dtsi SoC files, pass
> 'reg = <0 0 >;' to the dts/dtsi board files that do not pass the memory
> size.
>
> Signed-off-by: Marco Franchi <marco.franchi@nxp.com>
> ---
> Change since v1:
> -none
>  arch/arm/boot/dts/imx51-zii-rdu1.dts         | 5 +++++
>  arch/arm/boot/dts/imx53-tx53.dtsi            | 5 +++++
>  arch/arm/boot/dts/imx6dl-colibri-eval-v3.dts | 5 +++++
>  arch/arm/boot/dts/imx6dl-dfi-fs700-m60.dts   | 5 +++++
>  arch/arm/boot/dts/imx6dl-ts4900.dts          | 5 +++++
>  arch/arm/boot/dts/imx6dl-ts7970.dts          | 5 +++++
>  arch/arm/boot/dts/imx6q-dfi-fs700-m60.dts    | 5 +++++
>  arch/arm/boot/dts/imx6q-h100.dts             | 5 +++++
>  arch/arm/boot/dts/imx6q-novena.dts           | 5 +++++
>  arch/arm/boot/dts/imx6q-ts4900.dts           | 5 +++++
>  arch/arm/boot/dts/imx6q-ts7970.dts           | 5 +++++
>  arch/arm/boot/dts/imx6q-zii-rdu2.dts         | 5 +++++
>  arch/arm/boot/dts/imx6qdl-apalis.dtsi        | 5 +++++
>  arch/arm/boot/dts/imx6qdl-cubox-i.dtsi       | 5 +++++
>  arch/arm/boot/dts/imx6qdl-hummingboard.dtsi  | 5 +++++
>  arch/arm/boot/dts/imx6qdl-hummingboard2.dtsi | 5 +++++
>  arch/arm/boot/dts/imx6qp-zii-rdu2.dts        | 5 +++++
>  17 files changed, 85 insertions(+)
>
> diff --git a/arch/arm/boot/dts/imx51-zii-rdu1.dts b/arch/arm/boot/dts/imx51-zii-rdu1.dts
> index 5306b78..f20fdd9 100644
> --- a/arch/arm/boot/dts/imx51-zii-rdu1.dts
> +++ b/arch/arm/boot/dts/imx51-zii-rdu1.dts
> @@ -51,6 +51,11 @@
>                 stdout-path = &uart1;
>         };
>
> +       /* Will be filled by the bootloader */
> +       memory at 0 {

You need to remove @0 here as 0 is not the real address.

This will still cause warnings, but then each board maintainer can
decide if they want to put the real memory address for the board dts.

Thanks
