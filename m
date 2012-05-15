From: ben.dooks@codethink.co.uk (Ben Dooks)
Date: Tue, 15 May 2012 16:49:08 +0100
Subject: [PATCH 6/8] arm: mach-armada: add support for Armada XP board
 with device tree
In-Reply-To: <201205151532.21143.arnd@arndb.de>
References: <1337072084-21967-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <20120515165813.66b4434e@skate> <4FB2714F.5080703@codethink.co.uk>
 <201205151532.21143.arnd@arndb.de>
Message-ID: <4FB27AF4.9050604@codethink.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 15/05/12 16:32, Arnd Bergmann wrote:
> On Tuesday 15 May 2012, Ben Dooks wrote:
>>>
>>> Agreed. When looking at the code, I wasn't sure why PCI mappings were
>>> needed so early. Surely, the minimal mappings to get an UART are quite
>>> useful to have very early, but why PCI?
>>
>> I think it was because that PCI was initialised early and requires a
>> large mapping space. It is very likely to be legacy kernel stuff that
>> people have kept copying through.
>>
>
> No, as Rob pointed out, we might not need them early, but we definitely
> want a fixed address for the PIO window, which ioremap does not
> provide.

Yes, I can see a not a lot of fun with multiple PCIe busses and the
need for a single IO space. You'll probably have to reserve a VM
area for people to use for legacy-IO accesses.

With PCIe, there should be less old-style IO as PCIe devices are
encouraged to go 32bit MMIO.

-- 
Ben Dooks				http://www.codethink.co.uk/
Senior Engineer				Codethink - Providing Genius
