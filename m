From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 21 Sep 2015 17:13:41 +0100
Subject: Steps to submit a new arch/arm port
In-Reply-To: <56001B78.2090001@free.fr>
References: <56001B78.2090001@free.fr>
Message-ID: <20150921161341.GP21084@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Sep 21, 2015 at 05:00:08PM +0200, Mason wrote:
> 1) Linux kernel runs in non-secure world. The port used to tweak
> L2 cache configuration via custom SMC calls to the OS running in
> secure world. I've removed that for now.
> Is there a standard solution these days?

While some configuration can be done by the boot loader (and it's
preferable for that to happen) not all of it can be.  In particular,
the kernel _must_ have the ability to enable and disable the L2
cache, and the kernel must not be called with the L2 cache left
enabled by the boot loader.

That requires that the L2 control register is writable in some way
from the non-secure world.

-- 
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
