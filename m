From: lorenzo.pieralisi@arm.com (Lorenzo Pieralisi)
Date: Thu, 25 Sep 2014 09:17:04 +0100
Subject: [PATCH v3] ARM: dts: add CPU nodes for Exynos4 SoCs
In-Reply-To: <018e01cfd885$770dd940$65298bc0$@kernel.org>
References: <5230569.XLlNbB5NvF@amdc1032>
 <018e01cfd885$770dd940$65298bc0$@kernel.org>
Message-ID: <20140925081704.GA20841@e102568-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

[CC'ed Daniel to make him aware this patch goes through your tree]

On Thu, Sep 25, 2014 at 06:56:33AM +0100, Kukjin Kim wrote:
> Bartlomiej Zolnierkiewicz wrote:
> > 
> > Recent patch by Tomasz Figa ("irqchip: gic: Fix core ID calculation
> > when topology is read from DT") fixed GIC driver to filter cluster ID
> > from values returned by cpu_logical_map() for SoCs having registers
> > mapped without per-CPU banking making it is possible to add CPU nodes
> > for Exynos4 SoCs.  In case of Exynos SoCs these CPU nodes are also
> > required by future changes adding initialization of cpuidle states in
> > Exynos cpuidle driver through DT.
> > 
> > Tested on Origen board (Exynos4210 SoC) and Trats2 (Exynos4412 SoC).
> > 
> > Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
> > ---
> > Based on for-next branch of linux-samsung.git tree.
> > 
> > v3:
> > - refreshed on top of Kukjin's tree
> > 
> > v2:
> > - match the unit-address with the reg
> > 
> >  arch/arm/boot/dts/exynos4210.dtsi |   17 +++++++++++++++++
> >  arch/arm/boot/dts/exynos4212.dtsi |   17 +++++++++++++++++
> >  arch/arm/boot/dts/exynos4412.dtsi |   29 +++++++++++++++++++++++++++++
> >  3 files changed, 63 insertions(+)
> 
> Thanks for re-spin and looks good to me.
> 
> Applied.

That's great, now my Exynos CPUidle DT patch should be rebased on top
of this patch so that thanks to the testing carried out by Bart it can be
merged too.

Lorenzo
