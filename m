From: fthain@telegraphics.com.au (Finn Thain)
Date: Tue, 13 Nov 2018 14:39:00 +1100 (AEDT)
Subject: [RFC PATCH 01/13] arm: Fix mutual exclusion in arch_gettimeoffset
In-Reply-To: <20181112083422.GA19695@infradead.org>
References: <cover.1541995959.git.fthain@telegraphics.com.au>
 <d1559db8eddb5b06747b152ae69b63c3aa66ed09.1541995959.git.fthain@telegraphics.com.au>
 <20181112083422.GA19695@infradead.org>
Message-ID: <alpine.LNX.2.21.1811131420150.362@nippy.intranet>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 12 Nov 2018, Christoph Hellwig wrote:

> On Mon, Nov 12, 2018 at 03:12:39PM +1100, Finn Thain wrote:
> > Implementations of arch_gettimeoffset are generally not re-entrant and 
> > assume that interrupts have been disabled. Unfortunately this 
> > pre-condition got broken in v2.6.32.
> > 
> > Fixes: 5cfc8ee0bb51 ("ARM: convert arm to arch_gettimeoffset()")
> > Signed-off-by: Finn Thain <fthain@telegraphics.com.au>
> 
> This looks like a sensible fix for -stable backporting.  But with m68k
> converted over it might be time for these two arm platforms to either
> be converted to the clocksource API or to be dropped..
> 

You could remove the old arch_gettimeoffset API without dropping any 
platforms.

If no-one converts a given platform to the clocksource API it would mean 
that the default 'jiffies' clocksource will get used on that platform.

Clock resolution and timer precision would be degraded, but that might not 
matter.

Anyway, if someone who has this hardware is willing to test a clocksource 
API conversion, they can let me know and I'll attempt that patch.

-- 
