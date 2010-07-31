From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Sat, 31 Jul 2010 15:36:27 +0100
Subject: [PATCH] ARM: update show_interrupts for online cpu's only
In-Reply-To: <1280585333-4870-1-git-send-email-santosh.shilimkar@ti.com>
References: <1280585333-4870-1-git-send-email-santosh.shilimkar@ti.com>
Message-ID: <20100731143627.GC27064@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Jul 31, 2010 at 07:38:53PM +0530, Santosh Shilimkar wrote:
> Even after CPUx is logically offline, it's interrupt are displayed
> in proc entry
> 
> This patch fixes the same by use of 'for_each_online_cpu' instead
> of 'for_each_present_cpu' in 'show_interrupts' function

What's the synchronisation mechanism between CPUs being brought on or
offline and this file being read?

I believe we have a more dynamic approach to CPU hotplug (using it for
dynamic power saving) than x86, so I believe hotplug events can happen
more often on ARM.
