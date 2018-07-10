From: yixun.lan@amlogic.com (Yixun Lan)
Date: Tue, 10 Jul 2018 09:26:10 +0800
Subject: [PATCH 0/3] pinctrl: meson-g12a: add pinctrl driver support
In-Reply-To: <CAFBinCCZzvn5XNiPHhYK+BxGw6J7KJxEuSXF9ZeT8cFi84FjRQ@mail.gmail.com>
References: <20180704224511.29350-1-yixun.lan@amlogic.com>
 <78da7e13-e80b-d714-86d0-7c5f6fc0d9f5@baylibre.com>
 <886462fa-1833-a99a-a2fa-5b7dd58341fd@amlogic.com>
 <CAFBinCCZzvn5XNiPHhYK+BxGw6J7KJxEuSXF9ZeT8cFi84FjRQ@mail.gmail.com>
Message-ID: <9fa17a38-236f-1d83-97fa-beb06046f023@amlogic.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

HI Martin:
 thanks for your suggestion

On 07/10/18 06:02, Martin Blumenstingl wrote:
> Hi Yixun,
> 
> On Thu, Jul 5, 2018 at 4:53 AM Yixun Lan <yixun.lan@amlogic.com> wrote:
>>
>> HI Neil
>>
>> On 07/04/18 22:57, Neil Armstrong wrote:
>>> Hi Yixun,
>>>
>>> On 05/07/2018 00:45, Yixun Lan wrote:
>>>> This patch series try to add pinctrl driver support for
>>>> the Meson-G12A SoC.
>>>
>>> Thanks for submitting these patches.
>>>
>>> Can you explicit this patchset with more details on the G12A SoC family ?
>>> It's relationship with AXG and the differences in term of pinmuxing with the other SoC families ?
>>>
>> I thought this was already discussed while we doing pinctrl driver for
>> Meson-AXG SoC.
>>
>> Anyway, here it is:
>>
>> Starting from Meson-AXG SoC, the pinctrl controller block using 4
>> continues bit to specific pin mux function, while comparing to old
>> generation SoC which kind of using various length bits for the pin mux
>> definition. The new design would greatly simplify the software model..
>>
>> for detail example, one 32bit register can describe 8 pins, and each of
>> them has 0-7 value to set, start from value 0 to 7.
>>
>> partition the register into 8 parts:
>> bit[3:0]
>> bit[7:4]
>> bit[11:8]
>> bit[15:12]
>> bit[19:16]
>> bit[23:20]
>> bit[27:24]
>> bit[31:28]
>>
>>
>> for each value:
>> value == 0, means the pin is GPIO
>> value = {1, 2, ... 7 } is one of specific PIN function
> OK, so AXG and G12A use the same register layout -> thus the same
> pinmux ops are re-used
> 
Yes
> 
> 
>> I could put this info into cover-letter or commit message?
> if you have to resend this series anyways then it would be great if
> you could add it to the commit description
> 
sure

>>> Why is there a GPIOE bank within the AO controller ?
>>>
>>
>> It actually sit in the AO domain, although it's sounds strange from the
>> naming..
>>
>> I'm not sure if it's good idea to append a AO suffix? since the
>> documentation just use the plain GPIOE
> I am fine with plain GPIOE if that's what your internal documentation uses
> it would be great if you could add a comment (or at least a note in
> the commit message) indicating that this is how the hardware is
> designed (initially I thought this was a bug since I have no
> documentation for the G12A chipset)

I can add a comment
> 
> Regards
> Martin
> 
> .
> 
