From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Sun, 29 May 2011 23:35:57 +0100
Subject: ep93xx: status/future of the sparsemem support
In-Reply-To: <20110529130644.GI16318@ibawizard.net>
References: <20110529130644.GI16318@ibawizard.net>
Message-ID: <20110529223557.GC5576@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, May 29, 2011 at 03:06:44PM +0200, Petr ?tetiar wrote:
> I would like to ask about the status or plans for the sparsemem support on the
> ep93xx. I'm mainly talking about the ts72xx here as I don't have any other
> boards, but it seems, that sparsemem is the must for the boards with more then
> one memory bank. Or it's not true?

Have you tried enabling highmem?

One of the problems with this kind of physical memory layout is that it
doesn't allow mathematical offsets between physical and virtual address
spaces.  Consider 0x00000000 phys -> 0xc0000000 virt, so 0xe0000000
phys -> 0xa0000000 virt which will be in userspace!

So we either have to play stupid games with the translation functions and
introduce non-linear translations (as per my message which you pointed to),
or go the highmem route which avoids the issue entirely.
