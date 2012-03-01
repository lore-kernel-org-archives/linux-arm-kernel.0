From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 1 Mar 2012 14:08:17 +0000
Subject: [PATCH v2 19/28] ARM: Add fixed PCI i/o mapping
In-Reply-To: <201203011352.36067.arnd@arndb.de>
References: <1330547147-22867-1-git-send-email-robherring2@gmail.com>
 <201202292243.13923.arnd@arndb.de>
 <20120229232154.GG16999@n2100.arm.linux.org.uk>
 <201203011352.36067.arnd@arndb.de>
Message-ID: <20120301140817.GG7363@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Mar 01, 2012 at 01:52:35PM +0000, Arnd Bergmann wrote:
> Ok. I've looked up the manual for IOP134x and it's very clear there that
> it has only two 64k I/O windows but no more (developer manual, sections
> 2.2.2.1 and 3.3.2.1). Limiting the virtual space to 64k would result in
> seeing only one of the buses, but 1 MB is enough if we map both buses
> in there.

I think it was the 80312, and the manual does limit the window to 64k.

I did try shifting the PCI bus IO base for outbound transactions to
zero, and although the PCI BAR setup and bridge setup was correct, the
peripherals would not respond.  (That's because I've always hated the
way these buses are setup, mapping their PCI spaces at the physical
address location.)

I came to the conclusion that there was an undocumented problem which
meant that it doesn't work.
