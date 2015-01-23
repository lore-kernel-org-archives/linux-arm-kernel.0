From: viresh.kumar@linaro.org (Viresh Kumar)
Date: Fri, 23 Jan 2015 18:23:03 +0530
Subject: [RFC V2] OPP: Redefine bindings to overcome shortcomings
In-Reply-To: <1422013154.29475.11.camel@pengutronix.de>
References: <cbe949d7a69c3b16a3e9d6e5429eb81d3ae9d8b9.1422009157.git.viresh.kumar@linaro.org>
 <1422013154.29475.11.camel@pengutronix.de>
Message-ID: <CAKohpokdKby1_aUDTUDkNkYj3C9F83Hn--w7TS=Y-UE1ZdnW6w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 23 January 2015 at 17:09, Lucas Stach <l.stach@pengutronix.de> wrote:
> Am Freitag, den 23.01.2015, 16:14 +0530 schrieb Viresh Kumar:
>> I haven't incorporated the comments given by Mark Brown as I had some doubts.
>> @broonie: Is this what you wanted to mention earlier ? : http://pastebin.com/1RZTccmm
>>
>
> I think we should work this out for the new bindings, as
> voltage-tolerance is a completely bogus value.

Yeah, that's what I was saying. I just wanted to confirm that I understood
it clearly. And so didn't made the changes here.

>> +  - opp-microvolt: voltage in micro Volts
>
> Each OPP voltage should be defined by the triplet of minimum,
> nominal/typical, maximum. This lets you specify exact tolerances in each
> direction and should cover most use-cases.
>
> IMHO it would make sense to just define opp-microvolt as an array of
> those 3 values, so the DT doesn't get bloated with a lot more
> properties.
>
> A typical value for a CPU could then look like this:
> opp-microvolt = <800000 850000 1100000>
>
> For devices without any tolerance you can just specify the same value
> three times and be done with it:
> opp-microvolt = <900000 900000 900000>

Ok.

>> +  Optional properties:
>> +  - turbo-mode: Marks the volt-freq pair as turbo pair.
>> +  - status: Marks the node enabled/disabled.
>> +  - voltage-tolerance: Specify the CPU voltage tolerance in percentage.
>
> Please let's drop this.

Yes, I did dropped it in the pastebin link I gave above.

Thanks again for your feedback.
