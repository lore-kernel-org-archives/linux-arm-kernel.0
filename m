From: sboyd@codeaurora.org (Stephen Boyd)
Date: Tue, 05 Mar 2013 10:45:11 -0800
Subject: [PATCH 8/8] ARM: smp: Remove local timer API
In-Reply-To: <20130305110239.GC15661@e106331-lin.cambridge.arm.com>
References: <1361518039-16663-1-git-send-email-sboyd@codeaurora.org>
 <1361518039-16663-9-git-send-email-sboyd@codeaurora.org>
 <20130222111545.GA15020@e106331-lin.cambridge.arm.com>
 <20130222162458.GA19670@linux-sh.org>
 <20130225134041.GA22785@e106331-lin.cambridge.arm.com>
 <5135333E.6030305@codeaurora.org>
 <20130305110239.GC15661@e106331-lin.cambridge.arm.com>
Message-ID: <51363D37.1090107@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 03/05/13 03:02, Mark Rutland wrote:
>
>>> +
>>> +static void dummy_set_mode(enum clock_event_mode mode,
>>> +			   struct clock_event_device *evt)
>>> +{
>>> +	/*
>>> +	 * Core clockevents code will call this when exchanging timer devices.
>>> +	 * We don't need to do anything here.
>>> +	 */
>>> +}
>>> +
>>> +static void __cpuinit dummy_setup(void)
>>> +{
>>> +	int cpu = smp_processor_id();
>>> +	struct clock_event_device *evt = &per_cpu(dummy_evt, cpu);
>> Can we use __this_cpu_ptr()? I wonder if that makes the code generation
>> better or worse. I didn't do it in my 8/8 patch because I wanted the
>> code to be the same before and after to show code movement.
> I did that originally, but thought as I needed the cpu value for the mask
> anyway that there wasn't much point. I'm not that good at reading generated
> assembly, so I can't really say if either's better.

It looks to be two instructions shorter.

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
hosted by The Linux Foundation
