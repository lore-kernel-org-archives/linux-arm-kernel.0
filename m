From: joe@perches.com (Joe Perches)
Date: Fri, 28 Sep 2018 15:04:55 -0700
Subject: Bad MAINTAINERS pattern in section 'Texas Instruments' System Control
 Interface (TISCI) Protocol Driver'
Message-ID: <20180928220455.31806-1-joe@perches.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Please fix this defect appropriately.

linux-next MAINTAINERS section:

	14531	Texas Instruments' System Control Interface (TISCI) Protocol Driver
	14532	M:	Nishanth Menon <nm@ti.com>
	14533	M:	Tero Kristo <t-kristo@ti.com>
	14534	M:	Santosh Shilimkar <ssantosh@kernel.org>
	14535	L:	linux-arm-kernel at lists.infradead.org
	14536	S:	Maintained
	14537	F:	Documentation/devicetree/bindings/arm/keystone/ti,sci.txt
	14538	F:	drivers/firmware/ti_sci*
	14539	F:	include/linux/soc/ti/ti_sci_protocol.h
	14540	F:	Documentation/devicetree/bindings/soc/ti/sci-pm-domain.txt
-->	14541	F:	include/dt-bindings/genpd/k2g.h
	14542	F:	drivers/soc/ti/ti_sci_pm_domains.c
	14543	F:	Documentation/devicetree/bindings/reset/ti,sci-reset.txt
	14544	F:	Documentation/devicetree/bindings/clock/ti,sci-clk.txt
	14545	F:	drivers/clk/keystone/sci-clk.c
	14546	F:	drivers/reset/reset-ti-sci.c

Commit that introduced this:

commit 7cc119f29b197f967161ca94c9d5cb5073b4b52b
 Author: Dave Gerlach <d-gerlach@ti.com>
 Date:   Tue Apr 4 08:59:27 2017 -0700
 
     dt-bindings: Add TI SCI PM Domains
     
     Add a generic power domain implementation, TI SCI PM Domains, that
     will hook into the genpd framework and allow the TI SCI protocol to
     control device power states.
     
     Also, provide macros representing each device index as understood
     by TI SCI to be used in the device node power-domain references.
     These are identifiers for the K2G devices managed by the PMMC.
     
     Acked-by: Santosh Shilimkar <ssantosh@kernel.org>
     Reviewed-by: Ulf Hansson <ulf.hansson@linaro.org>
     Acked-by: Rob Herring <robh@kernel.org>
     Signed-off-by: Nishanth Menon <nm@ti.com>
     Signed-off-by: Dave Gerlach <d-gerlach@ti.com>
     Signed-off-by: Santosh Shilimkar <ssantosh@kernel.org>
 
  .../devicetree/bindings/soc/ti/sci-pm-domain.txt   | 57 ++++++++++++++
  MAINTAINERS                                        |  2 +
  include/dt-bindings/genpd/k2g.h                    | 90 ++++++++++++++++++++++
  3 files changed, 149 insertions(+)

Last commit with include/dt-bindings/genpd/k2g.h

commit d16645054d2f55e4011c9725ddf2dbe6177e942a
Author: Dave Gerlach <d-gerlach@ti.com>
Date:   Fri Jul 21 09:38:36 2017 -0700

    dt-bindings: Drop k2g genpd device ID macros
    
    Commit 7cc119f29b19 ("dt-bindings: Add TI SCI PM Domains") introduced a
    number of K2G_DEV_x macros to represent each device ID available on the
    K2G platform for use by the genpd, clock, and reset drivers. Rather than
    use these macros, which are only used in the device tree for property
    values and not actually used by the drivers, let's just use the device
    ID number directly in the device tree to avoid macro bloat.
    
    Acked-by: Rob Herring <robh@kernel.org>
    Signed-off-by: Dave Gerlach <d-gerlach@ti.com>
    Signed-off-by: Santosh Shilimkar <ssantosh@kernel.org>

 .../devicetree/bindings/soc/ti/sci-pm-domain.txt   |  5 +-
 include/dt-bindings/genpd/k2g.h                    | 90 ----------------------
 2 files changed, 3 insertions(+), 92 deletions(-)
