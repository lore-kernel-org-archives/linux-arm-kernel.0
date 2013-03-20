From: cov@codeaurora.org (Christopher Covington)
Date: Wed, 20 Mar 2013 16:06:17 -0400
Subject: [kvmarm] [PATCH 14/29] arm64: KVM: guest one-reg interface
In-Reply-To: <CAFEAcA8DkB0tMN6V1fi=teujm0hWji-O9ZF8+iOswTOihEjFcA@mail.gmail.com>
References: <1362455265-24165-1-git-send-email-marc.zyngier@arm.com>
 <1362455265-24165-15-git-send-email-marc.zyngier@arm.com>
 <513F6659.7060500@codeaurora.org> <513F6E86.4040902@arm.com>
 <513FA70B.2040600@codeaurora.org> <51402F52.6020808@arm.com>
 <5140E2C0.7010009@codeaurora.org>
 <CAFEAcA8DkB0tMN6V1fi=teujm0hWji-O9ZF8+iOswTOihEjFcA@mail.gmail.com>
Message-ID: <514A16B9.2040804@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Marc, Peter,

On 03/14/2013 04:57 AM, Peter Maydell wrote:
> On 13 March 2013 20:34, Christopher Covington <cov@codeaurora.org> wrote:
>> My guess at the goal of the code cited above in this email is that it's trying
>> to sanity check that virtualization will work. Rather than taking a default
>> deny approach with a hand-maintained white list of virtualization-supporting
>> machine identifiers, why not check that EL2 is implemented on the current
>> system and if it's not implied by that, that the timer and interrupt
>> controller are suitable as well?

[...]

> ...you need to implement emulation code for the imp-def registers for a
> guest CPU.

[...]

This is reasonable. In this light the code I was picking out above is simply
converting MIDRs to KVM_ARM_TARGET_* constants. Because the mapping isn't
one-to-one, the hand-maintained list is an acceptable approach.

In the long term, I wonder if some kind of KVM_TARGET_CURRENT_CPU might be handy.

Thanks,
Christopher

-- 
Employee of Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, hosted by
the Linux Foundation
