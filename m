From: maitysanchayan@gmail.com (maitysanchayan at gmail.com)
Date: Mon, 8 Jun 2015 10:07:53 +0530
Subject: [PATCH v5 1/2] ARM: dts: vfxxx: Add OCOTP and OCROM nodes
In-Reply-To: <20150606115833.GP23777@lukather>
References: <cover.1433494491.git.maitysanchayan@gmail.com>
 <fd4fcd83d901b2563ddbce84b339f42778c71260.1433494491.git.maitysanchayan@gmail.com>
 <20150606115833.GP23777@lukather>
Message-ID: <20150608043753.GA3497@Sanchayan-Arch.toradex.int>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Maxime,

On 15-06-06 13:58:33, Maxime Ripard wrote:
> Hi,
> 
> On Fri, Jun 05, 2015 at 02:52:37PM +0530, Sanchayan Maity wrote:
> > Add a device tree node for the On-Chip One Time Programmable
> > Controller (OCOTP) and the On-Chip ROM.
> > 
> > Signed-off-by: Sanchayan Maity <maitysanchayan@gmail.com>
> > ---
> >  arch/arm/boot/dts/vfxxx.dtsi | 12 ++++++++++++
> >  1 file changed, 12 insertions(+)
> > 
> > diff --git a/arch/arm/boot/dts/vfxxx.dtsi b/arch/arm/boot/dts/vfxxx.dtsi
> > index 2f4b04d..ed9b6b8 100644
> > --- a/arch/arm/boot/dts/vfxxx.dtsi
> > +++ b/arch/arm/boot/dts/vfxxx.dtsi
> > @@ -56,6 +56,13 @@
> >  		compatible = "simple-bus";
> >  		interrupt-parent = <&mscm_ir>;
> >  		ranges;
> > +		ocotp-cfg = <&ocotp 0x410 0x420>;
> > +		rom-revision = <&ocrom 0x80>;
> > +
> > +		ocrom: ocrom {
> > +			compatible = "fsl,vf610-ocrom", "syscon";
> > +			reg = <0x00000000 0x18000>;
> > +		};
> 
> Shouldn't that use the new nvmem framework currently being discussed,
> instead of defining custom bindings?

I am aware of those nvmem framework patches by Srinivas, however from what
I can see that framework has not been merged yet atleast from the mail
chain that I see for v5 of the patchset so I have not properly looked into
that. Mark Brown did apply the regmap patches to his tree, but has the rest
of the framework been merged or is it expected to be merged?

If it is expected to be merged and if that framework is a fit for what we
are trying to do here and it seems so on a quick glance, then I can go with
that. However I still did like to hear from Arnd or have some more comments
before I go for that approach with the next respin.

- Sanchayan
