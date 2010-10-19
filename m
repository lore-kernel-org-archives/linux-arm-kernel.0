From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Tue, 19 Oct 2010 16:37:17 +0200
Subject: [patch 00/12] arm: raw_spinlock annotations
In-Reply-To: <20100217125328.791176536@linutronix.de>
References: <20100217125328.791176536@linutronix.de>
Message-ID: <20101019143717.GH11713@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

On Wed, Feb 17, 2010 at 01:19:56PM -0000, Thomas Gleixner wrote:
> Preempt-RT converts spinlocks to sleeping spinlocks, but some
> spinlocks need to be kept as real spinlocks. In 2.6.33 we merged the
> spinlock namespace cleanup which allows us to annotate those
> locks. The lock type is change to raw_spinlock which is the same as a
> common spinlock in !RT kernels.
> 
> The following series is a collection of lock annotations from the
> preempt-rt tree. Please merge into 2.6.34.
Back then I imported these changes in my repo and found them now when
cleaning it up.  I once tried to get them in[1], and Russell answered:

	Thomas asked me about a pull request for his patches, and I said
	no because they're spread across many different mach-*
	directories.  So this isn't helpful.

I don't understand that critism, as apart from "ARM: footbridge: Convert
gpio and led locks to raw_spinlock" most patches (9) only touch a single
file, the others only touch a single lock and fix all callers.  The
footbridge patch admittedly is not that nice, but that's because the
touched lock is used all across the tree.

While cleaning up my repo I refound the patches and rebased them on top
of today's Linus' tree and only needed to fix up the l2x0_lock patch as
in the meantime a new usage hit mainline.

Best regards
Uwe

[1] http://thread.gmane.org/gmane.linux.ports.arm.kernel/74675

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
