From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 12 Apr 2010 18:32:47 +0100
Subject: [PATCH] ARM: change definition of cpu_relax() for ARM11MPCore
In-Reply-To: <1271093038-31773-1-git-send-email-will.deacon@arm.com>
References: <1271093038-31773-1-git-send-email-will.deacon@arm.com>
Message-ID: <20100412173247.GA3048@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Apr 12, 2010 at 06:23:58PM +0100, Will Deacon wrote:
> This patch changes the definition of cpu_relax() to smp_mb() for ARMv6 cores,
> forcing the write buffer to drain while inside a polling loop on an SMP system.
> If the Kernel is not compiled for SMP support, this will expand to a barrier()
> as before.

Linus asked how expensive (in terms of power rather than performance)
this was; so far that question has remained unanswered.  Can someone
please answer his question?
