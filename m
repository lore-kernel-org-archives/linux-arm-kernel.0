From: rabin@rab.in (Rabin Vincent)
Date: Thu, 8 Sep 2016 12:23:56 +0200
Subject: [PATCH] pstore/core: drop cmpxchg based updates
In-Reply-To: <20160824130935.23110-1-bigeasy@linutronix.de>
References: <20160824130935.23110-1-bigeasy@linutronix.de>
Message-ID: <20160908102356.GA6020@lnxartpec.se.axis.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Aug 24, 2016 at 03:09:35PM +0200, Sebastian Andrzej Siewior wrote:
> I have here a FPGA behind PCIe which exports SRAM which I use for
> pstore. Now it seems that the FPGA no longer supports cmpxchg based
> updates and writes back 0xff?ff and returns the same.  This leads to
> crash during crash rendering pstore useless.
> Since I doubt that there is much benefit from using cmpxchg() here, I am
> dropping this atomic access and use the spinlock based version.
> 
> Cc: Anton Vorontsov <anton@enomsg.org>
> Cc: Colin Cross <ccross@android.com>
> Cc: Kees Cook <keescook@chromium.org>
> Cc: Tony Luck <tony.luck@intel.com>
> Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>

Tested-by: Rabin Vincent <rabinv@axis.com>

This patch is needed for pstore to work on (most?) ARMv7 chips.  See
this thread for details:
https://lkml.kernel.org/g/CABXOdTfT7xMfiBvRuUS1hsVs=q5q2wY1x1Z8oCyyJNFckM0g0A at mail.gmail.com
