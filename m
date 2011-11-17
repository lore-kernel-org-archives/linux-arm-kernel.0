From: pdeschrijver@nvidia.com (Peter De Schrijver)
Date: Thu, 17 Nov 2011 17:54:29 +0200
Subject: [PATCH] arm/tegra: convert tegra20 to GIC devicetree binding
In-Reply-To: <4EC52BCF.7020609@gmail.com>
References: <1321542430-17971-1-git-send-email-pdeschrijver@nvidia.com>
 <4EC52BCF.7020609@gmail.com>
Message-ID: <20111117155428.GS19069@tbergstrom-lnx.Nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Nov 17, 2011 at 04:44:15PM +0100, Rob Herring wrote:
> On 11/17/2011 09:07 AM, Peter De Schrijver wrote:
> > Convert tegra20 IRQ intialization to the GIC devicetree binding. Modify the
> > interrupt definitions in the dts files according to
> > Documentation/devicetree/bindings/arm/gic.txt
> > 
> > Signed-off-by: Peter De Schrijver <pdeschrijver@nvidia.com>
> 
> One minor comment below, but otherwise:
> 
> Acked-by: Rob Herring <rob.herring@calxeda.com>
> 
> > ---
> >  arch/arm/boot/dts/tegra-paz00.dts |    2 +-
> >  arch/arm/boot/dts/tegra20.dtsi    |   52 ++++++++++++++++++------------------
> >  arch/arm/mach-tegra/irq.c         |   18 +++++++++++-
> >  3 files changed, 43 insertions(+), 29 deletions(-)
> > 
> > diff --git a/arch/arm/boot/dts/tegra-paz00.dts b/arch/arm/boot/dts/tegra-paz00.dts
> > index 15a949f..7ff8f6f 100644
> > --- a/arch/arm/boot/dts/tegra-paz00.dts
> > +++ b/arch/arm/boot/dts/tegra-paz00.dts
> > @@ -32,7 +32,7 @@
> >  		#size-cells = <0>;
> >  		compatible = "nvidia,nvec";
> >  		reg = <0x7000C500 0x100>;
> > -		interrupts = <124>;
> > +		interrupts = <0 92 0x04>;
> >  		clock-frequency = <80000>;
> >  		request-gpios = <&gpio 170 0>;
> >  		slave-addr = <138>;
> > diff --git a/arch/arm/boot/dts/tegra20.dtsi b/arch/arm/boot/dts/tegra20.dtsi
> > index 795b921..cd01b01 100644
> > --- a/arch/arm/boot/dts/tegra20.dtsi
> > +++ b/arch/arm/boot/dts/tegra20.dtsi
> > @@ -5,9 +5,9 @@
> >  	interrupt-parent = <&intc>;
> >  
> >  	intc: interrupt-controller at 50041000 {
> > -		compatible = "nvidia,tegra20-gic";
> > +		compatible = "arm,cortex-a9-gic";
> >  		interrupt-controller;
> 
> You should add an "interrupt-parent;" here so the gic's parent is null
> and not the gic.

Ok. I will add that in the next version.

Cheers,

Peter.
