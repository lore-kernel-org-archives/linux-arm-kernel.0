From: simon.guinot@sequanux.org (Simon Guinot)
Date: Tue, 16 Oct 2012 22:41:33 +0200
Subject: [PATCH 2/4] ARM: kirkwood: DT board setup for Network Space v2
 and parents
In-Reply-To: <507C6AE4.1020406@gmail.com>
References: <1350315295-14567-1-git-send-email-simon.guinot@sequanux.org>
 <1350315295-14567-3-git-send-email-simon.guinot@sequanux.org>
 <507C6AE4.1020406@gmail.com>
Message-ID: <20121016204133.GF28384@kw.sim.vm.gnt>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Oct 15, 2012 at 02:58:28PM -0500, Rob Herring wrote:
> On 10/15/2012 10:34 AM, Simon Guinot wrote:
> > This patch adds DT board setup for LaCie Network Space v2 and parents,
> > based on the Marvell Kirkwood 6281 SoC. This includes Network Space v2
> > (Max) and Internet Space v2.
> > 
> > Signed-off-by: Simon Guinot <simon.guinot@sequanux.org>
> > ---
> >  arch/arm/boot/dts/Makefile                 |    3 +
> >  arch/arm/boot/dts/kirkwood-is2.dts         |   30 ++++++++++
> >  arch/arm/boot/dts/kirkwood-ns2-common.dtsi |   63 +++++++++++++++++++++
> >  arch/arm/boot/dts/kirkwood-ns2.dts         |   30 ++++++++++
> >  arch/arm/boot/dts/kirkwood-ns2max.dts      |   49 ++++++++++++++++
> >  arch/arm/mach-kirkwood/Kconfig             |   21 +++++++
> >  arch/arm/mach-kirkwood/Makefile            |    3 +
> >  arch/arm/mach-kirkwood/board-dt.c          |    8 +++
> >  arch/arm/mach-kirkwood/board-ns2.c         |   83 ++++++++++++++++++++++++++++
> >  arch/arm/mach-kirkwood/common.h            |    8 +++
> >  drivers/leds/Kconfig                       |    4 +-
> >  11 files changed, 301 insertions(+), 1 deletion(-)
> >  create mode 100644 arch/arm/boot/dts/kirkwood-is2.dts
> >  create mode 100644 arch/arm/boot/dts/kirkwood-ns2-common.dtsi
> >  create mode 100644 arch/arm/boot/dts/kirkwood-ns2.dts
> >  create mode 100644 arch/arm/boot/dts/kirkwood-ns2max.dts
> >  create mode 100644 arch/arm/mach-kirkwood/board-ns2.c
> > 
> > diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
> > index c1ce813..e6201b6 100644
> > --- a/arch/arm/boot/dts/Makefile
> > +++ b/arch/arm/boot/dts/Makefile
> > @@ -34,9 +34,12 @@ dtb-$(CONFIG_ARCH_KIRKWOOD) += kirkwood-dns320.dtb \
> >  	kirkwood-ib62x0.dtb \
> >  	kirkwood-iconnect.dtb \
> >  	kirkwood-iomega_ix2_200.dtb \
> > +	kirkwood-is2.dtb \
> >  	kirkwood-km_kirkwood.dtb \
> >  	kirkwood-lschlv2.dtb \
> >  	kirkwood-lsxhl.dtb \
> > +	kirkwood-ns2.dtb \
> > +	kirkwood-ns2max.dtb \
> >  	kirkwood-ts219-6281.dtb \
> >  	kirkwood-ts219-6282.dtb
> >  dtb-$(CONFIG_ARCH_MSM) += msm8660-surf.dtb \
> > diff --git a/arch/arm/boot/dts/kirkwood-is2.dts b/arch/arm/boot/dts/kirkwood-is2.dts
> > new file mode 100644
> > index 0000000..7bc4677
> > --- /dev/null
> > +++ b/arch/arm/boot/dts/kirkwood-is2.dts
> > @@ -0,0 +1,30 @@
> > +/dts-v1/;
> > +
> > +/include/ "kirkwood-ns2-common.dtsi"
> > +
> > +/ {
> > +	model = "LaCie Internet Space v2";
> > +	compatible = "lacie,inetspace_v2", "marvell,kirkwood-88f6281", "marvell,kirkwood";
> 
> Compatible strings must be documented.

Hi Rob,

I have sent a patch to document the compatible strings used with the
Marvell Kirkwood SoCs. Do you also want me to document the compatible
strings for the LaCie machines ? Looking at the devicetree/bindings/arm
directory, it doesn't seems to be a common practice.

Simon
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 198 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20121016/0c50619b/attachment.sig>
