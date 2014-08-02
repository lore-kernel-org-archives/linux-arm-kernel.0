From: dianders@chromium.org (Doug Anderson)
Date: Fri, 1 Aug 2014 22:15:45 -0700
Subject: [PATCH v4 4/4] ARM: dts: Add exynos5250-spring device tree
In-Reply-To: <53DA9BA9.60808@gmail.com>
References: <1406822910-6255-1-git-send-email-afaerber@suse.de>
 <1406822910-6255-5-git-send-email-afaerber@suse.de>
 <53DA936E.9060004@gmail.com> <53DA9709.10602@suse.de>
 <53DA9BA9.60808@gmail.com>
Message-ID: <CAD=FV=XVM4FUMxjindZGXku5DZ1MkTWq=Smmt_Fs7=_i4MBFKw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Tomasz,

On Thu, Jul 31, 2014 at 12:40 PM, Tomasz Figa <tomasz.figa@gmail.com> wrote:
> Andreas,
>
> On 31.07.2014 21:20, Andreas F?rber wrote:
>> Am 31.07.2014 21:05, schrieb Tomasz Figa:
>>> On 31.07.2014 18:08, Andreas F?rber wrote:
>>>> Adds initial support for the HP Chromebook 11.
>>>
>>> [snip]
>>>
>>>> +   gpio-keys {
>>>> +           compatible = "gpio-keys";
>>>> +           pinctrl-names = "default";
>>>> +           pinctrl-0 = <&power_key_irq>, <&lid_irq>;
>>>> +
>>>> +           power {
>>>> +                   label = "Power";
>>>> +                   gpios = <&gpx1 3 GPIO_ACTIVE_LOW>;
>>>> +                   linux,code = <KEY_POWER>;
>>>
>>> I assume the key is debounced in hardware, so there is no need for
>>> debounce-interval here. Is this correct?
>>
>> You're asking the wrong person... This is copied from
>> -cros-common/-snow. Downstream 3.8 does not have a debounce-interval
>> property.
>
> Doug, Vincent?

Not something I've looked at, but it's never been a problem...


>>>> +&sd1_clk {
>>>> +   samsung,pin-drv = <0>;
>>>> +};
>>>> +
>>>> +&sd1_cmd {
>>>> +   samsung,pin-pud = <3>;
>>>> +   samsung,pin-drv = <0>;
>>>> +};
>>>> +
>>>> +&sd1_cd {
>>>> +   samsung,pin-drv = <0>;
>>>> +};
>>>> +
>>>> +&sd1_bus4 {
>>>> +   samsung,pin-drv = <0>;
>>>> +};
>>>
>>> Here generic settings are being overridden, so it might be a good idea
>>> to explain why, like with i2c pull-up above.
>>
>> Snow does not have an explanation either, so please suggest what comment
>> you'd like to see. Consider me just a user with no specs. :)
>
> Doug, Vincent, someone else?

The comment is just in a different place--it's in the dw_mmc node.
Probably belongs here, though:

                /*
                 * Wifi is a SiP, so can keep drive strengths low
                 * to reduce EMI.
                 */

I guess the cmd line isn't documented.  There is no external pull on
the command line and on most boards there is one.  Our hardware guys
thought we didn't need it and apparently we don't...
