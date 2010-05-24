From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 24 May 2010 08:19:21 +0100
Subject: [RESEND PATCH] ARM: fix 'unannotated irqs-on' lockdep warning
In-Reply-To: <20100524112355.18424622@tom-lei>
References: <1274615328-27953-1-git-send-email-tom.leiming@gmail.com>
	<20100523123801.GC950@n2100.arm.linux.org.uk>
	<AANLkTikRp0EHxshKYq39p18ymoRNAtyHrNm3yq6A49-r@mail.gmail.com>
	<20100523141300.GD950@n2100.arm.linux.org.uk>
	<AANLkTinV9Na9zxYMIfTr893Ynnc0YOk2B6uPKEa9s4R1@mail.gmail.com>
	<20100523194746.GE950@n2100.arm.linux.org.uk>
	<20100524112355.18424622@tom-lei>
Message-ID: <20100524071921.GA17528@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, May 24, 2010 at 11:23:55AM +0800, Ming Lei wrote:
> On Sun, 23 May 2010 20:47:46 +0100
> Russell King - ARM Linux <linux@arm.linux.org.uk> wrote:
> > Moreover, I put to you that it's utterly pointless - and a waste of
> > CPU time - telling lockdep about the IRQ masking when an exception
> 
> Yes, the patch still tries to remove the pointless trace of IRQ masking,
> such as: replace disable_irq with disable_irq_notrace.
> 
> > occurs, and it's also pointless telling lockdep about the IRQ
> > unmasking when we resume userspace.
> 
> Even it is pointless, but if lockdep doesn't see the IRQ unmasking, the 
> warning "unannotated irqs-on" will be triggered and lockdep doe not work
> any longer, so we have to remove the warning to make lockdep workable on
> ARM, could you agree on it?  It is the main purpose of the patch.

I'm sorry, I think we have a communication issue; you're not understanding
the points that I'm making.  I feel I'm wasting my time trying to explain
it.

I'm not merging your patch as-is because I believe it to be wrong.
