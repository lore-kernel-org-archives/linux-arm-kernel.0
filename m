From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 15 Feb 2011 10:50:50 +0000
Subject: [PATCH 2/6] ARM: pm: add generic CPU suspend/resume support
In-Reply-To: <AANLkTi=JF1c-aFHpSZ-XECLEPSMsFihXT+w3=NXdYn8L@mail.gmail.com>
References: <20110211161626.GA31356@n2100.arm.linux.org.uk>
	<E1Pnvgw-0002yZ-M0@rmk-PC.arm.linux.org.uk>
	<AANLkTi=6zLxGxabBE4-+qGyRt7-219KE=4CB0jf9D=LG@mail.gmail.com>
	<AANLkTi=JF1c-aFHpSZ-XECLEPSMsFihXT+w3=NXdYn8L@mail.gmail.com>
Message-ID: <20110215105050.GA11199@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Feb 14, 2011 at 08:11:23PM -0800, Colin Cross wrote:
> Even with a cache flush, cpu_resume_turn_on_mmu fails because the page
> table modification, done with the cache off, ends up in memory, but
> the L2 contains the old value.  When the MMU and cache are enabled,
> the 1:1 mapping disappears.  The page table would need to be
> invalidated during suspend.
> 
> I can avoid the problem entirely by leaving the MMU on and skipping
> cpu_resume when the CPU does not go through reset.

If you're not losing CPU state, what's the point in calling the suspend
function?  It's purpose is to save CPU state ready for the CPU going to
sleep and losing power, and restoring that state when the CPU wakes up
sometime later.
