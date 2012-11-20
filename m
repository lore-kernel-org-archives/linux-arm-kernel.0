From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Tue, 20 Nov 2012 18:07:59 +0100
Subject: [PATCH V4 5/5] arm: mvebu: Added SMP support for Armada XP
In-Reply-To: <20121120170127.GE27765@mudshark.cambridge.arm.com>
References: <1353357360-7242-1-git-send-email-gregory.clement@free-electrons.com>
 <1353357360-7242-6-git-send-email-gregory.clement@free-electrons.com>
 <20121120164058.GB27765@mudshark.cambridge.arm.com>
 <50ABB499.6090508@free-electrons.com>
 <20121120170127.GE27765@mudshark.cambridge.arm.com>
Message-ID: <20121120180759.27df512f@skate>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Will Deacon,

On Tue, 20 Nov 2012 17:01:27 +0000, Will Deacon wrote:

> > I prefer to keep them separate, as we can use coherency without SMP.
> > That's why I create the coherency_ll.S file instead of putting
> > everything in this file.
> 
> Hmm, can you elaborate a bit more on coherency without SMP please? Do
> these controls also affect IO coherency?

The coherency unit does coherency between CPUs, but also between the
CPU and the devices for DMA. So for example the MV78230 is a single-core
variant of the Armada XP, so having CONFIG_SMP for it is useless, but
you still want the CPU to join the coherency fabric in order to provide
coherency with I/O.

Thanks to the coherency unit, we have an almost DMA coherent
architecture (see the HW I/O coherency patches from Gr?gory for
details).

Thomas
-- 
Thomas Petazzoni, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
