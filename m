From: marc.zyngier@arm.com (Marc Zyngier)
Date: Fri, 13 Sep 2013 14:40:29 +0100
Subject: [PATCH 3/4] Add physical count arch timer support for clocksource
 in ARMv7.
In-Reply-To: <CAK3cCBw4EKypLmhf4L5_P3d27QzsrB+ZxUTgF58YhmUhBa00xQ@mail.gmail.com>
References: <1378968687-8200-1-git-send-email-cinifr@gmail.com>
 <1378968687-8200-4-git-send-email-cinifr@gmail.com>
 <20130912112452.GA22013@e106331-lin.cambridge.arm.com>
 <CAK3cCBwu4somtfc9J1ZDVcC-iYD1qDJwSWzWeOomTqY9tQA2kg@mail.gmail.com>
 <5231EE43.5090900@arm.com>
 <CAK3cCBzr8_LTYarZDgPYZY7_-5Qco_Qw+ACi=c2uOrn7MqwkBg@mail.gmail.com>
 <5232DB49.4050701@arm.com>
 <CAK3cCBw4EKypLmhf4L5_P3d27QzsrB+ZxUTgF58YhmUhBa00xQ@mail.gmail.com>
Message-ID: <523315CD.8010704@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 13/09/13 14:09, cinifr wrote:
>> I urge you to read the ARM ARM, and specifically the section dedicated
>> to trapping access to CP15 operations. If you do, you'll quickly notice
>> that you *cannot* trap accesses to the timer subsystem.
>>
> I read it again. The ARMv7 manual said "Is accessible from Non-secure
> PL1 modes only when CNTHCTL.PL1PCTEN is set to 1. When
> CNTHCTL.PL1PCTEN is set to 0, any attempt to access CNTPCT from a
> Non-secure PL1 mode ***generates a Hyp Trap exception***, see Hyp Trap
> exception on page B1-1206" in B8.1.2. but I dont find  a  special hyp
> trap control  for accessing CNTPCT in manual. As you said HSTR cannot
> trap accessing of CP15 c14. What happer when OS access CNTPCT from PL1
> NS=1 mode with CNTHCTL.PL1PCTEN=0 ???  AmI  wrong for understanding
> the manual?

That's interesting, as I never noticed this particular line in the ARM
ARM. I'll investigate this, thanks for bringing it up.

This doesn't change the fact that using the physical timer/counter in a
VM is (or can be) horribly expensive, and should be avoided at all cost.

Thanks,

	M.
-- 
Jazz is not dead. It just smells funny...
