From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 25 Feb 2015 17:02:50 +0000
Subject: [RFC PATCH] arm: asm/cmpxchg.h: Add support half-word xchg()
In-Reply-To: <3465519.0ga9zC7F7b@wuerfel>
References: <1424878581-11701-1-git-send-email-bobby.prani@gmail.com>
 <3465519.0ga9zC7F7b@wuerfel>
Message-ID: <20150225170250.GD8656@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Feb 25, 2015 at 04:58:35PM +0100, Arnd Bergmann wrote:
> On Wednesday 25 February 2015 10:36:20 Pranith Kumar wrote:
> > This patch adds support for a half-word xchg() for ARM using ldrexh/strexh
> > instructions. It also fixes an asm comment  for __cmpxchg2.
> > 
> > Currently using a half-word xchg() results in the following splat on an ARMv7
> > machine.
> > 
> > [   45.833303] xchg: bad data size: pc 0xbe806020, ptr 0xeb18deee, size 2
> > [   45.833324] ------------[ cut here ]------------
> > [   45.837939] kernel BUG at /dvs/git/dirty/git-master_linux/kernel/arch/arm/kernel/traps.c:727!
> > 
> > Signed-off-by: Pranith Kumar <bobby.prani@gmail.com>
> 
> Unfortunately, the BUG message seems incomplete, can you reproduce this
> with CONFIG_DEBUG_BUGVERBOSE enabled?

That isn't because CONFIG_DEBUG_BUGVERBOSE isn't set.  It's because
the message author decided that the remainder of the kernel bug message
wasn't useful to report.  After all, it's just a load of hex numbers
and symbolic information.  Who would want that junk.

(Some people really don't get this: we print stuff from the kernel
because it gives _us_ useful information to debug problems like this,
but because they don't understand it themselves, they decide they can
omit it from their bug reports...)

-- 
FTTC broadband for 0.8mile line: currently at 10.5Mbps down 400kbps up
according to speedtest.net.
