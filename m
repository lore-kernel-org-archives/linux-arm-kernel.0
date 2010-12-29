From: linus.walleij@linaro.org (Linus Walleij)
Date: Wed, 29 Dec 2010 01:59:09 +0100
Subject: Git pull request: ux500-core for the v2.6.38 merge window
In-Reply-To: <20101223144949.GO3636@n2100.arm.linux.org.uk>
References: <AANLkTim7iBkvqHrraRkMfrvQJjPHVccmSh=01hZxSyu-@mail.gmail.com>
	<20101223144949.GO3636@n2100.arm.linux.org.uk>
Message-ID: <AANLkTikDhyqcQ_=jCusJcVHrRp6hxjJ7x2W2-qbTM4jp@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2010/12/23 Russell King - ARM Linux <linux@arm.linux.org.uk>:

> On Thu, Dec 23, 2010 at 08:48:26AM +0100, Linus Walleij wrote:
>> Russell, could you please pull:
>>
>> ? ? ? ?git://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-stericsson.git
>> for-rmk
>>
>> This is based on your devel branch due to the dependencies on the GIC
>> cleanup patches
>
> Basing stuff on the devel branch really doesn't work, especially as I'm
> still getting a trickle of acks and tested-by's for the clksrc stuff.

Yeah I was sort of thinking that...

> Of course, I could chose not to publish such stuff in my devel branch,
> thereby preventing it appearing in linux-next until the last moment
> before the merge window. ?Or I could just not ask for acks etc...

I think Rabin was writing these patches based on the -next tree,
not the devel branch directly.

> Is it possible to split this stuff up into two topic branches - one set
> which doesn't depend on my GIC and SMP changes, and then we'll see what
> can be done about the remainder?

Yes, as mentioned in the original post:
If basing this on devel is unacceptable then please
pull this instead:

      git://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-stericsson.git
ux500-core

This brings in everything except the 5 patches from Rabin
that require the GIC+SMP changes. I've frozen that tree
until you pull it.

> What I'm thinking is maybe if I merge the GIC and SMP changes together,
> and provide you with that as a basis for your dependents?

Perfect!

I will try to fix it ASAP if you prepare this, and if I fail I bet
Rabin will help me sort it out.

Yours,
Linus Walleij
