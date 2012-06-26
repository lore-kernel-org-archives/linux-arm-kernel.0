From: sboyd@codeaurora.org (Stephen Boyd)
Date: Tue, 26 Jun 2012 10:44:16 -0700
Subject: [PATCH 1/2] ARM: arch timer: implement read_current_timer and
 get_cycles
In-Reply-To: <20120626103718.GD27996@mudshark.cambridge.arm.com>
References: <1340377774-17173-1-git-send-email-will.deacon@arm.com>
 <1340377774-17173-2-git-send-email-will.deacon@arm.com>
 <4FE8DA78.5070804@codeaurora.org>
 <20120626103718.GD27996@mudshark.cambridge.arm.com>
Message-ID: <4FE9F4F0.9000201@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/26/12 03:37, Will Deacon wrote:
> On Mon, Jun 25, 2012 at 10:39:04PM +0100, Stephen Boyd wrote:
>>> +int read_current_timer(unsigned long *timer_val)
>>> +{
>>> +	if (!arch_timer_rate)
>>> +		return -ENXIO;
>> Shouldn't this be returning 0? Otherwise get_cycles() up there will
>> evaluate to -ENXIO?
> I don't think so. The cycle count is returned via the timer_val parameter
> and the get_cycles code checks the return value, so will give 0 if
> read_current_timer returns anything other than 0. The core calibration code
> (not that we call it) also expects a return value < 0 to indicate failure.

Ah you're right. More coffee in the morning would do me some good.

-- 
Sent by an employee of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.
