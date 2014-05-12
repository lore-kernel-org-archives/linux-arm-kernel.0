From: wens@csie.org (Chen-Yu Tsai)
Date: Mon, 12 May 2014 16:55:51 +0800
Subject: [linux-sunxi] Re: [PATCH v4 01/03] ARM: sunxi: Add documentation
 for sunxi consumer infrared devices
In-Reply-To: <6a8ffca8-d586-46f6-96e5-4e132ba0f368@googlegroups.com>
References: <d641a69a-01b4-443d-b121-48d13f46ee03@googlegroups.com>
 <6a8ffca8-d586-46f6-96e5-4e132ba0f368@googlegroups.com>
Message-ID: <CAGb2v66OgDgznWF5_2Yoiy_zb2_YNV-REsfhZ3QqBN-tkOJpZQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Wed, Apr 30, 2014 at 6:54 PM, ????????? ???????? <bay@hackerdom.ru> wrote:
> [PATCH v4 01/03] ARM: sunxi: Add documentation for sunxi consumer infrared
> devices
>
> This patch adds documentation for Device-Tree bindings for sunxi IR
> controller.
>
> Signed-off-by: Alexander Bersenev <bay@hackerdom.ru>
> Signed-off-by: Alexsey Shestacov <wingrime@linux-sunxi.org>
>
> diff --git a/Documentation/devicetree/bindings/media/sunxi-ir.txt
> b/Documentation/devicetree/bindings/media/sunxi-ir.txt
> new file mode 100644
> index 0000000..d502cf4
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/media/sunxi-ir.txt
> @@ -0,0 +1,23 @@
> +Device-Tree bindings for SUNXI IR controller found in sunXi SoC family
> +
> +Required properties:
> +- compatible    : should be "allwinner,sun7i-a20-ir";
> +- clocks    : list of clock specifiers, corresponding to
> +      entries in clock-names property;
> +- clock-names    : should contain "apb0_ir0" and "ir0" entries;
> +- interrupts    : should contain IR IRQ number;
> +- reg    : should contain IO map address for IR.
> +
> +Optional properties:
> +- linux,rc-map-name : Remote control map name.
> +
> +Example:
> +
> +ir0: ir at 01c21800 {
> +       compatible = "allwinner,sun7i-a20-ir";
> +       clocks = <&apb0_gates 6>, <&ir0_clk>;
> +       clock-names = "apb0_ir0", "ir0";
> +       interrupts = <0 5 1>;
> +       reg = <0x01C21800 0x40>;
> +       linux,rc-map-name = "rc-rc6-mce";

You seem to be mixing spaces and tabs here, with spaces in front.
(Gmail messed this up. See the original post.)
Please stick to using tabs first, and spaces for alignment.


ChenYu

> +};
>
>
> ?????, 30 ?????? 2014 ?., 16:51:12 UTC+6 ???????????? ????????? ????????
> ???????:
>>
>> This patch introduces Consumer IR(CIR) support for sunxi boards.
>>
>> This is based on Alexsey Shestacov's work based on the original driver
>> supplied by Allwinner.
