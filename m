From: sboyd@codeaurora.org (Stephen Boyd)
Date: Thu, 10 Oct 2013 15:46:11 -0700
Subject: [PATCH 2/5] clocksource: Add Allwinner SoCs HS timers driver
In-Reply-To: <20131010191311.GL3041@lukather>
References: <1380117790-19390-1-git-send-email-maxime.ripard@free-electrons.com>
 <1380117790-19390-3-git-send-email-maxime.ripard@free-electrons.com>
 <52436EBE.9010002@codeaurora.org> <20131010191311.GL3041@lukather>
Message-ID: <52572E33.2090609@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/10/13 12:13, Maxime Ripard wrote:
> On Wed, Sep 25, 2013 at 04:16:14PM -0700, Stephen Boyd wrote:
>> On 09/25/13 07:03, Maxime Ripard wrote:
>>> +	sun5i_clockevent.cpumask = cpumask_of(0);
>> Can this timer interrupt any CPU or is it hardwired to CPU0? If the
>> interrupt can go to any CPU this should be cpu_possible_mask instead.
> I've changed the few other things you spotted, but this one making the
> timer unusable.
>
> I think what happens here is that we have the A31 I've tested these
> patches on is a quad-core SoC. As such, the device tree has 4 CPUs
> declared. However, we don't have any SMP support for it now. So we end
> up having 4 cpus set as possible, and only one online (the boot cpu),
> which isn't working.

Can you explain more why it isn't working? Is the timer being rejected
in favor of another timer?

>
> Would using cpu_online_mask work in our case?

It may work but it's probably hiding a problem with CONFIG_SMP=y

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
hosted by The Linux Foundation
