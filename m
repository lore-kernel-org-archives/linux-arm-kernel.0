From: yadi.brar01@gmail.com (Yadwinder Singh Brar)
Date: Fri, 12 Jul 2013 11:18:55 +0530
Subject: [PATCH] clk: samsung: add set_rate and round_rate callbacks for
 pll45xx
In-Reply-To: <CAJuYYwSwNT=ymU72bY8x8PBk=BrVWzMrxGee3kaHOyk3cozv+g@mail.gmail.com>
References: <1373534869-12034-1-git-send-email-thomas.abraham@linaro.org>
 <1395018.H3ijo3R2Tj@thinkpad>
 <CAJuYYwSwNT=ymU72bY8x8PBk=BrVWzMrxGee3kaHOyk3cozv+g@mail.gmail.com>
Message-ID: <CAKew6eVBtbS1qaaauGOOTj831m-KHK7gyOSTcNQHzvw_vKiTgQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Sorry I missed to state a point in earlier reply..,


>>> +#define PLL45XX_PMS(f, p, m, s)              \
>>> +     {                                       \
>>> +             .target_freq    = f,            \
>>> +             .pdiv           = p,            \
>>> +             .mdiv           = m,            \
>>> +             .sdiv           = s,            \
>>> +     }
>>> +
>>>  enum pll46xx_type {
>>>       pll_4600,
>>>       pll_4650,
>>
>> Basically, I would prefer the way introduced by Yadwinder's and Vikas' patches
>> to be used. We already discussed all the aspects during all the 7 versions of
>> those patches and decided to go with that solution, so for the case of
>> consistency, same should be used for remaining PLLs.
>
> Ok, but could we look at this once more. We could avoid duplication of
> PLL tables if the lookup tables are kept generic. It would be nice to
> get opinions from others as well on this.
>

The rationale behind using common enum type was to use common(generic) set
of clk ops where ever it is possible, to avoid duplication of most of
the code(which
looks mostly common with many PLLs).  For example its done for 35xx & 25xx
and 36xx & 26xx PLLs in that series.

Regards,
Yadwinder
