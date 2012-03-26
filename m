From: peter.maydell@linaro.org (Peter Maydell)
Date: Mon, 26 Mar 2012 10:50:35 +0100
Subject: [Android-virt] [PATCH] ARM: test for PMU feature on v7 (v2 with
 typo fix)
In-Reply-To: <20120326094054.GA2475@mudshark.cambridge.arm.com>
References: <4F590411.9060201@arm.com> <87ty1g88dv.fsf@rustcorp.com.au>
 <87r4wk889a.fsf@rustcorp.com.au>
 <20120323095314.GA13622@mudshark.cambridge.arm.com>
 <87fwcy9abw.fsf@rustcorp.com.au>
 <20120326094054.GA2475@mudshark.cambridge.arm.com>
Message-ID: <CAFEAcA-S3pN0AihjMZdchRyvFpifvKN8rNytpEP_iaA3H5RWfQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 26 March 2012 10:40, Will Deacon <will.deacon@arm.com> wrote:
> [removed some dead email addresses from CC]
>
> On Fri, Mar 23, 2012 at 11:17:07PM +0000, Rusty Russell wrote:
>> On Fri, 23 Mar 2012 09:53:14 +0000, Will Deacon <will.deacon@arm.com> wrote:
>> > This code is only executed if we know for sure that we are running on a
>> > Cortex-A8. Cortex-A8 implementations have a PMU, so I don't like having the
>> > probe here in case we are running on a virtualised CPU that doesn't quite
>> > match the hardware.
>>
>> OK, I see that argument, but I don't like it. ?eg. the Cortex A-15 is
>> defined to have a PMUv2 with 6 counters, and below you're arguing we
>> should implement zero of them.
>
> Well, I think you should actually implement all 6 of them if that's the
> target which you're emulating.

The trouble with this line of thought is that it leads to the requirement
to support nested virtualization and virtualization of TrustZone, neither
of which are actually particularly useful or simple to do. At some point
we're going to end up saying that the "A15" we expose to the guest is
not an exact match to the real hardware, that it's missing certain
features (and hopefully that the lack of those features is advertised
via the feature registers). So the question is where you draw the line...

-- PMM
