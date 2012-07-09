From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 9 Jul 2012 16:28:37 +0000
Subject: [PATCH 00/15] PCI io.h cleanups
In-Reply-To: <1341600040-30993-1-git-send-email-robherring2@gmail.com>
References: <1341600040-30993-1-git-send-email-robherring2@gmail.com>
Message-ID: <201207091628.37975.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 06 July 2012, Rob Herring wrote:
> From: Rob Herring <rob.herring@calxeda.com>
> 
> I've finally gotten back to this after several months. This is the 2nd
> part of mach/io.h removals. This series removes io.h on platforms with
> PCI by creating a fixed virtual I/O mapping and a common __io() macro.
> 
> As several platforms have 2 1MB I/O windows, I've changed the fixed
> mapping to 2MB (vs. 1MB in the prior posting) and allow platforms to
> control the size. This also allows using a single 1MB section mapping
> rather than 4KB pages.

Looks really good, feel free to add my Reviewed-by on patches 2-15, since
I've done a line-by-line walkthrough and could not find anything besides the
trivial comments I gave.

> I've only tested versatilepb under qemu, so any testing is appreciated.
> iop3xx and mv78xx0 have some risk of breaking as the PCI bus addresses
> are moved to 0 from matching the cpu host bus addesss.

Did you try running any devices that actually use I/O space in qemu?
I think there are plenty of devices that you could use for testing that.

	Arnd
