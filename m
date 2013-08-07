From: richard.genoud@gmail.com (Richard Genoud)
Date: Wed, 7 Aug 2013 12:59:12 +0200
Subject: [PATCH] ARM: at91/dt: split sam9x5 peripheral definitions
In-Reply-To: <52022797.3060006@overkiz.com>
References: <1375870466-1093-1-git-send-email-b.brezillon@overkiz.com>
 <CACQ1gAjsPvHkpUuO_3jK3HfnDBQDoJmO7z1Gj5YkAmybHB_zmg@mail.gmail.com>
 <52022797.3060006@overkiz.com>
Message-ID: <CACQ1gAh3L4cA16BJxCK8ABk4zAmFKzVS=4PH966FUxQUs13+uA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2013/8/7 boris brezillon <b.brezillon@overkiz.com>:
> Hello Richard,
>
>
> On 07/08/2013 12:38, Richard Genoud wrote:
>>
>> 2013/8/7 Boris BREZILLON <b.brezillon@overkiz.com>:
>>>
>>> This patch splits the sam9x5 peripheral definitions into:
>>> - a common base for all sam9x5 SoCs (at91sam9x5.dtsi)
>>> - several optional peripheral definitions which will be included by
>>> specific
>>>    sam9x5 SoCs (at91sam9x5_'periph name'.dtsi)
>>>
>>> This provides a better representation of the real hardware (drop unneeded
>>> dt nodes) and avoids future peripheral id conflict (lcdc and isi both use
>>> peripheral id 25).
>>>
>>> Signed-off-by: Boris BREZILLON <b.brezillon@overkiz.com>
>>> ---
>>>   arch/arm/boot/dts/at91sam9g25.dtsi       |    2 +
>>>   arch/arm/boot/dts/at91sam9g35.dtsi       |    1 +
>>>   arch/arm/boot/dts/at91sam9x25.dtsi       |   24 ++---------
>>>   arch/arm/boot/dts/at91sam9x35.dtsi       |    1 +
>>>   arch/arm/boot/dts/at91sam9x5.dtsi        |   67
>>> ------------------------------
>>>   arch/arm/boot/dts/at91sam9x5_macb0.dtsi  |   56
>>> +++++++++++++++++++++++++
>>>   arch/arm/boot/dts/at91sam9x5_macb1.dtsi  |   44 ++++++++++++++++++++
>>>   arch/arm/boot/dts/at91sam9x5_usart3.dtsi |   51 +++++++++++++++++++++++
>>>   8 files changed, 158 insertions(+), 88 deletions(-)
>>>   create mode 100644 arch/arm/boot/dts/at91sam9x5_macb0.dtsi
>>>   create mode 100644 arch/arm/boot/dts/at91sam9x5_macb1.dtsi
>>>   create mode 100644 arch/arm/boot/dts/at91sam9x5_usart3.dtsi
>>>
>> [snip]
>>>
>>> diff --git a/arch/arm/boot/dts/at91sam9x5_usart3.dtsi
>>> b/arch/arm/boot/dts/at91sam9x5_usart3.dtsi
>>> new file mode 100644
>>> index 0000000..5589579
>>> --- /dev/null
>>> +++ b/arch/arm/boot/dts/at91sam9x5_usart3.dtsi
>>> @@ -0,0 +1,51 @@
>>> +/*
>>> + * at91sam9x5_lcdc.dtsi - Device Tree Include file for AT91SAM9x5 SoC
>>> with
>>> + * 4 USART.
>>
>> One minor comment mistake here !
>
> Nice catch!
>
> I'll fix it for the next version.
>
> BTW did you test it (I didn't: I don't have any board with this SoC family)
> ?
Not yet, will do it !

> This separation was formerly done in the "at91 common clk" series but I
> removed it
> from the new version (which I will submit soon) to ease the review and
> tests.
>
ok !

Thanks,
Richard
