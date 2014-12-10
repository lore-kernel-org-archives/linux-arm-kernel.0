From: matthias.bgg@gmail.com (Matthias Brugger)
Date: Wed, 10 Dec 2014 15:50:57 +0100
Subject: [PATCH 3/4] arm64: dts: Add mediatek MT8173 SoC and evaluation
 board dts and Makefile
In-Reply-To: <1418221662.21309.13.camel@mtksdaap41>
References: <1418208602-35584-1-git-send-email-eddie.huang@mediatek.com>
 <1418208602-35584-4-git-send-email-eddie.huang@mediatek.com>
 <1418221662.21309.13.camel@mtksdaap41>
Message-ID: <CABuKBe+U22ogGBToftgaSJw6fcJmciGfa9scAkyP3g5OJSaAOA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2014-12-10 15:27 GMT+01:00 Yingjoe Chen <yingjoe.chen@mediatek.com>:
>
> Hi,
>
> On Wed, 2014-12-10 at 18:50 +0800, Eddie Huang wrote:
> <...>
>> diff --git a/arch/arm64/boot/dts/mt8173-evb.dts b/arch/arm64/boot/dts/mt8173-evb.dts
>> new file mode 100644
>> index 0000000..adf26dd
>> --- /dev/null
>> +++ b/arch/arm64/boot/dts/mt8173-evb.dts
> <...>
>> +     timer {
>> +             compatible = "arm,armv8-timer";
>> +             interrupt-parent = <&gic>;
>> +             interrupts = <1 13 0x8>,
>> +                          <1 14 0x8>,
>> +                          <1 11 0x8>,
>> +                          <1 10 0x8>;
>> +             clock-frequency = <13000000>;
>
> I believe our firmware doesn't need this line. Please remove it.

The point here would be to know if you need to enable a special timer
from the mtk-timer block to get the arch timer working.
In any case, you will need some sort of timer. This dts does not
describe the mtk-timer (may in the mt8173 it does not exist) but
defines the clocks clk26m and clk32k. So if you don't use the
mtk-timer, please remove the clocks as there isn't a block using them.

Thanks,
Matthias

>
> Joe.C
>
>



-- 
motzblog.wordpress.com
