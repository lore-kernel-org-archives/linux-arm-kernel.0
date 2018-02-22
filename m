From: amelie.delaunay@st.com (Amelie DELAUNAY)
Date: Thu, 22 Feb 2018 15:35:28 +0000
Subject: [PATCH 5/6] ARM: dts: stm32: add joystick support on
 stm32746g-eval
In-Reply-To: <CACRpkdbaFpLNdxZThVTO5V4y8wzekVpXoFJ_6EOOsKCD_h59cA@mail.gmail.com>
References: <1518100057-23234-1-git-send-email-amelie.delaunay@st.com>
 <1518100057-23234-6-git-send-email-amelie.delaunay@st.com>
 <CACRpkdbaFpLNdxZThVTO5V4y8wzekVpXoFJ_6EOOsKCD_h59cA@mail.gmail.com>
Message-ID: <f8d91cc7-66aa-72bf-c1ed-8e95d39388ba@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 02/22/2018 02:52 PM, Linus Walleij wrote:
> Hi Amelie,
> 
> thanks for your patch.
> 
> On Thu, Feb 8, 2018 at 3:27 PM, Amelie Delaunay <amelie.delaunay@st.com> wrote:
> 
>> The joystick on stm32746g-eval uses gpios on MFX gpio expander.
>>
>> Signed-off-by: Amelie Delaunay <amelie.delaunay@st.com>
> (...)
>> +       joystick {
>> +               compatible = "gpio-keys";
>> +               #address-cells = <1>;
>> +               #size-cells = <0>;
>> +               button at 1 {
>> +                       label = "JoySel";
>> +                       linux,code = <KEY_ENTER>;
>> +                       gpios = <&mfxgpio 0 (GPIO_ACTIVE_LOW | GPIO_IN_PUSH_PULL | GPIO_PULL_UP)>;
>> +               };
> 
> As I think this should not all be handled by GPIO, the joystick on
> gpio-keys needs a pin control handle pointing back to pin control
> states on the respective pins in the pin control/GPIO driver,
> where it can set up these properties.
> 
> For the individual lines the pushing and pulling flags should be
> removed.
> 

Sure! I keep this in mind, thanks!

Regards,
Amelie

> Yours,
> Linus Walleij
> 
