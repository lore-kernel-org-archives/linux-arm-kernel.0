From: davidriley@google.com (David Riley)
Date: Thu, 15 May 2014 16:18:16 -0700
Subject: [PATCH] arm: dts: exynos5: Remove multi core timer
In-Reply-To: <CAJFHJrrgWGc4XGQB0ysLufAg3Wouz-aYXu97Sy2Kp=HzK+akVQ@mail.gmail.com>
References: <1400188079-21832-1-git-send-email-chirantan@chromium.org>
 <53752E25.9060604@gmail.com>
 <CAD=FV=WKOtZaUyzTWNqR=vi_L=U-Q1dct2U_oCYi3ZJv6401Hg@mail.gmail.com>
 <53753443.8010303@gmail.com>
 <CAD=FV=V8UZoeOqEwfx_E015pLM+amTt51LrUa+dk7mTdn=vKgA@mail.gmail.com>
 <53753C17.1090002@gmail.com>
 <CAD=FV=WGa7j_As_NpySxU7OEd_SzuGWK6oxU6UeiJ-4HsoWvvg@mail.gmail.com>
 <CAJFHJrrgWGc4XGQB0ysLufAg3Wouz-aYXu97Sy2Kp=HzK+akVQ@mail.gmail.com>
Message-ID: <CAASgrz2Nr69tpfC8ka9gbs2OvjLEGsvgAj4vBCFxhsamuFum7w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, May 15, 2014 at 4:03 PM, Chirantan Ekbote
<chirantan@chromium.org> wrote:
> Hi Tomasz,
>
> On Thu, May 15, 2014 at 3:44 PM, Doug Anderson <dianders@chromium.org> wrote:
>> Tomasz,
>>
>> On Thu, May 15, 2014 at 3:13 PM, Tomasz Figa <tomasz.figa@gmail.com> wrote:
>>>> NOTE: if for some reason we need to keep the MCT around, we're
>>>> definitely going to need to account for the fact that tweaking it
>>>> affects the arch timer.  ...and having the arch timer is really nice
>>>> since:
>>>
>>> [Let me reorder the points below to make it easier to comment:]
>>>
>>>> * it's faster to access.
>>>> * it is accessible from userspace for really fast access.
>>>
>>> Do you have some data on whether it is a significant difference,
>>> especially considering real use cases?
>>
>> I know that Chrome makes _a lot_ of calls to gettimeofday() for
>> profiling purposes, enough that it showed up on benchmarks.  In fact,
>> we made a change to the MCT to make accesses faster and there's a
>> small mention of the benchmarking that was done at:
>>
>> https://chromium-review.googlesource.com/#/c/32190/
>>
>> ...that change probably should be sent upstream, actually.
>>
>> I'll let Chirantan comment on how much faster arch timers were.
>> ...and I think David Riley (also CCed now) may be able to comment on
>> the benefits of userspace timers.
>>
>
> When I profiled gettimeofday() calls, they were about 50 - 60% faster
> with the arch timers compared to the mct.

When I profiled gettimeofday(), the standard systems call version took
about 2.5x longer than through a vDSO interface.

>
> - Chirantan
