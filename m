From: santosh.shilimkar@ti.com (Santosh Shilimkar)
Date: Wed, 05 Oct 2011 12:33:01 +0530
Subject: [PATCH 0/4] initialize omap SRAM later on with
	__arm_ioremap_exec()
In-Reply-To: <20111005004339.26980.31149.stgit@kaulin.local>
References: <20111005004339.26980.31149.stgit@kaulin.local>
Message-ID: <4E8C0125.1060300@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Tony,

On Wednesday 05 October 2011 06:15 AM, Tony Lindgren wrote:
> Hi all,
> 
> Related to the omap static mapping, here's a first take on moving the
> SRAM init to happen later so we can do generic map_io.
> 
> Still working on a similar patch for omap1, will send it a bit later.
> 
> Regards,
> 
> Tony
> 
> ---
> 
> Tony Lindgren (4):
>       ARM: Add __arm_ioremap_exec for mapping external memory as MT_MEMORY
>       ARM: OMAP: Avoid cpu_is_omapxxxx usage until map_io is done
>       ARM: OMAP: Remove calls to SRAM allocations for framebuffer
>       ARM: OMAP: Map SRAM later on with ioremap_exec()
> 
>
Nice work.

With quick scan, looks like the series will work since
you have already taken care of SRAM is being ready before
SDRC has been initialised which was the only corner case
I was worried.

Will look at this series in next couple of days and do some testing.
Looks like you wanted to inlcude below patch also part of this
series though [PATCH 5/4] numbering is bit confusing.
[PATCH 5/4] ARM: OMAP: Move set_globals initialization to happen in
init_early

Regards
Santosh
