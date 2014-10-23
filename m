From: haojian.zhuang@gmail.com (Haojian Zhuang)
Date: Thu, 23 Oct 2014 17:32:22 +0800
Subject: [PATCH] ARM: dts: hip04: NAND controller support
In-Reply-To: <1414052649-17868-1-git-send-email-wangzhou.bry@gmail.com>
References: <1414052649-17868-1-git-send-email-wangzhou.bry@gmail.com>
Message-ID: <CAN1soZyCojPe8HYQQqrPj7e84TrhTsQpupMqf5semZDn3NabCQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Oct 23, 2014 at 4:24 PM, Zhou Wang <wangzhou.bry@gmail.com> wrote:
> This patch adds dts support of NAND flash controller for Hisilicon Soc Hip04.
> The patch is based on v3.18-rc1. I have tested that NAND flash controller
> works fine in Hip04 D01 board.
>
> Signed-off-by: Zhou Wang <wangzhou.bry@gmail.com>
> ---
>  arch/arm/boot/dts/hip04.dtsi |   30 ++++++++++++++++++++++++++++++
>  1 file changed, 30 insertions(+)
>
> diff --git a/arch/arm/boot/dts/hip04.dtsi b/arch/arm/boot/dts/hip04.dtsi
> index 93b6c90..642a160 100644
> --- a/arch/arm/boot/dts/hip04.dtsi
> +++ b/arch/arm/boot/dts/hip04.dtsi
> @@ -263,5 +263,35 @@
>                         interrupts = <0 372 4>;
>                 };
>
> +               nand: nand at 4020000 {
> +                       compatible = "hisilicon,504-nfc";
> +                       reg = <0x4020000 0x10000>, <0x5000000 0x1000>;
> +                       interrupts = <0 379 4>;
> +                       nand-bus-width = <8>;
> +                       nand-ecc-mode = "none";
> +                       hisi,nand-ecc-bits = <0>;
> +                       #address-cells = <1>;
> +                       #size-cells = <1>;
> +
> +                       partition at 0 {
> +                               label = "nand_text";
> +                               reg = <0x00000000 0x00400000>;
> +                       };
> +
> +                       partition at 00400000 {
> +                               label = "nand_monitor";
> +                               reg = <0x00400000 0x00400000>;
> +                       };
> +
> +                       partition at 00800000 {
> +                               label = "nand_kernel";
> +                               reg = <0x00800000 0x00800000>;
> +                       };
> +
> +                       partition at 01000000 {
> +                               label = "nand_fs";
> +                               reg = <0x01000000 0x1f000000>;
> +                       };

Partitions are different on different boards. But nand controller is
same on each chip. You
should define nand controller in soc dtsi file, and define partition
in board dts file.

Regards
Haojian
