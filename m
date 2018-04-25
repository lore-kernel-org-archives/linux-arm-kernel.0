From: alexandre.torgue@st.com (Alexandre Torgue)
Date: Wed, 25 Apr 2018 18:22:03 +0200
Subject: [PATCH 3/8] ARM: dts: stm32: add ethernet pins to stm32mp157c
In-Reply-To: <CAL_JsqL7bY=OSuzeVHH2UxxaBmCMzpFc8djnuZAY6VWcTgUmZw@mail.gmail.com>
References: <1524582120-4451-1-git-send-email-christophe.roullier@st.com>
 <1524582120-4451-4-git-send-email-christophe.roullier@st.com>
 <CAL_JsqL7bY=OSuzeVHH2UxxaBmCMzpFc8djnuZAY6VWcTgUmZw@mail.gmail.com>
Message-ID: <3b41ed0c-836b-6105-f625-d97e4512d0b2@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Rob,

On 04/25/2018 05:09 PM, Rob Herring wrote:
> On Tue, Apr 24, 2018 at 10:01 AM, Christophe Roullier
> <christophe.roullier@st.com> wrote:
>> Add ethernet pins on stm32mp157c.
>>
>> Signed-off-by: Christophe Roullier <christophe.roullier@st.com>
>> ---
>>   arch/arm/boot/dts/stm32mp157-pinctrl.dtsi | 46 +++++++++++++++++++++++++++++++
>>   1 file changed, 46 insertions(+)
>>
>> diff --git a/arch/arm/boot/dts/stm32mp157-pinctrl.dtsi b/arch/arm/boot/dts/stm32mp157-pinctrl.dtsi
>> index 6f044100..86720a5 100644
>> --- a/arch/arm/boot/dts/stm32mp157-pinctrl.dtsi
>> +++ b/arch/arm/boot/dts/stm32mp157-pinctrl.dtsi
>> @@ -158,6 +158,52 @@
>>                                          bias-disable;
>>                                  };
>>                          };
>> +
>> +                       ethernet0_rgmii_pins_a: rgmii at 0 {
> 
> A unit-address without 'reg' property is not valid, so drop the '@0'.
>
Thanks for the highlights. We could replace rgmii at 0 by rgmii-0.
If no objections, I will send a series to update all STM32 device tree 
files (MCUs legacy). I will take care about it for future STM32 DT review.

Thanks
Alex

> Please build your dtb with W=1 or W=12 which will tell you this and
> other errors.
> 

> Rob
> 
