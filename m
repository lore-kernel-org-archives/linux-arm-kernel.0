From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 22 Dec 2010 23:14:51 +0000
Subject: PL011 DMA patches
Message-ID: <20101222231451.GA29368@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

... should be winging their way out.  This just supports the TX side
without the RX DMA code, which is something needing some more work.

The PL08x issues are still to be sorted too - one of which is that
having the PL08x unmap the buffer itself (under control of the
DMA_COMPL_* flags) would avoid a few races with this driver doing
that - otherwise we have to move the unmap inside the spinlock for
safety.
