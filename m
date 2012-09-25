From: will.deacon@arm.com (Will Deacon)
Date: Tue, 25 Sep 2012 18:04:23 +0100
Subject: [PATCH 15/15] KVM: ARM: Guest wait-for-interrupts (WFI) support
In-Reply-To: <20120915153605.21241.75455.stgit@ubuntu>
References: <20120915153359.21241.86002.stgit@ubuntu>
 <20120915153605.21241.75455.stgit@ubuntu>
Message-ID: <20120925170423.GG28728@mudshark.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Sep 15, 2012 at 04:36:05PM +0100, Christoffer Dall wrote:
> From: Christoffer Dall <cdall@cs.columbia.edu>
> 
> When the guest executes a WFI instruction the operation is trapped to
> KVM, which emulates the instruction in software. There is no correlation
> between a guest executing a WFI instruction and actually putting the
> hardware into a low-power mode, since a KVM guest is essentially a
> process and the WFI instruction can be seen as 'sleep' call from this
> process. Therefore, we block the vcpu when the guest excecutes a wfi
> instruction and the IRQ or FIQ lines are not raised.
> 
> When an interrupt comes in through KVM_IRQ_LINE (see previous patch) we
> signal the VCPU thread and unflag the VCPU to no longer wait for
> interrupts.

Seems a bit strange tagging this small addition on the end of this series.
Can you merge it in with the rest?

Will
