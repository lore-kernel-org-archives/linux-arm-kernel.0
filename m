From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 15 Sep 2015 23:22:06 +0200
Subject: [RFC PATCH] ARM: enable highmem by default on ARMv6/ARMv7 CPUs
In-Reply-To: <E1Zbx08-0001A3-PQ@rmk-PC.arm.linux.org.uk>
References: <E1Zbx08-0001A3-PQ@rmk-PC.arm.linux.org.uk>
Message-ID: <3759947.Gi7mMFUgb4@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 15 September 2015 21:38:52 Russell King wrote:
> ARMv6 and ARMv7 normally have more than 1G of memory, so it makes sense
> to have highmem enabled by default.  Users can still turn highmem off if
> they wish by enabling the EXPERT option, which then allows the option to
> be visible.
> 
> Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>

I would have guessed that the cost of kmap_atomic (and the
preempt_disable() when CONFIG_PREEMPT is set) is high enough
even for lowmem-only systems that we want this disabled wherever
we can.

Looking through the memory properties of the dts files in the kernel,
my impression is that all ARMv6 and a majority of the currently supported
ARMv7 machines actually have less than 1GB. This is of course changing if you
take into account only the ARMv7 machines that are getting added these
days, but I would drop at least the ARMv6 dependency.

	Arnd
