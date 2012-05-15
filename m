From: ben.dooks@codethink.co.uk (Ben Dooks)
Date: Tue, 15 May 2012 16:07:59 +0100
Subject: [PATCH 6/8] arm: mach-armada: add support for Armada XP board
 with device tree
In-Reply-To: <20120515165813.66b4434e@skate>
References: <1337072084-21967-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <1337072084-21967-7-git-send-email-thomas.petazzoni@free-electrons.com>
 <4FB228AD.5000507@codethink.co.uk> <4FB25A9A.3070306@gmail.com>
 <4FB25FE9.3060209@codethink.co.uk> <20120515161655.504f1403@skate>
 <4FB26904.1060308@codethink.co.uk> <20120515165813.66b4434e@skate>
Message-ID: <4FB2714F.5080703@codethink.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 15/05/12 15:58, Thomas Petazzoni wrote:
> Le Tue, 15 May 2012 15:32:36 +0100,
> Ben Dooks<ben.dooks@codethink.co.uk>  a ?crit :
>
>> Yes, the number of times I've viewed the kernel and seen very similar
>> code replicated multiple times tends to make me burst into tears.
>>
>>>    * Maybe those mappings can be done using a normal ioremap() rather
>>>      than in ->map_io(), according to DT informations (but most
>>> other ARM SoC support at the moment seem to do PCI mappings using
>>> static mappings in ->map_io)
>>
>> That's a very old way of doing it. I'm pretty sure there's no reason
>> to get these allocated so early.
>>
>> I believe you can probably leave the PCI/PCIe bindings until you have
>> enough kernel state to do ioremap() or similar and then associate the
>> necessary mappings with the bus creation.
>
> Agreed. When looking at the code, I wasn't sure why PCI mappings were
> needed so early. Surely, the minimal mappings to get an UART are quite
> useful to have very early, but why PCI?

I think it was because that PCI was initialised early and requires a
large mapping space. It is very likely to be legacy kernel stuff that
people have kept copying through.

-- 
Ben Dooks				http://www.codethink.co.uk/
Senior Engineer				Codethink - Providing Genius
