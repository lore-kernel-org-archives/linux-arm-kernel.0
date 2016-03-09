From: yamada.masahiro@socionext.com (Masahiro Yamada)
Date: Wed, 9 Mar 2016 13:32:12 +0900
Subject: [PATCH v2] ARM: dts: add "simple-bus" where "arm,amba-bus" is
 used alone
In-Reply-To: <CAL_JsqJvT+4efH-+_EhehzwhHZsrYTX8pa1NLsg_Wn4YReN4Ag@mail.gmail.com>
References: <1457415977-3401-1-git-send-email-yamada.masahiro@socionext.com>
 <CAL_JsqJvT+4efH-+_EhehzwhHZsrYTX8pa1NLsg_Wn4YReN4Ag@mail.gmail.com>
Message-ID: <CAK7LNARcnsgqzsRFStUiWsFQZG8GiJRbxARDbtd51+RaVs97pQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Rob,


2016-03-08 17:49 GMT+09:00 Rob Herring <robh+dt@kernel.org>:
> On Mon, Mar 7, 2016 at 11:46 PM, Masahiro Yamada
> <yamada.masahiro@socionext.com> wrote:
>> The compatible string "simple-bus" is well defined in ePAPR, while
>> I see no documentation for the "arm,amba-bus" in ePAPR or under
>> Documentation/devicetree/.
>>
>> DT is also used by other projects than Linux kernel.  It is not a
>> good idea to rely on such an unofficial binding.
>>
>> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
>> ---
>>
>> Changes in v2:
>>   - Rephrase the git-log
>
> [...]
>
>> diff --git a/arch/arm/boot/dts/axm55xx.dtsi b/arch/arm/boot/dts/axm55xx.dtsi
>> index ea288f0..8da4582 100644
>> --- a/arch/arm/boot/dts/axm55xx.dtsi
>> +++ b/arch/arm/boot/dts/axm55xx.dtsi
>> @@ -107,7 +107,7 @@
>>                 };
>>
>>                 amba {
>> -                       compatible = "arm,amba-bus";
>> +                       compatible = "arm,amba-bus", "simple-bus";
>
> As I mentioned in the last version, I think you should remove
> arm,amba-bus and just have simple-bus. I don't believe anything relies
> on having arm,amba-bus.

Sorry about this.

V3 is here now:
https://patchwork.kernel.org/patch/8542031/




-- 
Best Regards
Masahiro Yamada
