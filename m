From: hch@infradead.org (Christoph Hellwig)
Date: Mon, 12 Nov 2018 00:34:22 -0800
Subject: [RFC PATCH 01/13] arm: Fix mutual exclusion in arch_gettimeoffset
In-Reply-To: <d1559db8eddb5b06747b152ae69b63c3aa66ed09.1541995959.git.fthain@telegraphics.com.au>
References: <cover.1541995959.git.fthain@telegraphics.com.au>
 <d1559db8eddb5b06747b152ae69b63c3aa66ed09.1541995959.git.fthain@telegraphics.com.au>
Message-ID: <20181112083422.GA19695@infradead.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Nov 12, 2018 at 03:12:39PM +1100, Finn Thain wrote:
> Implementations of arch_gettimeoffset are generally not re-entrant
> and assume that interrupts have been disabled. Unfortunately this
> pre-condition got broken in v2.6.32.
> 
> Fixes: 5cfc8ee0bb51 ("ARM: convert arm to arch_gettimeoffset()")
> Signed-off-by: Finn Thain <fthain@telegraphics.com.au>

This looks like a sensible fix for -stable backporting.  But with m68k
converted over it might be time for these two arm platforms to either
be converted to the clocksource API or to be dropped..
