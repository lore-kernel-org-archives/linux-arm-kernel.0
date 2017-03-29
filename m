From: santosh.shilimkar@oracle.com (santosh.shilimkar at oracle.com)
Date: Wed, 29 Mar 2017 11:13:39 -0500
Subject: [PATCH] ARM: dts: keystone-k2l: fix broken Ethernet due to
 disabled OSR
In-Reply-To: <59ba5ef37f17ff1c10d9d52ca06ef341b2d476eb.1490782833.git.nsekhar@ti.com>
References: <59ba5ef37f17ff1c10d9d52ca06ef341b2d476eb.1490782833.git.nsekhar@ti.com>
Message-ID: <5adb4f5d-78c4-453d-898d-60c588eb1d14@oracle.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd, Olof,

On 3/29/17 5:32 AM, Sekhar Nori wrote:
> From: Murali Karicheri <m-karicheri2@ti.com>
>
> Ethernet networking on K2L has been broken since v4.11-rc1. This was
> caused by commit 32a34441a9bd ("ARM: keystone: dts: fix netcp clocks
> and add names"). This commit inadvertently moves on-chip static RAM
> clock to the end of list of clocks provided for netcp. Since keystone
> PM domain support does not have a list of recognized con_ids, only the
> first clock in the list comes under runtime PM management. This means
> the OSR (On-chip Static RAM) clock remains disabled and that broke
> networking on K2L.
>
> The OSR is used by QMSS on K2L as an external linking RAM. However this
> is a standalone RAM that can be used for non-QMSS usage (as well as from
> DSP side). So add a SRAM device node for the same and add the OSR clock
> to the node.
>
> Remove the now redundant OSR clock node from netcp.
>
> To manage all clocks defined for netCP's use by runtime PM needs keystone
> generic power domain (genpd) driver support which is under works.
> Meanwhile, this patch restores K2L networking and is correct irrespective
> of any future genpd work since OSR is an independent module and not part
> of NetCP anyway.
>
> Signed-off-by: Murali Karicheri <m-karicheri2@ti.com>
> Acked-by: Tero Kristo <t-kristo@ti.com>
> [nsekhar at ti.com: commit message updates, port to latest mainline]
> Signed-off-by: Sekhar Nori <nsekhar@ti.com>
> ---
Acked-by: Santosh Shilimkar <ssantosh@kernel.org>

Can you please pick this up for rcx fixes ?

Regards,
Santosh
