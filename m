From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 22 Feb 2012 09:09:30 +0000
Subject: [PATCHv22 14/16] X86: integrate CMA with DMA-mapping subsystem
In-Reply-To: <20120221161802.f6a28085.akpm@linux-foundation.org>
References: <1329507036-24362-1-git-send-email-m.szyprowski@samsung.com>
 <1329507036-24362-15-git-send-email-m.szyprowski@samsung.com>
 <20120221161802.f6a28085.akpm@linux-foundation.org>
Message-ID: <20120222090930.GS22562@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Feb 21, 2012 at 04:18:02PM -0800, Andrew Morton wrote:
> After a while I got it to compile for i386.  arm didn't go so well,
> partly because arm allmodconfig is presently horked (something to do
> with Kconfig not setting PHYS_OFFSET) and partly because arm defconfig
> doesn't permit CMA to be set.  Got bored, gave up.

That's not going to get fixed, unfortunately.  It requires us to find
some way to force various options to certain states on all*config
builds, because not surprisingly a value of 'y', 'm' or 'n' doesn't
work for integer or hex config options.

So the only way all*config can be used on ARM is with a seed config file
to force various options to particular states to ensure that we end up
with a sane configuration that avoids crap like that.

Alternatively, we need a way to tell kconfig that various options are to
be set in certain ways in the Kconfig files for all*config to avoid it
wanting values for hex or int options.
