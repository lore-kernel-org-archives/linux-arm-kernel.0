From: sboyd@codeaurora.org (Stephen Boyd)
Date: Mon, 04 Mar 2013 15:52:04 -0800
Subject: [PATCH 8/8] ARM: smp: Remove local timer API
In-Reply-To: <5135333E.6030305@codeaurora.org>
References: <1361518039-16663-1-git-send-email-sboyd@codeaurora.org>
 <1361518039-16663-9-git-send-email-sboyd@codeaurora.org>
 <20130222111545.GA15020@e106331-lin.cambridge.arm.com>
 <20130222162458.GA19670@linux-sh.org>
 <20130225134041.GA22785@e106331-lin.cambridge.arm.com>
 <5135333E.6030305@codeaurora.org>
Message-ID: <513533A4.3060300@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 03/04/13 15:50, Stephen Boyd wrote:
>
>> +
>> +	evt->name	= "dummy timer";
>> +	evt->features	= CLOCK_EVT_FEAT_PERIODIC |
>> +			  CLOCK_EVT_FEAT_ONESHOT |
>> +			  CLOCK_EVT_FEAT_DUMMY;
>> +	evt->rating	= 100;
>> +	evt->set_mode	= dummy_set_mode;
>> +	evt->cpumask	= cpumask_of(cpu);
>> +
>> +	clockevents_register_device(evt);
>> +}
>> +
>> +static int __cpuinit dummy_cpu_notify(struct notifier_block *self,
>> +				      unsigned long action, void *hcpu)
>> +{
>> +	if ((action & ~CPU_TASKS_FROZEN) == CPU_STARTING)
>> +		dummy_setup();
> There are already two dummy_setup() functions. Perhaps we can
> s/dummy/dummy_broadcast/ throughout this file?
>

Sorry, meant to say dummy_timer not dummy_broadcast.

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
hosted by The Linux Foundation
