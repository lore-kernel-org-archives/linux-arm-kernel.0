From: skannan@codeaurora.org (Saravana Kannan)
Date: Tue, 14 Feb 2012 15:20:46 -0800
Subject: [PATCH RFC 0/4] Scheduler idle notifiers and users
In-Reply-To: <20120211144530.GA497@elte.hu>
References: <20120208013959.GA24535@panacea> <1328670355.2482.68.camel@laptop>
 <20120208202314.GA28290@redhat.com> <1328736834.2903.33.camel@pasglop>
 <20120209075106.GB18387@elte.hu> <4F35DD3E.4020406@codeaurora.org>
 <20120211144530.GA497@elte.hu>
Message-ID: <4F3AEC4E.9000303@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


On 02/11/2012 06:45 AM, Ingo Molnar wrote:
>
> * Saravana Kannan<skannan@codeaurora.org>  wrote:
>
>> When you say accommodate all hardware, does it mean we will
>> keep around CPUfreq and allow attempts at improving it? Or we
>> will completely move to scheduler based CPU freq scaling, but
>> won't try to force atomicity? Say, may be queue up a
>> notification to a CPU driver to scale up the frequency as soon
>> as it can?
>
> I don't think we should (or even could) force atomicity - we
> adapt to whatever the hardware can do.

May be I misread the emails from Peter and you, but it sounded like the 
idea being proposed was to directly do a freq change from the scheduler. 
That would force the freq change API to be atomic (if it can be 
implemented is another issue). That's what I was referring to when I 
loosely used the terms "force atomicity".

> But the design should be directed at systems where frequency
> changes can be done in a reasonably fast manner. That is what he
> future is - any change we initiate today takes years to reach
> actual products/systems.

As long as the new design doesn't treat archs needing schedulable 
context to set freq as a second class citizen, I think we would all be 
happy. Because it's not just a matter of it being old hardware. 
Sometimes the decision to let the SW do the voltage scaling also comes 
down to HW cost. Considering Linux runs on such a wide set of archs, I 
think we shouldn't treat the need for schedulable context for freq 
setting as "broken" or "not sane".


>> IMHO, I think the problem with CPUfreq and its dynamic
>> governors today is that they do a timer based sampling of the
>> CPU load instead of getting some hints from the scheduler when
>> the scheduler knows that the load average is quite high.
>
> Yes - that is one of the "frequency changes are slow"
> assumptions - which is wrong.

Thanks,
Saravana

-- 
Sent by an employee of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.
