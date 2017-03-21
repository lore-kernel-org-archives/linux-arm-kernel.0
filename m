From: fu.wei@linaro.org (Fu Wei)
Date: Tue, 21 Mar 2017 13:12:09 +0800
Subject: [PATCH v21 13/13] acpi/arm64: Add SBSA Generic Watchdog support
 in GTDT driver
In-Reply-To: <20170320180949.GM31213@leverpostej>
References: <20170206185015.12296-1-fu.wei@linaro.org>
 <20170206185015.12296-14-fu.wei@linaro.org>
 <20170317200153.GF15909@leverpostej>
 <CADyBb7uZV2Qe0ga4TTS_iis5MtwJ=u6PKYSV6ED103Cmh5_O3g@mail.gmail.com>
 <20170320180949.GM31213@leverpostej>
Message-ID: <CADyBb7s8YCZjPtiuesH-dqBtP74PewsbaEnjj3RjV7Bx_34wFg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Mark,

On 21 March 2017 at 02:09, Mark Rutland <mark.rutland@arm.com> wrote:
> On Tue, Mar 21, 2017 at 01:57:58AM +0800, Fu Wei wrote:
>> On 18 March 2017 at 04:01, Mark Rutland <mark.rutland@arm.com> wrote:
>> > On Tue, Feb 07, 2017 at 02:50:15AM +0800, fu.wei at linaro.org wrote:
>
>> > I've not been able to find where the ACPI spec says that zero is not a
>> > valid GSIV. This may simply be an oversight/ambiguity in the spec.
>> >
>> > Is there any statement to that effect?
>>
>> you are right, zero is a  valid GSIV, I will delete this check. Thanks
>
> That being the case, how does one describe a watchdog that does not have
> an interrupt?

I think we may can use "Timer Flags", because all the GSIV come with a flag,
if we can define a bit field called "valid" for all GSIV

Bit Field   Bit Offset   Number of bits                 Description
Valid            31                 1                      This bit
indicates the validity of the timer interrupt
                                                                 1:
Interrupt is valid
                                                                 0:
Interrupt is invalid
Then we don't need to test the value of GSIV, just test this bit instead.

Just my thought, hope this makes sense to all of you :-)

>
> As I mentioned, I think this is an oversight/ambiguity in the spec tat
> we should address.
>
>> > My reading of SBSA is that there is one watchdog in the system.
>> >
>> > Is that not the case?
>>
>> do you mean:
>> ---------------
>> 4.2.4 Watchdogs
>> The base server system implements a Generic Watchdog as specified in
>> APPENDIX A: Generic Watchdog.
>> ---------------
>>
>> I am not sure about that if this is saying "we only have one SBSA
>> watchdog in a system"
>>
>> would you let me know where mention it? Do I miss something?
>
> My reading was that the 'a' above meant a single element. i.e.
>
>         The base server system implements _a_ Generic Watchdog as
>         specified in APPENDIX A: Generic Watchdog.
>
> Subsequently in 4.2.5, it is stated:
>
>         In this scenario, the system wakeup timer or generic watchdog is
>         still required to send its interrupt.
>
> ... which only makes sense if there is a single watchdog in the system.
>
> Perhaps this is an oversight in the specification.
>
> Thanks,
> Mark.



-- 
Best regards,

Fu Wei
Software Engineer
Red Hat
