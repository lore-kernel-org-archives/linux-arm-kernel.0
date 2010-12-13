From: adharmap@codeaurora.org (Abhijeet Dharmapurikar)
Date: Mon, 13 Dec 2010 09:23:29 -0800
Subject: [PATCH 0/5] ARM: GIC: cleanup
In-Reply-To: <20101205113311.GC9138@n2100.arm.linux.org.uk>
References: <20101205113311.GC9138@n2100.arm.linux.org.uk>
Message-ID: <4D065691.9010802@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Sorry for being late on testing this out. The patch series and works on 
the msm 8660.

Acked-By: Abhijeet Dharmapurikar <adharmap@codeaurora.org>


Russell King - ARM Linux wrote:
> This patch series cleans up the GIC code, consolidating some of the
> per-platform practices into the common GIC code.
> 
> One notable change is to the initialization methods - we used to
> require platforms to pass in the address of the per-CPU interfaces
> despite them always being identical between all cores.  This was
> nonsense, as even in the extremely unlikely event that they were
> different, we aren't storing them in a per-CPU manner.
> 
> The GIC initialization methods are now simpler: one call to gic_init()
> from the boot CPU, and a call to gic_secondary_init() as each
> secondary CPU starts - and no need for platforms to keep track of
> the address anymore.

--
"Sent by an employee of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum."
