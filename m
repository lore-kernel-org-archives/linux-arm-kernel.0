From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 28 Jul 2010 22:21:56 +0100
Subject: [PATCH 1/2] arm: msm: Add System MMU support.
In-Reply-To: <201007281950.20847.arnd@arndb.de>
References: <1280270466-13503-1-git-send-email-stepanm@codeaurora.org>
	<201007281039.44883.arnd@arndb.de>
	<ea4bbdecc271f7fa5749d09645f38c0d.squirrel@www.codeaurora.org>
	<201007281950.20847.arnd@arndb.de>
Message-ID: <20100728212156.GA6729@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jul 28, 2010 at 07:50:20PM +0200, Arnd Bergmann wrote:
> The DMA API is extremely flexible, it works just fine with all the
> IOMMUs that I've seen so far. Please take a look at
> include/asm-generic/dma-mapping-common.h and its users to see how
> to use multiple IOMMUs depending on the device.

We don't yet use those DMA API interface extensions because we haven't
had the need.  If someone who has the need wants to put the effort in
though...

One of the problems with it though is the abstraction of the sync*
operations is the wrong way around for stuff like dmabounce - we want
to be passed the base address of the buffer (so we can look this up),
plus offset and length.  We don't want to know just the region which
is affected.
