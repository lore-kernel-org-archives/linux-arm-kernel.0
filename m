From: yadi.brar01@gmail.com (Yadwinder Singh Brar)
Date: Fri, 12 Jul 2013 10:57:32 +0530
Subject: [PATCH] clk: samsung: add set_rate and round_rate callbacks for
 pll45xx
In-Reply-To: <CAJuYYwSwNT=ymU72bY8x8PBk=BrVWzMrxGee3kaHOyk3cozv+g@mail.gmail.com>
References: <1373534869-12034-1-git-send-email-thomas.abraham@linaro.org>
 <1395018.H3ijo3R2Tj@thinkpad>
 <CAJuYYwSwNT=ymU72bY8x8PBk=BrVWzMrxGee3kaHOyk3cozv+g@mail.gmail.com>
Message-ID: <CAKew6eXR7Cz80e1ZHTKy7X5mvMN4dgcQQZHgz0wB6J-mTnTFfw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Thomas,

>>> +     /* select a lookup table based on parent clock frequency */
>>> +     switch (*prate) {
>>> +     case 24000000:
>>> +             f = pll45xx_freq_lookup_24mhz;
>>> +             cnt = ARRAY_SIZE(pll45xx_freq_lookup_24mhz);
>>> +             break;
>>> +     default:
>>> +             pr_err("%s: unsupported parent clock rate", __func__);
>>> +             return *prate;
>>> +     }
>>
>> Again, PMS table can be set in register function and just used here.
>
> Ok, but it would be good to give another thought about having the
> lookup table tied to the pll configuration code. If required, we could
> have both options implemented. A pll will have a default PMS lookup
> table here and if a SoC specific table is needed, it can be supplied
> at the time of PLL registration.
>

I agree with this approach.
But I am not sure actually how many SoC can have common  table.

Regards,
Yadwinder
