From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 26 Mar 2013 22:04:05 +0000
Subject: [RFCv1 07/11] irqchip: armada-370-xp: add MSI support to
 interrupt controller driver
In-Reply-To: <20130326215546.GA8650@obsidianresearch.com>
References: <1364316746-8702-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <20130326221654.34bce6d7@skate> <20130326215546.GA8650@obsidianresearch.com>
Message-ID: <201303262204.05546.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 26 March 2013, Jason Gunthorpe wrote:
> > I'll let Arnd answer this one, but I'm pretty sure that using IRQ
> > domains is the way to go. The fact that a number of drivers don't yet
> > use IRQ domains is maybe just because they haven't been converted yet.
> 
> Maybe, but they have irq domain code as well.. I'm curious about the
> answer too :)

To expand on my previous answer: irq_alloc_descs can require a lot of
memory if you have a lot of MSIs. If the driver only has 16 MSIs,
there is probably no reason to not assign all of them at once, but if
you have 2048 MSIs, creating the mapping only when you need it is
much more space efficient.

	Arnd
