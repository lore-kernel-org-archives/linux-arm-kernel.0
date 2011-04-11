From: ashwinc@codeaurora.org (Ashwin Chaugule)
Date: Mon, 11 Apr 2011 13:44:14 -0400
Subject: [RFC] Extending ARM perf-events for multiple PMUs
In-Reply-To: <1302521393.24286.66.camel@e102144-lin.cambridge.arm.com>
References: <1302282912.5758.25.camel@e102144-lin.cambridge.arm.com>	
	<1302349235.9086.1270.camel@twins>
	<1302521393.24286.66.camel@e102144-lin.cambridge.arm.com>
Message-ID: <4DA33DEE.9080709@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Will,

On 4/11/2011 7:29 AM, Will Deacon wrote:
>> I don't see this distinction, both will have to count, and telling it
>> what to count is a function of perf_event_attr::config* and how the
>> hardware implements that is of no interest.
> 
> Sure, fundamentally we're just writing bits rather than interpreting
> them. The reason I mention the difference is that filtering PMUs will
> always need their own struct pmu because of the lack of an event
> namespace. The other problem is only an issue for some userspace tools
> (like Oprofile) which require lists of events and their hex codes.
> 

If you mean namespace = perf_event_attr::config, its 64 bits + another 64
bits of config_base + event_base on ARM ? Not too sure, but it would seem
like that should be enough to setup such event chaining.


> 
> Would this result in userspace attributing all of the data to a
> particular CPU? We could consider allowing events where the cpu is -1
> and the task pid is -1 as well. Non system-wide PMUs could reject these
> and demand multiple events instead.

Agreed. perf stat -a on PMU's that are not CPU-aware, would report
incorrect output. Task counting on such PMU's would be pointless.


Cheers,
Ashwin


-- 
Sent by an employee of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.
