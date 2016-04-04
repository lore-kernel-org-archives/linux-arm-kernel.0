From: maitysanchayan@gmail.com (maitysanchayan at gmail.com)
Date: Mon, 4 Apr 2016 13:44:59 +0530
Subject: [PATCH v1 3/4] ARM: dts: vfxxx: Add OCROM and phandle entries
 for Vybrid SoC bus driver
In-Reply-To: <20160401060046.GG18833@tiger>
References: <cover.1457684688.git.maitysanchayan@gmail.com>
 <39ab1c08dacb7fc4e36a3f3517da16d4da47710b.1457684688.git.maitysanchayan@gmail.com>
 <20160401060046.GG18833@tiger>
Message-ID: <20160404081459.GB11913@Sanchayan-Arch.toradex.int>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

On 16-04-01 14:00:46, Shawn Guo wrote:
> On Fri, Mar 11, 2016 at 02:29:30PM +0530, Sanchayan Maity wrote:
> > Add OCROM node and introduce phandles to OCROM, MSCM and NVMEM
> > OCOTP for use by the Vybrid SoC bus driver.
> > 
> > Signed-off-by: Sanchayan Maity <maitysanchayan@gmail.com>
> > ---
> >  arch/arm/boot/dts/vfxxx.dtsi | 12 +++++++++++-
> >  1 file changed, 11 insertions(+), 1 deletion(-)
> > 
> > diff --git a/arch/arm/boot/dts/vfxxx.dtsi b/arch/arm/boot/dts/vfxxx.dtsi
> > index db9157e..0dd7ad5 100644
> > --- a/arch/arm/boot/dts/vfxxx.dtsi
> > +++ b/arch/arm/boot/dts/vfxxx.dtsi
> > @@ -87,9 +87,19 @@
> >  	soc {
> >  		#address-cells = <1>;
> >  		#size-cells = <1>;
> > -		compatible = "simple-bus";
> > +		compatible = "fsl,vf610-soc-bus", "simple-bus";
> >  		interrupt-parent = <&mscm_ir>;
> >  		ranges;
> > +		fsl,rom-revision = <&ocrom 0x80>;
> > +		fsl,cpu-count = <&mscm_cpucfg 0x2C>;
> > +		fsl,l2-size = <&mscm_cpucfg 0x14>;
> 
> We need a bindings doc for these new properties and compatible.

Ok. Will add the documentation part in v2.

- Sanchayan.

> 
> Shawn
> 
> > +		nvmem-cells = <&ocotp_cfg0>, <&ocotp_cfg1>;
> > +		nvmem-cell-names = "cfg0", "cfg1";
> > +
> > +		ocrom: ocrom at 00000000 {
> > +			compatible = "fsl,vf610-ocrom", "syscon";
> > +			reg = <0x00000000 0x18000>;
> > +		};
> >  
> >  		aips0: aips-bus at 40000000 {
> >  			compatible = "fsl,aips-bus", "simple-bus";
> > -- 
> > 2.7.2
> > 
> > 
