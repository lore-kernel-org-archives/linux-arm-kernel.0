From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 2 Sep 2010 11:55:45 +0100
Subject: [PATCH 1/4] ARM: hw-breakpoint: add mechanism for hooking into
	prefetch aborts
In-Reply-To: <1282578897-23247-2-git-send-email-will.deacon@arm.com>
References: <1282578897-23247-1-git-send-email-will.deacon@arm.com>
	<1282578897-23247-2-git-send-email-will.deacon@arm.com>
Message-ID: <20100902105545.GU26319@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Aug 23, 2010 at 04:54:54PM +0100, Will Deacon wrote:
> On ARM processors with hardware breakpoint and watchpoint support,
> triggering these events results in a debug exception. These manifest
> as prefetch and data aborts respectively.
> 
> arch/arm/mm/fault.c already provides hook_fault_code for hooking
> into data aborts dependent on the DFSR. This patch adds a new function,
> hook_ifault_code for hooking into prefetch aborts in the same manner.
> 
> Cc: Russell King - ARM Linux <linux@arm.linux.org.uk>
> Cc: Frederic Weisbecker <fweisbec@gmail.com>
> Cc: S. Karthikeyan <informkarthik@gmail.com>
> Signed-off-by: Will Deacon <will.deacon@arm.com>

Ok.  (please drop my cc: when committing.)
