From: sudeep.holla@arm.com (Sudeep Holla)
Date: Wed, 17 Aug 2016 18:49:47 +0100
Subject: how to enable suspend to ram for arm-64 bits
In-Reply-To: <CADUS3onCMDThNK2ZwSSjGZhPE0M6cybjgCHJR2wVVeK09GC6ng@mail.gmail.com>
References: <CADUS3onCMDThNK2ZwSSjGZhPE0M6cybjgCHJR2wVVeK09GC6ng@mail.gmail.com>
Message-ID: <06a4f0d7-9022-578d-99e0-ddcde31ed895@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Yoma,

On 17/08/16 18:26, yoma sophian wrote:
> hi all: After I finish porting aarch64 linux kernel on my platform
> and enable CONFIG_PM and CONFIG_SUSPEND,  I found there is no output
> when I cat /sys/power/state.
>
> After tracing kernel code, kernel/power/suspend.c, it seems we need
> to create global suspend method table with suspend_set_ops then we
> can get valid pm_states.

Correct. What's the cpu enable method on your platform ? Is it PSCI ?
If yes, does you PSCI implementation support SYSTEM_SUSPEND ? If yes,
it should work. Check your PSCI implementation otherwise.

> Is any dts or place like arm/match-xxx for registering global suspend
> method?
>

No, currently only PSCI is supported and the firmware is queried and the
suspend_ops is registered automatically.

-- 
Regards,
Sudeep

-- 
Regards,
Sudeep
