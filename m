From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 30 Jan 2013 09:46:53 +0000
Subject: [PATCH v2 05/27] arm: pci: add a align_resource hook
In-Reply-To: <20130130045655.GE5734@obsidianresearch.com>
References: <1359399397-29729-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <201301291645.08040.arnd@arndb.de>
 <20130130045655.GE5734@obsidianresearch.com>
Message-ID: <201301300946.54040.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 30 January 2013, Jason Gunthorpe wrote:
> > But we normally only assign a 64 KB I/O window to each PCI host bridge.
> > Requiring PCI bridges to be space 64 KB apart would mean that we cannot
> > actually support bridges at all.
> 
> The PCI resource code uses full 32 bit integers when it handles IO
> addresses, so this actually does sort of work out.

However, we only reserve 1 MB (I think) virtual address window for all
I/O spaces of all PCI domains combined, at a fixed location (0xfee00000).
This means we can have at most 16 such windows at run-time. That can
be changed if necessary, but it seems like overkill when in practice
you only need a few bytes at most.

	Arnd
