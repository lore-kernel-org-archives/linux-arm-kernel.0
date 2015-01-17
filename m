From: orsonzhai@gmail.com (Orson Zhai)
Date: Sat, 17 Jan 2015 16:10:32 +0800
Subject: [PATCH v5 2/5] Documentation: DT: Add bindings for Spreadtrum SoC
 Platform
In-Reply-To: <20150116141109.GC22569@leverpostej>
References: <1421402411-3479-1-git-send-email-chunyan.zhang@spreadtrum.com>
 <1421402411-3479-3-git-send-email-chunyan.zhang@spreadtrum.com>
 <20150116102135.GC21809@leverpostej>
 <CAAfSe-teDdPzRUnvzM+NErfZwmqM04yUMgic--hyZL8-Jjd8jw@mail.gmail.com>
 <20150116141109.GC22569@leverpostej>
Message-ID: <CA+H2tpHA7PRL98VMd3d3jeaOr_6Q5ktmM3fbdaBKRpm_pXVqVw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jan 16, 2015 at 10:11 PM, Mark Rutland <mark.rutland@arm.com> wrote:
> On Fri, Jan 16, 2015 at 12:53:16PM +0000, Lyra Zhang wrote:
>> Hi, Mark
>>
>> >> +
>> >> +Required properties:
>> >> +- compatible: must be "sprd,sc9836-uart"
>> >> +- reg: offset and length of the register set for the device
>> >> +- interrupts: exactly one interrupt specifier
>> >> +- clocks: phandles to input clocks.
>> >
>> > The order and relevance of each should be specified. If you have
>> > multiple clocks I would strongly recommend you use clock-names to
>> > distinguish them.
>> >
>>
>> Thank you for the recommendation.
>> but, since we haven't made the clock driver ready, for this initial
>> commit, we just let 4 UARTs share a single fixed 26 MHz clock source.
>> we'll do like you've recommended when we will submit the clock driver
>> in the future.
>
> I'm on about the clock input lines on the UART instance, not the
> providers they come from.
>
> Is there only a single clock input line on each UART? Perhaps multiple
> input lines which are currently fed by the same clock?

________
| 26MHz |-------------------------------------------------
-------------        |                  |
                     |                  |
                _______       ________
               | UART1 |      | UART2 |    .........
               --------------      -------------

the hardware is something like the diagram.

4 Uart modules are all connected to a fixed 26Mhz crystal by power-on default.

There should be a clock-mux between uart and 26Mhz which
could select other clock source such as some pll output.

But as initial commit , we are not ready to describe other inputs by
these muxes.
So  we treat the UART as a simple model with only one fixed-clock input.
And we plan to add the other inputs path back in a not very far future.
Is it appropriate  to do like this?

  Orson


>
> Thanks,
> Mark.
