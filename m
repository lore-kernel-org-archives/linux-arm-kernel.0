From: yamada.masahiro@socionext.com (Masahiro Yamada)
Date: Sat, 2 Jun 2018 17:00:55 +0900
Subject: [PATCH 1/8] media: uniphier: add DT bindings documentation for
 UniPhier HSC
In-Reply-To: <20180530090946.1635-2-suzuki.katsuhiro@socionext.com>
References: <20180530090946.1635-1-suzuki.katsuhiro@socionext.com>
 <20180530090946.1635-2-suzuki.katsuhiro@socionext.com>
Message-ID: <CAK7LNATG547GFfaghmgaAaFba0BU-Y7kKT1Ba5nHypkrt9xHjw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2018-05-30 18:09 GMT+09:00 Katsuhiro Suzuki <suzuki.katsuhiro@socionext.com>:
> This patch adds DT binding documentation for UniPhier HSC which is
> MPEG2-TS input/output and demux subsystem.
>
> Signed-off-by: Katsuhiro Suzuki <suzuki.katsuhiro@socionext.com>
> ---
>  .../bindings/media/uniphier,hsc.txt           | 38 +++++++++++++++++++
>  1 file changed, 38 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/media/uniphier,hsc.txt
>
> diff --git a/Documentation/devicetree/bindings/media/uniphier,hsc.txt b/Documentation/devicetree/bindings/media/uniphier,hsc.txt


This file name is strange.

A comma should be used a separator between a vendor name and a device name.

The "uniphier" is not a vendor name.


socionext,uniphier-hsc.txt

  or

uniphier-hsc.txt





> new file mode 100644
> index 000000000000..4242483b2ecc
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/media/uniphier,hsc.txt
> @@ -0,0 +1,38 @@
> +Socionext UniPhier HSC (High-speed Stream Controller)
> +
> +The Socionext UniPhier HSC subsystem consists of MPEG2-TS input/output and
> +demultiplexer cores in the same register space.
> +
> +This interface is support TS serial signals (clock, valid, sync, data) from


"is support" -> "supports"


> +external demodulators.
> +
> +Required properties:
> +- compatible      : should be one of the following:
> +                   "socionext,uniphier-ld11-hsc"
> +                   "socionext,uniphier-ld20-hsc"
> +- reg             : offset and length of the register set for the device.
> +- interrupts      : should contain DMA and TSI error interrupt.
> +- pinctrl-names   : should be "default".
> +- pinctrl-0       : defined TS serial signal pins for external demodulators.
> +- clock-names     : should include following entries:
> +                    "hsc", "stdmac"
> +- clocks          : a list of phandle, should contain an entry for each
> +                    entry in clock-names.
> +- reset-names     : should include following entries:
> +                    "hsc", "stdmac"
> +- resets          : a list of phandle, should contain an entry for each
> +                    entry in reset-names.
> +
> +Example:
> +       hsc {
> +               compatible = "socionext,uniphier-ld20-hsc";
> +               reg = <0x5c000000 0x100000>;
> +               interrupts = <0 100 4>, <0 101 4>;
> +               pinctrl-names = "default";
> +               pinctrl-0 = <&pinctrl_hscin2_s>,
> +                           <&pinctrl_hscin3_s>;
> +               clock-names = "stdmac", "hsc";
> +               clocks = <&sys_clk 8>, <&sys_clk 9>;
> +               reset-names = "stdmac", "hsc";
> +               resets = <&sys_rst 8>, <&sys_rst 9>;
> +       };
> --
> 2.17.0
>



-- 
Best Regards
Masahiro Yamada
