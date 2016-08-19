From: yamada.masahiro@socionext.com (Masahiro Yamada)
Date: Sat, 20 Aug 2016 02:55:12 +0900
Subject: [PATCH v6 2/2] clk: uniphier: add clock data for UniPhier SoCs
In-Reply-To: <20160819002826.GT361@codeaurora.org>
References: <1470112223-24835-1-git-send-email-yamada.masahiro@socionext.com>
 <1470112223-24835-3-git-send-email-yamada.masahiro@socionext.com>
 <20160819002826.GT361@codeaurora.org>
Message-ID: <CAK7LNAROCdE4tomp6jg4p5Ep-koPjWSchNEXH01Qn0Wn3q-f2g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Stephen,


2016-08-19 9:28 GMT+09:00 Stephen Boyd <sboyd@codeaurora.org>:

>> +
>> +
>> +System clock
>> +------------
>> +
>> +Required properties:
>> +- compatible: should be one of the following:
>> +    "socionext,uniphier-sld3-clock" - for PH1-sLD3 SoC.
>> +    "socionext,uniphier-ld4-clock"  - for PH1-LD4 SoC.
>> +    "socionext,uniphier-pro4-clock" - for PH1-Pro4 SoC.
>> +    "socionext,uniphier-sld8-clock" - for PH1-sLD8 SoC.
>> +    "socionext,uniphier-pro5-clock" - for PH1-Pro5 SoC.
>> +    "socionext,uniphier-pxs2-clock" - for ProXstream2/PH1-LD6b SoC.
>> +    "socionext,uniphier-ld11-clock" - for PH1-LD11 SoC.
>> +    "socionext,uniphier-ld20-clock" - for PH1-LD20 SoC.
>> +- #clock-cells: should be 1.
>> +
>> +Example:
>> +
>> +     sysctrl at 61840000 {
>> +             compatible = "socionext,uniphier-ld20-sysctrl",
>> +                          "simple-mfd", "syscon";
>> +             reg = <0x61840000 0x4000>;
>> +
>> +             clock {
>> +                     compatible = "socionext,uniphier-ld20-clock";
>> +                     #clock-cells = <1>;
>> +             };
>> +
>> +             other nodes ...
>
> What are the other nodes? Is there a document for the rest of the
> MFD?

At lease there are "clock" and "reset" in this MFD at this point.
Perhaps, I may want to add more in the future.

That's why I do not want to list all of the sibling nodes.

The reset node is documented in its binding document,
added by the following patch:
https://patchwork.kernel.org/patch/9255101/


-- 
Best Regards
Masahiro Yamada
