From: santosh.shilimkar@ti.com (Santosh Shilimkar)
Date: Thu, 10 Oct 2013 09:12:14 -0400
Subject: [PATCH V5] ARM: OMAP5/DRA7: realtime_counter: Configure CNTFRQ
 register
In-Reply-To: <1381391028-4189-1-git-send-email-r.sricharan@ti.com>
References: <1381391028-4189-1-git-send-email-r.sricharan@ti.com>
Message-ID: <5256A7AE.6000605@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 10 October 2013 03:43 AM, Sricharan R wrote:
> From: R Sricharan <r.sricharan@ti.com>
> 
> The realtime counter called master counter, produces the count
> used by the private timer peripherals in the MPU_CLUSTER. The
> CNTFRQ per cpu register is used to denote the frequency of the counter.
> Currently the frequency value is passed from the
> DT file, but this is not scalable when we have other non-DT guest
> OS. This register must be set to the right value by the
> secure rom code. Setting this register helps in propagating the right
> frequency value across OSes.
> 
> More discussions and the reason for adding this in a non-DT
> way can be seen from below.
> http://www.mail-archive.com/linux-omap at vger.kernel.org/msg93832.html
> 
> So configuring this secure register for all the cpus here.
> 
> Cc: Santosh Shilimkar <santosh.shilimkar@ti.com>
> Cc: Nishanth Menon <nm@ti.com>
> Cc: Rajendra Nayak <rnayak@ti.com>
> Cc: Marc Zyngier <marc.zyngier@arm.com>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: Tony Lindgren <tony@atomide.com>
> Tested-by: Nishanth Menon <nm@ti.com>
> Acked-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
> Signed-off-by: Sricharan R <r.sricharan@ti.com>
> ---
>  [V5] Removed the use of extern variable in omap-smp.c
>       as per suggestion from Santosh Shilimkar <santosh.shilimkar@ti.com>
> 
Thanks for the updates Sricharan. Looks fine now.

Tony, Can you apply this version if you are fine with it.

Regards,
Santosh
