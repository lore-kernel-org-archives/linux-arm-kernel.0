From: heiko@sntech.de (Heiko =?ISO-8859-1?Q?St=FCbner?=)
Date: Wed, 26 Mar 2014 13:03:18 +0100
Subject: [PATCH] ARM: rockchip: convert smp bringup to
 CPU_METHOD_OF_DECLARE
In-Reply-To: <20140326110024.GR10341@e106331-lin.cambridge.arm.com>
References: <1632873.urGeGsUMPH@diego>
 <20140326110024.GR10341@e106331-lin.cambridge.arm.com>
Message-ID: <2151573.evmqdkWnet@diego>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Mittwoch, 26. M?rz 2014, 11:00:24 schrieb Mark Rutland:
> On Wed, Mar 26, 2014 at 10:27:35AM +0000, Heiko St?bner wrote:
> > With the newly introduced CPU_METHOD_OF_DECLARE is not necessary anymore
> > to reference the relevant smp_ops in the board file, but instead it can
> > simply be set by the enable-method property of the cpu nodes.
> > 
> > Signed-off-by: Heiko Stuebner <heiko@sntech.de>
> > ---
> > 
> >  Documentation/devicetree/bindings/arm/cpus.txt | 1 +
> >  arch/arm/boot/dts/rk3066a.dtsi                 | 1 +
> >  arch/arm/boot/dts/rk3188.dtsi                  | 1 +
> >  arch/arm/mach-rockchip/core.h                  | 2 --
> >  arch/arm/mach-rockchip/platsmp.c               | 3 ++-
> >  arch/arm/mach-rockchip/rockchip.c              | 1 -
> >  6 files changed, 5 insertions(+), 4 deletions(-)
> > 
> > diff --git a/Documentation/devicetree/bindings/arm/cpus.txt
> > b/Documentation/devicetree/bindings/arm/cpus.txt index 333f4ae..2501d5d
> > 100644
> > --- a/Documentation/devicetree/bindings/arm/cpus.txt
> > +++ b/Documentation/devicetree/bindings/arm/cpus.txt
> > @@ -185,6 +185,7 @@ nodes to be present and contain the properties
> > described below.> 
> >  			    "qcom,gcc-msm8660"
> >  			    "qcom,kpss-acc-v1"
> >  			    "qcom,kpss-acc-v2"
> > 
> > +			    "rockchip,rk3066-smp"
> 
> We should document what what these actually mean, so as to be a hardware
> description and not a Linux internals description.

is something like
				"rockchip,rk3066-smp" - cpu-core handling used by SoCs
								from Rockchip starting with rk3066

enough, or should it contain more data?


Thanks
Heiko
