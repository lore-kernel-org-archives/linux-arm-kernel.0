From: ben.dooks@codethink.co.uk (Ben Dooks)
Date: Tue, 15 May 2012 15:32:36 +0100
Subject: [PATCH 6/8] arm: mach-armada: add support for Armada XP board
 with device tree
In-Reply-To: <20120515161655.504f1403@skate>
References: <1337072084-21967-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <1337072084-21967-7-git-send-email-thomas.petazzoni@free-electrons.com>
 <4FB228AD.5000507@codethink.co.uk> <4FB25A9A.3070306@gmail.com>
 <4FB25FE9.3060209@codethink.co.uk> <20120515161655.504f1403@skate>
Message-ID: <4FB26904.1060308@codethink.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 15/05/12 15:16, Thomas Petazzoni wrote:
> Le Tue, 15 May 2012 14:53:45 +0100,
> Ben Dooks<ben.dooks@codethink.co.uk>  a ?crit :
>
>> Since the two board support files are identical, except for the names
>> they print, I'd say this is the job of one file. It can always be
>> split later.
>
> The initial motivation for keeping two files here is that the two SoC
> have a different number of PCIe memory areas, and those areas are
> typically mapped in ->map_io(). However:

Yes, the number of times I've viewed the kernel and seen very similar
code replicated multiple times tends to make me burst into tears.

>   * Maybe those mappings can be done using a normal ioremap() rather
>     than in ->map_io(), according to DT informations (but most other ARM
>     SoC support at the moment seem to do PCI mappings using static
>     mappings in ->map_io)

That's a very old way of doing it. I'm pretty sure there's no reason to
get these allocated so early.

I believe you can probably leave the PCI/PCIe bindings until you have
enough kernel state to do ioremap() or similar and then associate the
necessary mappings with the bus creation.

>   * We probably shouldn't have anticipated this too much, and keep only
>     one file for this initial submission.

Yes, the less we need to review the better.

> We'll rework this for our v2.

Great.

> Thanks for the comments!

I'll get to testing this kernel soon, and report back

> Thomas


-- 
Ben Dooks				http://www.codethink.co.uk/
Senior Engineer				Codethink - Providing Genius
