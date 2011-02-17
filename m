From: rabin@rab.in (Rabin Vincent)
Date: Thu, 17 Feb 2011 22:20:14 +0530
Subject: [PATCHv2 1/2] ARM: perf_event: allow platform-specific interrupt
	handler
In-Reply-To: <-3663809140750500272@unknownmsgid>
References: <1297137277-26889-1-git-send-email-rabin.vincent@stericsson.com>
	<-6723806473392693428@unknownmsgid>
	<AANLkTi=wQ9ku+zbu6sx5Mm+ux4Ot6K2h9a_WK=XEB_iG@mail.gmail.com>
	<-3663809140750500272@unknownmsgid>
Message-ID: <AANLkTi=ph8U3qGFgfhc15SNuYcj6oSUq8VPyJ+h_8b5O@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Feb 17, 2011 at 22:03, Will Deacon <will.deacon@arm.com> wrote:
>> I gave this a try, along with the modifications to enable IRQ_PER_CPU
>> and have the pmu code use the appropriate flags and set the affinity.
>> Didn't work though; it always ends up triggering the spurious IRQ check.
>
> Hmm, that doesn't sound right. Did you have any synchronisation to ensure
> that the CPU without the overflow didn't return IRQ_NONE until the handling
> CPU had returned IRQ_HANDLED?

No.  What kind of synchronization do you mean?
