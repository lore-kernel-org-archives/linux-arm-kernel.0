From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 24 Jul 2012 14:18:54 +0000
Subject: [GIT PULL] io.h clean-up for PCI
In-Reply-To: <500EA251.1090000@gmail.com>
References: <50049285.1060100@gmail.com> <201207241243.55640.arnd@arndb.de>
 <500EA251.1090000@gmail.com>
Message-ID: <201207241418.54637.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 24 July 2012, Rob Herring wrote:
> How is mem_offset supposed to be set? Generally memory is setup as cpu
> base paddr = pci mem addr, so mem_offset should be 0? But integrator is
> set to the cpu paddr, and it works.

I don't really know. I would assume that setting mem_offset to something
other than 0 means your bus address space is not the same as the cpu
address space. The window that is usable by PCI should be specified
in the memory resource, not using the mem_offset, but I could be
interpreting that incorrectly.

	Arnd
