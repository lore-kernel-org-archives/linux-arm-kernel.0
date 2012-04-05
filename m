From: paul@pwsan.com (Paul Walmsley)
Date: Thu, 5 Apr 2012 15:33:32 -0600 (MDT)
Subject: [PATCH] ARM: OMAP2+: PRM: fix compile for OMAP4-only build
In-Reply-To: <1333660837-23249-1-git-send-email-khilman@ti.com>
References: <1333660837-23249-1-git-send-email-khilman@ti.com>
Message-ID: <alpine.DEB.2.00.1204051533110.10302@utopia.booyaka.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 5 Apr 2012, Kevin Hilman wrote:

> For OMAP4 only builds, the omap2_prm_* functions have dummy wrappers
> to detect incorrect usage.  However, several unrelated omap3 PRM
> functions have made it inside the #else clause of the #ifdef wrapping
> the omap2_prm stubs, causing them to disappear on OMAP4-only builds.
> 
> This was unnoticed until the IO chain support was added and introduced
> a new function in this section which is referenced by omap_hwmod.c:
> 
> /work/kernel/omap/dev/arch/arm/mach-omap2/omap_hwmod.c: In function '_reconfigure_io_chain':
> /work/kernel/omap/dev/arch/arm/mach-omap2/omap_hwmod.c:1665:3: error: implicit declaration of function 'omap3xxx_prm_reconfigure_io_chain' [-Werror=implicit-fungiction-declaration]
> 
> Fix by using the #ifdef to only wrap the omap2_prm functions that
> need stubs on OMAP4-only builds.
> 
> Cc: Paul Walmsley <paul@pwsan.com>
> Signed-off-by: Kevin Hilman <khilman@ti.com>
> ---
> Paul, this patch applies on top your io_chain_devel_3.5 branch.

Thanks, Tony reported this too.  Any objections to me rolling this into 
the offending patch?
> 


- Paul
