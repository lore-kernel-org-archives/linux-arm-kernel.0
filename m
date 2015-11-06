From: andy.shevchenko@gmail.com (Andy Shevchenko)
Date: Fri, 6 Nov 2015 23:36:44 +0200
Subject: [PATCH 04/10] pwm: core: use bitops
In-Reply-To: <563CBDF5.50904@ultimaker.com>
References: <1445895161-2317-1-git-send-email-o.schinagl@ultimaker.com>
 <1445895161-2317-5-git-send-email-o.schinagl@ultimaker.com>
 <20151106144635.GA8418@ulmo> <563CBDF5.50904@ultimaker.com>
Message-ID: <CAHp75VdCoM5ZtMhwt8emC8GtFEuguEXYWZCJgT4hTBcMA7yQ-A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Nov 6, 2015 at 4:49 PM, Olliver Schinagl
<o.schinagl@ultimaker.com> wrote:
> Hey Thierry,
>
> but why have the bit macro at all then :)

For my opinion, it's good to use in new code, or when you have this
change as a continuation of bigger series.
Though, others might have a different one :-)

>
> But that choice I guess I leave to you, as it's your section, I know some
> submaintainers prefer it and want it to be used, so I guess it's something
> in general kernel wide that should be desided on, BIT() macro preferred or
> not.
>
> Olliver
>
>
> On 06-11-15 15:46, Thierry Reding wrote:
>>
>> On Mon, Oct 26, 2015 at 10:32:35PM +0100, Olliver Schinagl wrote:
>>>
>>> From: Olliver Schinagl <oliver@schinagl.nl>
>>>
>>> The pwm header defines bits manually while there is a nice bitops.h with
>>> a BIT() macro. Use the BIT() macro to set bits in pwm.h
>>>
>>> Signed-off-by: Olliver Schinagl <oliver@schinagl.nl>
>>> ---
>>>   include/linux/pwm.h | 7 ++++---
>>>   1 file changed, 4 insertions(+), 3 deletions(-)
>>
>> I don't think this is a useful change. The BIT() macro needs the same
>> number of characters to type at the expense of requiring an additional
>> include.
>>
>> Thierry
>
>
> --
> Met vriendelijke groeten, Kind regards, ??????
>
> Olliver Schinagl
> Software Engineer
> Research & Development
> Ultimaker B.V.
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/



-- 
With Best Regards,
Andy Shevchenko
