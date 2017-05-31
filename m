From: robh@kernel.org (Rob Herring)
Date: Wed, 31 May 2017 11:28:50 -0500
Subject: [PATCH] dt-bindings: Drop k2g genpd device ID macros
In-Reply-To: <20170522183737.24946-1-d-gerlach@ti.com>
References: <20170522183737.24946-1-d-gerlach@ti.com>
Message-ID: <20170531162850.mf6giowmxj5vetxq@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, May 22, 2017 at 01:37:37PM -0500, Dave Gerlach wrote:
> Commit 7cc119f29b19 ("dt-bindings: Add TI SCI PM Domains") introduced a
> number of K2G_DEV_x macros to represent each device ID available on the
> K2G platform for use by the genpd, clock, and reset drivers. Rather than
> use these macros, which are only used in the device tree for property
> values and not actually used by the drivers, let's just use the device
> ID number directly in the device tree to avoid macro bloat.
> 
> Signed-off-by: Dave Gerlach <d-gerlach@ti.com>
> ---
> Based on discussion here [1] it was agreed that these macros are not needed
> and it is better to just use the device IDs directly in dt.
> 
> [1] https://www.spinics.net/lists/arm-kernel/msg577079.html
> 
>  .../devicetree/bindings/soc/ti/sci-pm-domain.txt   |  5 +-
>  include/dt-bindings/genpd/k2g.h                    | 90 ----------------------
>  2 files changed, 3 insertions(+), 92 deletions(-)
>  delete mode 100644 include/dt-bindings/genpd/k2g.h

Acked-by: Rob Herring <robh@kernel.org>
