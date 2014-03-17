From: pullip.cho@samsung.com (Cho KyongHo)
Date: Mon, 17 Mar 2014 09:28:32 +0900
Subject: [PATCH v11 11/27] clk: exynos: add gate clock descriptions of
 System MMU
In-Reply-To: <5322F356.6030608@samsung.com>
References: <20140314140621.14df1e40601c4f6a2487b5a8@samsung.com>
 <5322F356.6030608@samsung.com>
Message-ID: <20140317092832.af0e8e8b503c98eb639dd09a@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 14 Mar 2014 13:17:26 +0100, Tomasz Figa wrote:
> Hi KyongHo,
> 
> On 14.03.2014 06:06, Cho KyongHo wrote:
> > This adds gate clocks of all System MMUs and their master IPs
> > that are not apeared in clk-exynos5250.c and clk-exynos5420.c
> > Also fixes GATE_IP_ACP to 0x18800 and changed GATE_DA to GATE
> > for System MMU clocks in clk-exynos4.c
> >
> > Signed-off-by: Cho KyongHo <pullip.cho@samsung.com>
> > ---
> >   .../devicetree/bindings/clock/exynos5250-clock.txt |    3 +++
> >   .../devicetree/bindings/clock/exynos5420-clock.txt |    6 +++++-
> >   drivers/clk/samsung/clk-exynos5250.c               |    5 +++++
> >   drivers/clk/samsung/clk-exynos5420.c               |   13 +++++++++++--
> >   include/dt-bindings/clock/exynos5250.h             |    4 ++++
> >   include/dt-bindings/clock/exynos5420.h             |    6 +++++-
> >   6 files changed, 33 insertions(+), 4 deletions(-)
> >
> > diff --git a/Documentation/devicetree/bindings/clock/exynos5250-clock.txt b/Documentation/devicetree/bindings/clock/exynos5250-clock.txt
> > index 72ce617..67e50ba 100644
> > --- a/Documentation/devicetree/bindings/clock/exynos5250-clock.txt
> > +++ b/Documentation/devicetree/bindings/clock/exynos5250-clock.txt
> > @@ -162,6 +162,9 @@ clock which they consume.
> >     g2d			345
> >     mdma0			346
> >     smmu_mdma0		347
> > +  smmu_tv		348
> > +  smmu_fimd1		349
> > +  smmu_2d		350
> >
> 
> This patch should be rebased on top of Andrzej Hajda's patches removing 
> these clock ID listings and reworking dts files to use defined macros. 
> They are present in v3.15-next/dt-clk-exynos branch of linux-samsung 
> tree, but I have asked Kukjin to merge them to his for-next branch, so 
> they could show up in linux-next tree.
> 

Thanks for the information.
I will also ask Kukjin for the correct base of the patches.

KyongHo.
