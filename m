From: dave.martin@linaro.org (Dave Martin)
Date: Thu, 10 Feb 2011 14:13:13 +0000
Subject: [PATCH] ARM: Avoid discarding sections that might have SMP_ON_UP
	fixups
In-Reply-To: <AANLkTin3+4pwxQRz1J_1B6dJxJm0_5ou0OWteDFZNbo9@mail.gmail.com>
References: <E1PeueP-0003SR-03@rmk-PC.arm.linux.org.uk>
	<AANLkTinnhivretaRHpYwCYouk-_jWKZQEo7x4sbheJVL@mail.gmail.com>
	<20110125165919.GD17286@n2100.arm.linux.org.uk>
	<AANLkTimK06nJPtQoym3HxXeDD-s4nUrN0vWjp_JcgTjx@mail.gmail.com>
	<20110125174636.GE17286@n2100.arm.linux.org.uk>
	<alpine.LFD.2.00.1101251618230.8580@xanadu.home>
	<AANLkTi=zVsr8G=eYfp7v_QQvBBDCX+Es+T-4c4Fu=QVF@mail.gmail.com>
	<20110126124452.GB4232@n2100.arm.linux.org.uk>
	<20110126172535.GA15983@arm.com>
	<20110209142211.GA11460@n2100.arm.linux.org.uk>
	<20110210125624.GA3652@n2100.arm.linux.org.uk>
	<AANLkTin3+4pwxQRz1J_1B6dJxJm0_5ou0OWteDFZNbo9@mail.gmail.com>
Message-ID: <AANLkTinjAHLCMJja8q=bPhRBuoR2DCO_NjDw1qNi5MrU@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Feb 10, 2011 at 2:11 PM, Dave Martin <dave.martin@linaro.org> wrote:
> On Thu, Feb 10, 2011 at 12:56 PM, Russell King - ARM Linux
> <linux@arm.linux.org.uk> wrote:
>> On Wed, Feb 09, 2011 at 02:22:11PM +0000, Russell King - ARM Linux wrote:
>>> On Wed, Jan 26, 2011 at 05:25:35PM +0000, Dave P. Martin wrote:
>>> > SMP_ON_UP fixups lead to vmlinux link errors if those sections are
>>> > discarded at link-time. ?In particular this may happen for built-in
>>> > __exit stuff.
>>> >
>>> > This patch modifies the vmlinux linker script to reduce the amount
>>> > of discarded sections, and tries to make sure that __exit sections
>>> > are kept in.
>>> >
>>> > This is a hack and probably wrong! ?Further discussion is needed.
>>>
>>> Can you send the configuration which you see this problem with?
>>> I've tried to build a kernel which inlines the spinlocks, but I find
>>> that's not possible, so I'm doubting whether any fix is required for
>>> mainline.
>>
>> Any news on this, or can it not be reproduced?
>>
>
> Hi, apologies-- didn't see my mail for a bit.
>
> I get the problem with this tree and config (which builds with
> SMP_ON_UP and THUMB2_KERNEL for omap3/4):
>
> Tree: git://git.linaro.org/people/dmart/linux-2.6-arm.git
> dirty/arm/omap-thumb2+merged
> Config: http://people.linaro.org/~dmart/arm_omap-thumb2+v2_config

Note that this tree contains some extra patches (though I believe
nothing is there which should cause the problem), and does not contain
everything from rmk/devel -- so it's possible this has been fixed in
the meantime or no longer occurs for some other reason...

Cheers
---Dave
