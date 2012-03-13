From: khc@pm.waw.pl (Krzysztof Halasa)
Date: Tue, 13 Mar 2012 22:15:29 +0100
Subject: [PATCH] ARM: remove ixp2000 platform
In-Reply-To: <4F5D39D1.4050000@snapgear.com> (Greg Ungerer's message of "Mon,
 12 Mar 2012 09:48:33 +1000")
References: <1330450426-14639-1-git-send-email-robherring2@gmail.com>
 <201202281945.39419.arnd@arndb.de>
 <alpine.LFD.2.02.1203052035170.31242@xanadu.home>
 <201203061412.00073.arnd@arndb.de>
 <alpine.LFD.2.02.1203061146210.31242@xanadu.home>
 <CACRpkdYQpnSMVWUizEYHTjx_AK5Ai7dos0SBd208Wf5ZJLdrCw@mail.gmail.com>
 <20120307091409.GL17370@n2100.arm.linux.org.uk>
 <4F574C64.7010905@snapgear.com> <m3aa3nqpxz.fsf@intrepid.localdomain>
 <4F5D39D1.4050000@snapgear.com>
Message-ID: <m3sjhcdwy6.fsf@intrepid.localdomain>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Greg Ungerer <gerg@snapgear.com> writes:

>> The problematic one is IXP42x rev. A0. It has no support for hw mixed
>> mode (LE core + lane swapping where needed). Unfortunately this early
>
> It is not problematic if you are running your core BE right?

Right.
Of course it requires lane-swapping between PCI and the core/RAM. The
chip is set to hardware swap these accesses (block transfers and binary
structure layouts are correct, including bus master transfers) and
integer data (mostly u16/u32) are swapped again by the core
(readl/writel, also in-memory descriptors etc). All other peripherals
are always BE (NPE net coprocessors, EXP bus).

This all works fine on all revisions including the IXP425-A0.
-- 
Krzysztof Halasa
