From: heiko@sntech.de (Heiko Stuebner)
Date: Thu, 31 Mar 2016 22:45:52 +0200
Subject: [PATCH v4 1/8] arm64: dts: rockchip: Clean up /memory nodes
In-Reply-To: <1776429.KtRq374vTa@phil>
References: <1458136727-32075-1-git-send-email-afaerber@suse.de>
 <2027561.JLzKLXOoFO@phil> <1776429.KtRq374vTa@phil>
Message-ID: <11405116.V0u286Y0bM@phil>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Donnerstag, 31. M?rz 2016, 19:15:43 schrieb Heiko Stuebner:
> Am Samstag, 19. M?rz 2016, 09:04:08 schrieb Heiko Stuebner:
> > Am Mittwoch, 16. M?rz 2016, 14:58:39 schrieb Andreas F?rber:
> > > A dtc update results in warnings for nodes with reg property but
> > > without
> > > unit address in the node name, so rename /memory to /memory at 0.
> > > 
> > > Signed-off-by: Andreas F?rber <afaerber@suse.de>
> > 
> > applied to a dts64-fixes branch for 4.6, after changing the commit
> > message to ----
> > A dtc update results in warnings for nodes with reg property but without
> > unit address in the node name, so rename /memory to /memory at startaddress
> > (memory starts at 0 in the case of the rk3368).
> > ----
> > 
> > To clarify that the @0 is not arbitary chosen.
> 
> This dtc update in question hasn't landed in v4.6-rc1 and from what I
> gathered will need some changes. The patch is obviously still correct, but
> I have now moved it from v4.6-fixes to the regular v4.7 64bit dts
> changes.

also it seems "memory" is special and memory without unitname will stay 
allowed [0], especially as uboot or other bootloaders may expect such a node 
to insert the actual amount of memory into it.

Looking at uboot, fdt_fixup_memory_banks seems to look explicitly for a 
"memory" node, so I'm actually not sure, if this is safe to keep at all.


[0] http://www.spinics.net/lists/arm-kernel/msg494038.html
