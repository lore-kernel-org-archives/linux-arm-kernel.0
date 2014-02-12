From: jgunthorpe@obsidianresearch.com (Jason Gunthorpe)
Date: Wed, 12 Feb 2014 15:28:25 -0700
Subject: [PATCH v2 2/3] ARM: bios32: use pci_enable_resource to enable
 PCI resources
In-Reply-To: <1392236171-10512-3-git-send-email-will.deacon@arm.com>
References: <1392236171-10512-1-git-send-email-will.deacon@arm.com>
 <1392236171-10512-3-git-send-email-will.deacon@arm.com>
Message-ID: <20140212222825.GC17248@obsidianresearch.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Feb 12, 2014 at 08:16:10PM +0000, Will Deacon wrote:
> This patch moves bios32 over to using the generic code for enabling PCI
> resources. Since the core code takes care of bridge resources too, we
> can also drop the explicit IO and MEMORY enabling for them in the arch
> code.

Tested-By: Jason Gunthorpe <jgunthorpe@obsidianresearch.com> (on Kirkwood)

PCI: bus1: Fast back to back transfers disabled
pci_bus 0000:01: busn_res: [bus 01-ff] end is updated to 01
pci 0000:00:01.0: BAR 8: assigned [mem 0xe0000000-0xe00fffff]
pci 0000:01:00.0: BAR 0: assigned [mem 0xe0000000-0xe001ffff]
pci 0000:00:01.0: PCI bridge to [bus 01]
pci 0000:00:01.0:   bridge window [mem 0xe0000000-0xe00fffff]
pci 0000:00:01.0: enabling device (0140 -> 0142)

Jason
