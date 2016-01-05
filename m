From: andre.przywara@arm.com (Andre Przywara)
Date: Tue, 5 Jan 2016 12:00:11 +0000
Subject: [linux-sunxi] [RFC PATCH] drivers: pinctrl: add driver for
 Allwinner A64 SoC
In-Reply-To: <20160104203059.GG11722@lukather>
References: <1451582246-32373-1-git-send-email-andre.przywara@arm.com>
 <CAEzqOZsE_kDChAbLkwmwjqdDbovv1e0G1tTffhhp25PkwJQ0+Q@mail.gmail.com>
 <568A4972.8030602@arm.com> <20160104203059.GG11722@lukather>
Message-ID: <568BB04B.30100@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Maxime,

On 04/01/16 20:30, Maxime Ripard wrote:
> Hi Andre,
> 
> On Mon, Jan 04, 2016 at 10:29:06AM +0000, Andre Przywara wrote:
>>>> diff --git a/drivers/pinctrl/sunxi/Makefile b/drivers/pinctrl/sunxi/Makefile
>>>> index e080290..130e7bc 100644
>>>> --- a/drivers/pinctrl/sunxi/Makefile
>>>> +++ b/drivers/pinctrl/sunxi/Makefile
>>>> @@ -12,5 +12,6 @@ obj-$(CONFIG_PINCTRL_SUN7I_A20)               += pinctrl-sun7i-a20.o
>>>>  obj-$(CONFIG_PINCTRL_SUN8I_A23)                += pinctrl-sun8i-a23.o
>>>>  obj-$(CONFIG_PINCTRL_SUN8I_A23_R)      += pinctrl-sun8i-a23-r.o
>>>>  obj-$(CONFIG_PINCTRL_SUN8I_A33)                += pinctrl-sun8i-a33.o
>>>> +obj-$(CONFIG_PINCTRL_A64)              += pinctrl-a64.o
>>>
>>> Shouldn't this follow pinctrl config name like other sunXi SOCs?
>>> This should be PINCTRL_SUN??_A64.
>>
>> I never really got the reason we use those sunxi names in addition to
>> the SoC name in the first place, maybe apart from copying from some
>> Allwinner code.
>> Since I decided to not look at Allwinner's BSP at all (if avoidable), I
>> also thought it would be time to drop that sunxi naming, which looks
>> redundant to me.
>> Is there any reason why we would need this (beside having a rather
>> unique identifier prefix)?
> 
> It's mostly historical.
> 
> 
> Back when we started this, There was a few SoCs already out: A10,
> A10s, A12 and A13, which was very similar to the Cortex-A naming
> scheme (and I think the Cortex-A12 was also announced at the time).
> 
> We couldn't really use the SoC family either, since there was already
> multiple SoCs that were part of the same family (the A10s, A12 and
> A13, part of the sun5i family).
> 
> In order to avoid any confusion, we chose to go with both to uniquely
> and without any confusion possible, and we just went on with that
> naming scheme for consistency.

I see, thanks for the explanation.
I was wondering since we now move to a new architecture as well to avoid
this historic "ballast", but I have no problems with adding "_sun50i_"
to the identifiers and file names.
To me as only a casual sunxi user I found it mostly hard to memorize the
connections between the sunxi numbering and the SoC names (I just know
that the A20 is sun7i ;-). So for finding a specific dts for instance,
you have to start with the sunxi number to get it TAB completed ...

With that being said: Would you prefer to have a sun50i prefix? I see
that having just "a64" on itself is not very specific.

Please let me know so that I can amend the code for the next post.

Cheers,
Andre.
