From: bigeasy@linutronix.de (Sebastian Andrzej Siewior)
Date: Mon, 01 Jul 2013 09:48:43 +0200
Subject: [PATCH] of: Specify initrd location using 64-bit
In-Reply-To: <51CE1F92.3070802@ti.com>
References: <1371775956-16453-1-git-send-email-santosh.shilimkar@ti.com>
 <51C4171C.9050908@linutronix.de> <51C48B5A.2040404@ti.com>
 <51CCA67C.2010803@gmail.com>
 <CACxGe6vOH0sCFVVXrYqD3dbYdOvithVu7-d1cvy5885i8x_Myw@mail.gmail.com>
 <20130628134931.GD21034@game.jcrosoft.org> <51CE1F92.3070802@ti.com>
Message-ID: <51D1345B.8020509@linutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/29/2013 01:43 AM, Santosh Shilimkar wrote:
> 
> Sebastian,
> 
> Apart from waste of 32bit, what is the other concern you
> have ?

You pass a u64 as a physical address which is represented in other
parts of the kernel (for a good reason) by phys_addr_t.

> I really want to converge on this patch because it
> has been a open ended discussion for quite some time. Does
> that really break any thing on x86 or your concern is more
> from semantics of the physical address.
You want to have your code in so you can continue with your work, that
is okay. The other two arguments why u64 here is a good thing was "due
to what I said earlier" and "+1" and I don't have the time to look
that up.

There should be no problems on x86 if this goes in as it is now.

But think about this: What happens if you boot your ARM device without
PAE and your initrd is in the upper region? If you are lucky the kernel
looks at a different place where it also has a read permission, notices
nothing sane is there, writes a message and continues. And if it is not
allowed to read? It is clearly the user's fault for booting a non-PAE
kernel.

> 
> Thanks for help.
> 
> Regards,
> Santosh

Sebastian
