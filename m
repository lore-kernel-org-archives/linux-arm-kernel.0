From: horms@verge.net.au (Simon Horman)
Date: Thu, 1 Mar 2018 10:44:34 +0100
Subject: [PATCH v6 01/26] ARM: shmobile: Add watchdog support
In-Reply-To: <1519839622-6109-1-git-send-email-fabrizio.castro@bp.renesas.com>
References: <CAMuHMdUx3A_8MeZmrwiBRqUS0oGjwrg13fy1QMsA2SUw+dR0Hg@mail.gmail.com>
 <1519839622-6109-1-git-send-email-fabrizio.castro@bp.renesas.com>
Message-ID: <20180301094434.tnk5uxlbkhv6pcb7@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Feb 28, 2018 at 05:40:22PM +0000, Fabrizio Castro wrote:
> On R-Car Gen2 and RZ/G1 platforms, we use the SBAR registers to make non
> boot CPUs run a routine designed to bring up SMP and deal with hot plug.
> The value contained in the SBAR registers is not initialized by a WDT
> triggered reset, which means that after a WDT triggered reset we jump
> to the SMP bring up routine, preventing the system from executing the
> bootrom code.
> 
> The purpose of this patch is to jump to the bootrom code in case of a
> WDT triggered reset, and keep the SMP functionality untouched.
> In order to tell if the code had been called due to the WDT overflowing
> we are testing WOVF from register RWTCSRA.
> 
> The new function shmobile_boot_vector_gen2 isn't replacing
> shmobile_boot_vector for backward compatibility reasons. The kernel
> will install the best option (either shmobile_boot_vector or
> shmobile_boot_vector_gen2) to ICRAM1 after parsing the device tree,
> according to the amount of memory available.
> 
> Since shmobile_boot_vector has become bigger, "reg" property of nodes
> compatible with "renesas,smp-sram" now need to be set to a value
> greater or equal to "<0 0x60>".
> 
> Signed-off-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
> Signed-off-by: Ramesh Shanmugasundaram <ramesh.shanmugasundaram@bp.renesas.com>

Thanks, I have marked this as deferred as I would like dependencies to
be merged first.
