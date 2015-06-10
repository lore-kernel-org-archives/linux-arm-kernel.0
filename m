From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Wed, 10 Jun 2015 18:16:08 +0200
Subject: [PATCH v5 1/2] ARM: dts: vfxxx: Add OCOTP and OCROM nodes
In-Reply-To: <20150608043753.GA3497@Sanchayan-Arch.toradex.int>
References: <cover.1433494491.git.maitysanchayan@gmail.com>
 <fd4fcd83d901b2563ddbce84b339f42778c71260.1433494491.git.maitysanchayan@gmail.com>
 <20150606115833.GP23777@lukather>
 <20150608043753.GA3497@Sanchayan-Arch.toradex.int>
Message-ID: <20150610161608.GC19653@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Mon, Jun 08, 2015 at 10:07:53AM +0530, maitysanchayan at gmail.com wrote:
> > > Add a device tree node for the On-Chip One Time Programmable
> > > Controller (OCOTP) and the On-Chip ROM.
> > > 
> > > Signed-off-by: Sanchayan Maity <maitysanchayan@gmail.com>
> > > ---
> > >  arch/arm/boot/dts/vfxxx.dtsi | 12 ++++++++++++
> > >  1 file changed, 12 insertions(+)
> > > 
> > > diff --git a/arch/arm/boot/dts/vfxxx.dtsi b/arch/arm/boot/dts/vfxxx.dtsi
> > > index 2f4b04d..ed9b6b8 100644
> > > --- a/arch/arm/boot/dts/vfxxx.dtsi
> > > +++ b/arch/arm/boot/dts/vfxxx.dtsi
> > > @@ -56,6 +56,13 @@
> > >  		compatible = "simple-bus";
> > >  		interrupt-parent = <&mscm_ir>;
> > >  		ranges;
> > > +		ocotp-cfg = <&ocotp 0x410 0x420>;
> > > +		rom-revision = <&ocrom 0x80>;
> > > +
> > > +		ocrom: ocrom {
> > > +			compatible = "fsl,vf610-ocrom", "syscon";
> > > +			reg = <0x00000000 0x18000>;
> > > +		};
> > 
> > Shouldn't that use the new nvmem framework currently being discussed,
> > instead of defining custom bindings?
> 
> I am aware of those nvmem framework patches by Srinivas, however from what
> I can see that framework has not been merged yet atleast from the mail
> chain that I see for v5 of the patchset so I have not properly looked into
> that. Mark Brown did apply the regmap patches to his tree, but has the rest
> of the framework been merged or is it expected to be merged?

Yeah, obviously the plan is to get it merged, and there's some effort
toward that, with the amount of review that seem to slow down, so I
guess it's closer to its merge than to its first submission.

> If it is expected to be merged and if that framework is a fit for what we
> are trying to do here and it seems so on a quick glance, then I can go with
> that. However I still did like to hear from Arnd or have some more comments
> before I go for that approach with the next respin.

If it doesn't fit, don't hesitate to mention your concern on the
thread. What you're trying to do should definitely be covered by that
framework.

Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150610/f327df94/attachment-0001.sig>
