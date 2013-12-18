From: syin@broadcom.com (Sherman Yin)
Date: Tue, 17 Dec 2013 18:02:07 -0800
Subject: [PATCH v3 4/6] pinctrl: Add pinctrl binding for Broadcom Capri
 SoCs
In-Reply-To: <CACRpkdZ5Cxii48CsVJzEaBhvZOs8JCcR_hJV=RczhHbW4aqG-w@mail.gmail.com>
References: <1381174108-25168-1-git-send-email-syin@broadcom.com>	<1386787041-6035-1-git-send-email-syin@broadcom.com>	<1386787041-6035-5-git-send-email-syin@broadcom.com>	<CACRpkdY7s+eUFkg0AsaN5B9-1y_mTJ29Y-D9CkRG2GQ3JshP+w@mail.gmail.com>	<52ABB150.1030702@broadcom.com>
 <CACRpkdZ5Cxii48CsVJzEaBhvZOs8JCcR_hJV=RczhHbW4aqG-w@mail.gmail.com>
Message-ID: <52B1021F.2010708@broadcom.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 13-12-16 05:17 AM, Linus Walleij wrote:
> On Sat, Dec 14, 2013 at 2:16 AM, Sherman Yin <syin@broadcom.com> wrote:
>
>>>> +- bias-pull-up:                        Integer. Pull up strength in Ohm:
>>>> +                                       1: 1.2 kOhm
>>>> +                                       2: 1.8 kOhm
>>>> +                                       3: 720 Ohm
>>>> +                                       4: 2.7 kOhm
>>>> +                                       5: 831 Ohm
>>>> +                                       6: 1.08 kOhm
>>>> +                                       7: 568 Ohm
>>>
>>>
>>> Please do not use these custom enumerators 1 thru 7.
>>> Instead say that the argument is given in ohms, so for
>>> example:
>>>
>>> bias-pull-up = <12000>;
>>>
>>> Then translate this into the proper enumerator in your
>>> driver instead.
>>
>> Ok.  The 3 bits in this enumeration correspond to enabling the 3 pull up Rs
>> (1.2k, 1.8k, 2.7k) in parallel, so the enum kind of make sense. But sure I
>> can change it to actual ohms and will error out in the driver if specified
>> value is not one of the 7.
>
> Aha, that's how they do it :-)
>
> Please write this in a comment in the driver because it makes
> it a lot easier to understand what is going on, and e.g. how to
> fuzz an apropriate resistance.

Yes, I plan to explain where those odd numbers come from in this file.

> Can you tell me something about how such resistors are produced
> in silicon?

Sorry I'm not quite sure.  I only know a little bit of the circuitry 
down to the schematic level...

Regards,
Sherman
