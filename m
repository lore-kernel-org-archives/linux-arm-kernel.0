From: c.dall@virtualopensystems.com (Christoffer Dall)
Date: Sat, 29 Sep 2012 19:00:12 -0400
Subject: [PATCH 15/15] KVM: ARM: Guest wait-for-interrupts (WFI) support
In-Reply-To: <20120925170423.GG28728@mudshark.cambridge.arm.com>
References: <20120915153359.21241.86002.stgit@ubuntu>
 <20120915153605.21241.75455.stgit@ubuntu>
 <20120925170423.GG28728@mudshark.cambridge.arm.com>
Message-ID: <CANM98qLuirMEipeV=Y_dLg66r1pm2FL-XnDyLof+4UYHYPs7JA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Sep 25, 2012 at 1:04 PM, Will Deacon <will.deacon@arm.com> wrote:
> On Sat, Sep 15, 2012 at 04:36:05PM +0100, Christoffer Dall wrote:
>> From: Christoffer Dall <cdall@cs.columbia.edu>
>>
>> When the guest executes a WFI instruction the operation is trapped to
>> KVM, which emulates the instruction in software. There is no correlation
>> between a guest executing a WFI instruction and actually putting the
>> hardware into a low-power mode, since a KVM guest is essentially a
>> process and the WFI instruction can be seen as 'sleep' call from this
>> process. Therefore, we block the vcpu when the guest excecutes a wfi
>> instruction and the IRQ or FIQ lines are not raised.
>>
>> When an interrupt comes in through KVM_IRQ_LINE (see previous patch) we
>> signal the VCPU thread and unflag the VCPU to no longer wait for
>> interrupts.
>
> Seems a bit strange tagging this small addition on the end of this series.
> Can you merge it in with the rest?
>

sure, I'll tag it in with the world-switch or emulation.

-Christoffer
