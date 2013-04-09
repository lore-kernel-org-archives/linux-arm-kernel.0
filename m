From: sboyd@codeaurora.org (Stephen Boyd)
Date: Tue, 09 Apr 2013 07:49:20 -0700
Subject: [PATCH 3/4] clocksource: arch_timer: Push the read/write wrappers
 deeper
In-Reply-To: <20130409093855.GU23725@e106331-lin.cambridge.arm.com>
References: <1365474623-29181-1-git-send-email-sboyd@codeaurora.org>
 <1365474623-29181-4-git-send-email-sboyd@codeaurora.org>
 <20130409093855.GU23725@e106331-lin.cambridge.arm.com>
Message-ID: <51642A70.9060302@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/09/13 02:38, Mark Rutland wrote:
> On Tue, Apr 09, 2013 at 03:30:22AM +0100, Stephen Boyd wrote:
>> -static inline u32 arch_timer_reg_read(const int access, const int reg)
>> +static inline u32 __arch_timer_reg_read(const int access, const int reg)
> Rather than prefixing all of these with "__", why not add "cp15" to the names?
>
> I think that'd make the end result more consistent and clearer, as we'd have a
> _mem version and a _cp15 version of each function.

Sounds fair. I'll make the change.

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
hosted by The Linux Foundation
