From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 7 Apr 2014 11:33:12 +0100
Subject: disabling MMU of ARMv7-A
In-Reply-To: <20140407095629.GA3951@e103592.cambridge.arm.com>
References: <015e01cf4a55$7f43a950$7dcafbf0$@samsung.com>
 <20140328104349.GG21330@arm.com>
 <20140407095629.GA3951@e103592.cambridge.arm.com>
Message-ID: <20140407103312.GA7528@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Apr 07, 2014 at 10:56:36AM +0100, Dave Martin wrote:
> Agreed -- CONFIG_MMU=n does not need to imply that the MMU is turned off:
> everything must be indentity-mapped (VA = PA), but it is still desirable
> to define attributes.  For SMP, it's *necessary* to define attributes,
> otherwise we can't guarantee working spinlocks etc.

It's also necessary for UP as well, as the load-exclusive and
store-exclusive must still work.  Remember these instructions get used
for more than just spinlocks.

-- 
FTTC broadband for 0.8mile line: now at 9.7Mbps down 460kbps up... slowly
improving, and getting towards what was expected from it.
