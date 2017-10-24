From: pku.leo@gmail.com (Yang Li)
Date: Tue, 24 Oct 2017 17:26:37 -0500
Subject: [PATCH v3] arm64: dts: ls1088a: Add USB support
In-Reply-To: <20171024093118.31238-1-yinbo.zhu@nxp.com>
References: <20171024093118.31238-1-yinbo.zhu@nxp.com>
Message-ID: <CADRPPNS8+APXQRcmHqn9YDHKbyE49gH3yoQjrsOQfYrMykeizg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Oct 24, 2017 at 4:31 AM,  <yinbo.zhu@nxp.com> wrote:
> From: "yinbo.zhu" <yinbo.zhu@nxp.com>
>
> Fix the issue that usb is not detected on ls1088ardb

You can only fix issue for a function after the function has been
added previously.  So like Shawn commented, this patch is about adding
the USB support instead of fixing an issue.

>
> Signed-off-by: yinbo.zhu <yinbo.zhu@nxp.com>
> Signed-off-by: Ran Wang <ran.wang_1@nxp.com>
> ---
>
> Change in v3:
>                 - Change status from "enable" to "disabled" then enable it on dts file.
>                 - Add the version history.
>
>  arch/arm64/boot/dts/freescale/fsl-ls1088a-rdb.dts |  8 ++++++++
>  arch/arm64/boot/dts/freescale/fsl-ls1088a.dtsi    | 20 ++++++++++++++++++++
>  2 files changed, 28 insertions(+)
>
> diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1088a-rdb.dts b/arch/arm64/boot/dts/freescale/fsl-ls1088a-rdb.dts
> index 213abb72de93..6c3c3bc4b681 100644
> --- a/arch/arm64/boot/dts/freescale/fsl-ls1088a-rdb.dts
> +++ b/arch/arm64/boot/dts/freescale/fsl-ls1088a-rdb.dts
> @@ -118,6 +118,14 @@
>         status = "okay";
>  };
>
> +&usb0 {
> +       status = "okay";
> +};
> +
> +&usb1 {
> +       status = "okay";
> +};
> +
>  &esdhc {
>         status = "okay";
>  };
> diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1088a.dtsi b/arch/arm64/boot/dts/freescale/fsl-ls1088a.dtsi
> index c144d06a6e33..c23fede8cf5d 100644
> --- a/arch/arm64/boot/dts/freescale/fsl-ls1088a.dtsi
> +++ b/arch/arm64/boot/dts/freescale/fsl-ls1088a.dtsi
> @@ -359,6 +359,26 @@
>                         status = "disabled";
>                 };
>
> +               usb0: usb3 at 3100000 {
> +                       compatible = "snps,dwc3";
> +                       reg = <0x0 0x3100000 0x0 0x10000>;
> +                       interrupts = <0 80 IRQ_TYPE_LEVEL_HIGH>;
> +                       dr_mode = "host";
> +                       snps,quirk-frame-length-adjustment = <0x20>;
> +                       snps,dis_rxdet_inp3_quirk;
> +                       status = "disabled";
> +               };
> +
> +               usb1: usb3 at 3110000 {
> +                       compatible = "snps,dwc3";
> +                       reg = <0x0 0x3110000 0x0 0x10000>;
> +                       interrupts = <0 81 IRQ_TYPE_LEVEL_HIGH>;
> +                       dr_mode = "host";
> +                       snps,quirk-frame-length-adjustment = <0x20>;
> +                       snps,dis_rxdet_inp3_quirk;
> +                       status = "disabled";
> +               };
> +
>                 sata: sata at 3200000 {
>                         compatible = "fsl,ls1088a-ahci";
>                         reg = <0x0 0x3200000 0x0 0x10000>,
> --
> 2.14.1
>
> --
> To unsubscribe from this list: send the line "unsubscribe devicetree" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
