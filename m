From: krzk@kernel.org (Krzysztof Kozlowski)
Date: Wed, 20 Jun 2018 21:34:07 +0200
Subject: [PATCH 2/2] arm64: dts: exynos: Remove unneeded DSI and DECON
 address/size cells in Exynos5433
In-Reply-To: <CAJKOXPeCT3CkqqNowEZaeTw7goJd6=Nbd2S61QzTFW-nGr5AKg@mail.gmail.com>
References: <20180618174216.24801-1-krzk@kernel.org>
 <CGME20180618174316epcas1p397b66c8e4e8479fce8655941a4d4279f@epcas1p3.samsung.com>
 <20180618174216.24801-2-krzk@kernel.org>
 <20180619072652eucas1p1943deb1b158eda52980448e41f83e5e9~5fwX6lI2o2633926339eucas1p1Q@eucas1p1.samsung.com>
 <CAJKOXPeCT3CkqqNowEZaeTw7goJd6=Nbd2S61QzTFW-nGr5AKg@mail.gmail.com>
Message-ID: <20180620193407.gk5e5ecolo5bel3c@kozik-lap>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jun 19, 2018 at 09:59:04AM +0200, Krzysztof Kozlowski wrote:
> On 19 June 2018 at 09:26, Marek Szyprowski <m.szyprowski@samsung.com> wrote:
> > Hi Krzysztof,
> >
> > On 2018-06-18 19:42, Krzysztof Kozlowski wrote:
> >> The decon, decon_tv and dsi nodes have only one child port so
> >> address/size mappings are not necessary.  This fixes DTC warnings like:
> >>
> >>      Warning (graph_child_address): /soc/decon at 13800000/ports:
> >>          graph node has single child node 'port at 0', #address-cells/#size-cells are not necessary
> >>
> >> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
> >
> > Works fine with current Exynos DRM Decon/MIC/DSI drivers.
> >
> > Tested-by: Marek Szyprowski <m.szyprowski@samsung.com>
> 
> Thanks for review and testing!

I have second thoughs whether this patch is correct. AFAIU, the drivers
get the remote endpoints by reg==0 (for example the
of_graph_get_remote_node() in exynos_dsi_parse_dt()). If the port shall
be ignored, then reg==-1 should be passed.

Best regards,
Krzysztof
