From: arno@natisbad.org (Arnaud Ebalard)
Date: Wed, 06 Nov 2013 22:32:57 +0100
Subject: [PATCH 0/2] ARM: mvebu: fix DT def. of PCIe units for mv78230 and
 mv78260
In-Reply-To: <20131106205556.GH8308@titan.lakedaemon.net> (Jason Cooper's
 message of "Wed, 6 Nov 2013 15:55:56 -0500")
References: <cover.1383681717.git.arno@natisbad.org>
 <87y551bdnx.fsf@natisbad.org> <20131106192233.3599d256@skate>
 <20131106183724.GB25879@obsidianresearch.com>
 <20131106205556.GH8308@titan.lakedaemon.net>
Message-ID: <87ob5xqkqe.fsf@natisbad.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Jason,

Jason Cooper <jason@lakedaemon.net> writes:

> On Wed, Nov 06, 2013 at 11:37:24AM -0700, Jason Gunthorpe wrote:
> ...
>> This PCI stuff would be 100% more readable with some macros ..
>> 
>> #define PCI_REG_BDF(bus,device,function) (....)
>> #define PCI_MEM_BAR_BDF(bus,device,function,bar) \
>>    (0x82000000 | PCI_REG_BDF(bus,device,function) + bar*XX) 0)
>> 
>> So that:
>>  reg = <PCI_REG_BDF(0,1,0) 0 0>
>>  assigned-addresses = <PCI_MEM_BAR_BDF(0,1,0,0)  0x40000  0 0x2000>
>
> Do I smell a patch brewing?  :)
>
> Arnaud, would you like to take a crack at it?

My understanding of the topic being in the end limited to what I learnt
from recent discussions, I'll pass on that one but I'll be happy to test
on a mv78230.

Cheers,

a+
