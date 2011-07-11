From: eric.y.miao@gmail.com (Eric Miao)
Date: Mon, 11 Jul 2011 15:47:27 +0800
Subject: [GIT PULL] pxa: features for next
In-Reply-To: <20110711074600.GL4812@n2100.arm.linux.org.uk>
References: <CAMPhdO8uQR4km9szkuGDjuym-hViE9+zxtie6D2WGJmf1_9rUg@mail.gmail.com>
	<20110711074113.GK4812@n2100.arm.linux.org.uk>
	<CAMPhdO8pxGsEN1EeYwZRBnPvhkN29wOmEzWaaoCh9iqO+VkDrg@mail.gmail.com>
	<20110711074600.GL4812@n2100.arm.linux.org.uk>
Message-ID: <CAMPhdO8=Gsiw_e6mFRi1PM99DSroaQi_SBiH298KAKqHb41rNw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jul 11, 2011 at 3:46 PM, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:
> On Mon, Jul 11, 2011 at 03:44:54PM +0800, Eric Miao wrote:
>> On Mon, Jul 11, 2011 at 3:41 PM, Russell King - ARM Linux
>> <linux@arm.linux.org.uk> wrote:
>> > On Mon, Jul 11, 2011 at 03:27:15PM +0800, Eric Miao wrote:
>> >> ? ? ? ARM: pxa: avoid accessing interrupt registers directly
>> >> ? ? ? ARM: pxa: introduce {icip,ichp}_handle_irq() to prepare MULTI_IRQ_HANDLER
>> >
>> > What happened about the __exception issue with asm_do_IRQ?
>> >
>>
>> I just removed the __exception from the C handler.
>
> From asm_do_IRQ ?
>

No. From icip_handle_irq() and ichp_handle_irq(). Thought the ability to
unwind asm_do_IRQ() is more important.
