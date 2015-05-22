From: robherring2@gmail.com (Rob Herring)
Date: Fri, 22 May 2015 10:55:34 -0500
Subject: [PATCH V5 1/3] OPP: Redefine bindings to overcome shortcomings
In-Reply-To: <20150521054602.GE22904@linux>
References: <cover.1432091956.git.viresh.kumar@linaro.org>
 <51a2603050f7993643fea9e5dcd2dba7a5a3fe23.1432091956.git.viresh.kumar@linaro.org>
 <555D6CC8.9050201@ti.com> <20150521054602.GE22904@linux>
Message-ID: <CAL_JsqKhpyLgh5_1jZ_u0OP7=Piw=pgqZdQJ0K4Rm7DQ5ve+gA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, May 21, 2015 at 12:46 AM, Viresh Kumar <viresh.kumar@linaro.org> wrote:
> On 21-05-15, 00:27, Nishanth Menon wrote:
>> > +This describes the OPPs belonging to a device. This node can have following
>> > +properties:

[...]

>> different angle: How about just target-freq-Hz? just drop the "opp"
>> prefix for properties of an OPP node? No strong feelings here. (some
>> folks did have variations of a few Hz based on clock tree - example with
>> a crystal frequency of 19.2MHz you'd probably get 1001MHz exact, with a
>> 26MHz crystal, you'd get 1000MHz -> ofcourse round-rate is supposed to
>> help with that... but anyways.. why not say we are trying to indicate
>> target frequency? I do recollect during initial days of OPP
>> (pre-dt-adoption days) folks did complain about this - we kinda worked
>> around this with round-rated handling - but we might as well anticipate it.
>
> Rob suggested opp- prefix and it looks good to me, lets see what
> others have to say :)

You can decide the color of the bike shed.

>
>> Thanks for adding the examples - My customer support team especially
>> will appreciate having such examples ;).
>
> I can understand that :)
>
>> I agree with Mike[1] here -> why not move clocks and supply to cpu0_opp?
>> "
>> It seems wrong to me that the clock and supply data is owned by the cpu
>> node, and not the opp descriptor. Everything about the opp transition
>> should belong to a provider node. Then the cpu simply needs to consume
>> that via a phandle.
>> "
>>
>> I am not sure if we discussed that point further OR if we kinda got
>> hooked on to the "should it be in kernel" point of debate in V4.
>
> I did send a reply to that, but no one replied after that. Probably
> you want to reply on that ?

Clock and regulator bindings describe connections in the h/w. OPPs are
not a h/w block, but rather properties of the h/w. The connections
here are to the cpu's.

Rob
