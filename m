From: jamie@shareable.org (Jamie Lokier)
Date: Wed, 17 Mar 2010 04:34:57 +0000
Subject: mapping uncached memory
In-Reply-To: <20100316235422.GC13948@n2100.arm.linux.org.uk>
References: <57314e841003161617l53dc3a50la969369f0161ccdd@mail.gmail.com>
	<20100316235422.GC13948@n2100.arm.linux.org.uk>
Message-ID: <20100317043457.GA31847@shareable.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Russell King - ARM Linux wrote:
> Note that the whole "DMA to user mapped pages" issue is a _big_ can of
> worms and doesn't appear to have any sane and non-expensive solutions.

I'm still worried about whether this means certain programs,
especially well-known open source databases, are broken on some ARMs
when they use O_DIRECT file access.

Fyi, O_DIRECT is flag to open(), mostly used by databases and programs
like QEMU, and sometimes from scripts using "dd oflag=direct" and "dd
iflag=direct".

It tells the kernel that reads and writes are to bypass the page
cache.  That causes DMA to happen between the userspace buffers given
to read() and write(), and the disk interface.

Unfortunately, this isn't some obscure specialised driver interface :-(

-- Jamie
