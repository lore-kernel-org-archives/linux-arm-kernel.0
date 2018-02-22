From: amelie.delaunay@st.com (Amelie DELAUNAY)
Date: Thu, 22 Feb 2018 15:34:28 +0000
Subject: [PATCH 4/6] ARM: dts: stm32: add MFX support on I2C1 on
 stm32746g-eval
In-Reply-To: <CACRpkdZFrRXEBW6KnqZ=h_7BxYn-RaAzhP4ovwC_DQSbAGZCVw@mail.gmail.com>
References: <1518100057-23234-1-git-send-email-amelie.delaunay@st.com>
 <1518100057-23234-5-git-send-email-amelie.delaunay@st.com>
 <CACRpkdZFrRXEBW6KnqZ=h_7BxYn-RaAzhP4ovwC_DQSbAGZCVw@mail.gmail.com>
Message-ID: <9d66c639-7f3e-86f3-e744-237b4be31d09@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 02/22/2018 02:54 PM, Linus Walleij wrote:
> On Thu, Feb 8, 2018 at 3:27 PM, Amelie Delaunay <amelie.delaunay@st.com> wrote:
> 
>> MFX is used as gpio expander on stm32746g-eval.
>>
>> Signed-off-by: Amelie Delaunay <amelie.delaunay@st.com>
> 
> (...)
>> +       mfx: mfx at 42 {
>> +               compatible = "st,mfx";
>> +               reg = <0x42>;
>> +               interrupts = <8 1>;
>> +               interrupt-parent = <&gpioi>;
>> +               interrupt-controller;
>> +               #interrupt-cells = <1>;
>> +
>> +               mfxgpio: mfx_gpio {
>> +                       compatible = "st,mfx-gpio";
>> +                       interrupts = <0>;
>> +                       interrupt-parent = <&mfx>;
>> +                       gpio-controller;
>> +                       #gpio-cells = <2>;
> 
> So I think this node should contain some pin config states
> that can  be referenced by the drivers to set up push/pull
> etc. Probably it can use just standard pin config properties
> like sx150x.
> 

I will check that point.

Regards,
Amelie

> Yours,
> Linus Walleij
> 
