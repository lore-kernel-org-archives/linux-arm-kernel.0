From: richardcochran@gmail.com (Richard Cochran)
Date: Mon, 27 Jul 2015 13:28:35 +0200
Subject: [PATCH 1/2] gpio: dwapb: Use human understandable gpio numbering.
In-Reply-To: <CACRpkdYUcXjJz+jZ5ZMXK1a7GLi8eL+ecr-yL6Y8901f_-pknQ@mail.gmail.com>
References: <cover.1435777856.git.rcochran@linutronix.de>
 <d6b5ce85a17164970d454583560e07f7aed7b8ca.1435777856.git.rcochran@linutronix.de>
 <CACRpkdY+prqSeohT5BEoOKS6sfXdFTA6ZzuKzH4GSPX5jcjgzA@mail.gmail.com>
 <20150716171930.GB27060@localhost.localdomain>
 <CACRpkdYUcXjJz+jZ5ZMXK1a7GLi8eL+ecr-yL6Y8901f_-pknQ@mail.gmail.com>
Message-ID: <20150727112835.GA5617@localhost.localdomain>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jul 27, 2015 at 12:19:08PM +0200, Linus Walleij wrote:
> On Thu, Jul 16, 2015 at 7:19 PM, Richard Cochran
> > This happens with every DT discussion that tries to make things
> > logical for the end user.
> 
> Are you assuming bad faith?

No, I was reacting to the NAK (which I can accept) that does not
address or even acknowledge the problem (which I cannot accept so
easily).

But now that a solution has appeared, I am happy again.

> I think Michael made a very very nice patch series trying to make
> things logical for end users, please participate in that discussion.

Yes, I read it, and it sounds like it will solve the problem.  I will
give the series a try...
 
> > Isn't there a mapping interface for irq numbers?
> 
> I don't see what you mean here. The numbers that appear in
> say /proc/interrupts may seem stable but they are not.
> They depend on things like probe order between irqchips
> and can change between two boots.
> 
> The reason users don't have an issue with it is that there is
> (thank god) no userspace ABI for interrupts.

I was talking about CONFIG_IRQ_DOMAIN_DEBUG.
 
> The problem is for example if I have a SoC with a GPIO expander:
> both have a GPIO line named "0". Which one wins? The SoC
> because it is "more important"? This issue is all over the place
> in any modern chipset. In Ux500 I have sometimes three GPIO
> expanders, all three with GPIO line 0, and also a GPIO 0 on
> the SoC of course. So we need to express this complexity to
> userspace, not try to simplify the world.

Thanks for the explanation.  Of course I don't want an arbitrarily
simplified interface, but I can't understand why the simple case of
built-in SoC GPIOs must have such a weird and variable numbering
patterns.

But once user space can call GPIOs by name, then it doesn't matter
anymore what the kernel numbers are.

Thanks,
Richard
