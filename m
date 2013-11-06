From: jason@lakedaemon.net (Jason Cooper)
Date: Wed, 6 Nov 2013 15:55:56 -0500
Subject: [PATCH 0/2] ARM: mvebu: fix DT def. of PCIe units for mv78230
 and mv78260
In-Reply-To: <20131106183724.GB25879@obsidianresearch.com>
References: <cover.1383681717.git.arno@natisbad.org>
 <87y551bdnx.fsf@natisbad.org> <20131106192233.3599d256@skate>
 <20131106183724.GB25879@obsidianresearch.com>
Message-ID: <20131106205556.GH8308@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Jason,

On Wed, Nov 06, 2013 at 11:37:24AM -0700, Jason Gunthorpe wrote:
...
> This PCI stuff would be 100% more readable with some macros ..
> 
> #define PCI_REG_BDF(bus,device,function) (....)
> #define PCI_MEM_BAR_BDF(bus,device,function,bar) \
>    (0x82000000 | PCI_REG_BDF(bus,device,function) + bar*XX) 0)
> 
> So that:
>  reg = <PCI_REG_BDF(0,1,0) 0 0>
>  assigned-addresses = <PCI_MEM_BAR_BDF(0,1,0,0)  0x40000  0 0x2000>

Do I smell a patch brewing?  :)

Arnaud, would you like to take a crack at it?

thx,

Jason.
