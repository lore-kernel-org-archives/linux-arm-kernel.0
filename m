From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 8 Apr 2015 19:10:59 +0100
Subject: [PATCH 5/6] ARM: re-implement physical address space switching
In-Reply-To: <20150408163428.3905e7e3@free-electrons.com>
References: <20150408094438.GM12732@n2100.arm.linux.org.uk>
 <E1YfmY6-0006X3-1N@rmk-PC.arm.linux.org.uk>
 <20150408163428.3905e7e3@free-electrons.com>
Message-ID: <20150408181059.GQ12732@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Apr 08, 2015 at 04:34:28PM +0200, Thomas Petazzoni wrote:
> But since I'm not going to write an e-mail just for such a small nit,
> here is an hopefully more interesting question: do you think it would
> be possible to use this logic for my Armada 370/XP/375/38x case, where
> I need some specific page table configuration to be able to use HW I/O
> coherency in non-SMP configurations?

This implementation only handles LPAE, and it only knows to add an
offset to each LPAE page table descriptor.  So, adapting this code
to that application isn't going to be easy, because you're talking
about setting and/or clearing some bits.

So, I think it would take a re-implementation of it to make it work.
Once the review comments have been addressed, at least this gives an
idea how to address the coherency issue there.

-- 
FTTC broadband for 0.8mile line: currently at 10.5Mbps down 400kbps up
according to speedtest.net.
