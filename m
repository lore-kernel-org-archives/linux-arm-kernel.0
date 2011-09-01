From: msalter@redhat.com (Mark Salter)
Date: Thu, 01 Sep 2011 15:14:18 -0400
Subject: [PATCH 0/3] RFC: addition to DMA API
In-Reply-To: <20110901173149.GE2803@e102144-lin.cambridge.arm.com>
References: <CACVXFVOT9FZexiZhuJtvyFP8qOPYUKg0JqGarBJgT4R8SN7p5Q@mail.gmail.com>
	<Pine.LNX.4.44L0.1109011127080.1896-100000@iolanthe.rowland.org>
	<20110901160429.GA15814@n2100.arm.linux.org.uk>
	<20110901173149.GE2803@e102144-lin.cambridge.arm.com>
Message-ID: <1314904459.1439.24.camel@deneb.redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 2011-09-01 at 18:31 +0100, Will Deacon wrote:
> I don't think what we're seeing in this case is caused by mismatched memory
> attributes, especially as passing `nosmp' on the command-line makes the
> performance issue disappear.

I'm coming to think we are dealing with two different problems.

We have the original problem where adding the write buffer flush
to EHCI gives a 4x performance boost to USB. Also adding nosmp to
the cmdline gives pretty much the same boost. This is looking like
something other than just data getting held up in a write buffer.

On the other hand, on a nosmp kernel, I get about 3-4% performance
boost for hdparm -t using the write buffer flush patch vs. without
it.

So, regardless of what turns out to be the actual cause of the 4x
problem, it may still be worthwhile to have the explicit write
buffer sync API if we can't avoid using buffered mappings for DMA.

--Mark
