From: ashwinc@codeaurora.org (Ashwin Chaugule)
Date: Mon, 11 Apr 2011 14:00:09 -0400
Subject: [RFC] Extending ARM perf-events for multiple PMUs
In-Reply-To: <1302349235.9086.1270.camel@twins>
References: <1302282912.5758.25.camel@e102144-lin.cambridge.arm.com>
	<1302349235.9086.1270.camel@twins>
Message-ID: <4DA341A9.6060004@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Peter,

On 4/9/2011 7:40 AM, Peter Zijlstra wrote:
> 
> So the perf core supports multiple hardware PMUs, but currently only one
> of which can do per-task sampling, if you've got multiple CPU local PMUs
> we need to do a little extra.

Would this restriction be removed if task_struct->perf_event_ctxp[] had
more entries for each PMU_TYPE ?

On a related note, I haven't had time yet to look deeper for a proper fix
for the stale perf_event_ctx pointer issue, other than the one liner in
perf_task_event_sched_in() we discussed about, but that'll need fixing
before more PMU's start popping up.


> What we do for the events is map the provided CPU number to a memory
> controller (cpu_to_node() does that for our case), and then use the
> first online cpu in that node mask to drive the event.

I suppose you're referring to the uncore patches here.
So only one CPU has access to the uncore PMU at a time ?


Cheers,
Ashwin


-- 
Sent by an employee of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.
