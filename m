From: yamada.masahiro@socionext.com (Masahiro Yamada)
Date: Wed, 29 Nov 2017 12:44:22 +0900
Subject: [PATCH] dt-bindings: pinctrl: uniphier: add UniPhier pinctrl
 binding
In-Reply-To: <20171128152706.pg3tndrrne3nhduy@rob-hp-laptop>
References: <1511855386-10421-1-git-send-email-yamada.masahiro@socionext.com>
 <20171128152706.pg3tndrrne3nhduy@rob-hp-laptop>
Message-ID: <CAK7LNAQYBe=x8sOBTrz8zE+5JEhOu+3eQKd8fbSAxi9Zuy18jQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Rob,


2017-11-29 0:27 GMT+09:00 Rob Herring <robh@kernel.org>:
> On Tue, Nov 28, 2017 at 04:49:45PM +0900, Masahiro Yamada wrote:
>> The driver has been in the tree for a while, but its binding document
>> is missing.  Hence, here it is.
>>
>> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
>> ---
>>
>>  .../pinctrl/socionext,uniphier-pinctrl.txt         | 27 ++++++++++++++++++++++
>>  MAINTAINERS                                        |  1 +
>>  2 files changed, 28 insertions(+)
>>  create mode 100644 Documentation/devicetree/bindings/pinctrl/socionext,uniphier-pinctrl.txt
>>
>> diff --git a/Documentation/devicetree/bindings/pinctrl/socionext,uniphier-pinctrl.txt b/Documentation/devicetree/bindings/pinctrl/socionext,uniphier-pinctrl.txt
>> new file mode 100644
>> index 0000000..8173b12
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/pinctrl/socionext,uniphier-pinctrl.txt
>> @@ -0,0 +1,27 @@
>> +UniPhier SoCs pin controller
>> +
>> +Required properties:
>> +- compatible: should be one of the following:
>> +    "socionext,uniphier-ld4-pinctrl"  - for LD4 SoC
>> +    "socionext,uniphier-pro4-pinctrl" - for Pro4 SoC
>> +    "socionext,uniphier-sld8-pinctrl" - for sLD8 SoC
>> +    "socionext,uniphier-pro5-pinctrl" - for Pro5 SoC
>> +    "socionext,uniphier-pxs2-pinctrl" - for PXs2 SoC
>> +    "socionext,uniphier-ld6b-pinctrl" - for LD6b SoC
>> +    "socionext,uniphier-ld11-pinctrl" - for LD11 SoC
>> +    "socionext,uniphier-ld20-pinctrl" - for LD20 SoC
>> +    "socionext,uniphier-pxs3-pinctrl" - for PXs3 SoC
>> +
>> +Note:
>> +The UniPhier pinctrl should be a subnode of a "syscon" compatible node.
>> +
>> +Example:
>> +     soc-glue at 5f800000 {
>> +             compatible = "socionext,uniphier-pro4-soc-glue",
>> +                          "simple-mfd", "syscon";
>> +             reg = <0x5f800000 0x2000>;
>> +
>> +             pinctrl: pinctrl {
>> +                     compatible = "socionext,uniphier-pro4-pinctrl";
>
> There's not a contiguous register range that can be put here?


Right.

I saw SATA PHY registers are inserted among the pinctrl registers.

Hardware engineers often make crazy design.





>> +             };
>> +     };
>> diff --git a/MAINTAINERS b/MAINTAINERS
>> index aa71ab52f..38b0ddc 100644
>> --- a/MAINTAINERS
>> +++ b/MAINTAINERS
>> @@ -2042,6 +2042,7 @@ L:      linux-arm-kernel at lists.infradead.org (moderated for non-subscribers)
>>  T:   git git://git.kernel.org/pub/scm/linux/kernel/git/masahiroy/linux-uniphier.git
>>  S:   Maintained
>>  F:   Documentation/devicetree/bindings/gpio/gpio-uniphier.txt
>> +F:   Documentation/devicetree/bindings/pinctrl/socionext,uniphier-pinctrl.txt
>>  F:   arch/arm/boot/dts/uniphier*
>>  F:   arch/arm/include/asm/hardware/cache-uniphier.h
>>  F:   arch/arm/mach-uniphier/
>> --
>> 2.7.4
>>
>>
>> _______________________________________________
>> linux-arm-kernel mailing list
>> linux-arm-kernel at lists.infradead.org
>> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
> --
> To unsubscribe from this list: send the line "unsubscribe linux-gpio" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html



-- 
Best Regards
Masahiro Yamada
