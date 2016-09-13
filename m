From: alexandre.torgue@st.com (Alexandre Torgue)
Date: Tue, 13 Sep 2016 14:34:48 +0200
Subject: [PATCH v5 5/9] Documentation: dt-bindings: Add IRQ related
 properties of STM32 pinctrl
In-Reply-To: <CACRpkdbZtNscuJ0bQMYt09ZKACQ0PBG8XMmGo7XnDy5fMGk9_g@mail.gmail.com>
References: <1473432124-6784-1-git-send-email-alexandre.torgue@st.com>
 <1473432124-6784-6-git-send-email-alexandre.torgue@st.com>
 <CACRpkdbZtNscuJ0bQMYt09ZKACQ0PBG8XMmGo7XnDy5fMGk9_g@mail.gmail.com>
Message-ID: <0359b2c7-cda5-b744-7051-4b19af0fcfcd@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Linus,

On 09/13/2016 10:18 AM, Linus Walleij wrote:
> On Fri, Sep 9, 2016 at 4:42 PM, Alexandre TORGUE
> <alexandre.torgue@st.com> wrote:
>
>> Signed-off-by: Maxime Coquelin <mcoquelin.stm32@gmail.com>
>> Acked-by: Rob Herring <robh@kernel.org>
>> Signed-off-by: Alexandre TORGUE <alexandre.torgue@st.com>
>>
>> diff --git a/Documentation/devicetree/bindings/pinctrl/st,stm32-pinctrl.txt b/Documentation/devicetree/bindings/pinctrl/st,stm32-pinctrl.txt
>> index 587bffb..a0eed99 100644
>> --- a/Documentation/devicetree/bindings/pinctrl/st,stm32-pinctrl.txt
>> +++ b/Documentation/devicetree/bindings/pinctrl/st,stm32-pinctrl.txt
>> @@ -14,6 +14,9 @@ Required properies:
>>   - #size-cells : The value of this property must be 1
>>   - ranges      : defines mapping between pin controller node (parent) to
>>     gpio-bank node (children).
>> + - interrupt-parent: phandle of the interrupt parent to which the external
>> +   GPIO interrupts are forwarded to.
>> + - st,syscfg: phandle of the syscfg node used for IRQ mux selection.
>
> Actually this doc is incomplete.
>
> This is a phandle + offset, not just a phandle.
>
> It is a small detail so I don't care much, either send a patch to
> fix up this doc (I have already merged it) or patch the driver
> to not retrieve the offset and instead use
> #define SYSCFG_OFFSET 0x08
> or something...

I'll send a patch for Documentation.
Do I need to wait  this series is officially released (4.9-rc1) or can I 
send it now ?

Regards
Alex

>
> Yours,
> Linus Walleij
>
