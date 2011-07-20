From: grant.likely@secretlab.ca (Grant Likely)
Date: Wed, 20 Jul 2011 12:56:07 -0600
Subject: [PATCH] arm/dt: tegra devicetree support
In-Reply-To: <CAOesGMiy1t-98KZ_imFkGO-ify3S_00d_0XKc2vcLNRekxOvpw@mail.gmail.com>
References: <20110719234158.2779.15394.stgit@ponder>
	<CAOesGMiy1t-98KZ_imFkGO-ify3S_00d_0XKc2vcLNRekxOvpw@mail.gmail.com>
Message-ID: <20110720185607.GJ4642@ponder.secretlab.ca>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jul 19, 2011 at 04:56:46PM -0700, Olof Johansson wrote:
> Nice!
> 
> 
> On Tue, Jul 19, 2011 at 4:43 PM, Grant Likely <grant.likely@secretlab.ca> wrote:
> > Everything required to populate NVIDIA Tegra devices from the device
> > tree. ?This patch adds a new DT_MACHINE_DESC() which matches against
> > a tegra20 device tree. ?So far it only registers the on-chip devices,
> > but it will be refined in follow on patches to configure clocks and
> > pin IO from the device tree also.
> >
> > Signed-off-by: Grant Likely <grant.likely@secretlab.ca>
> 
> Acked-by: Olof Johansson <olof@lixom.net
> 
> 
> Minor nit:
> 
> > +++ b/arch/arm/boot/dts/tegra20.dtsi
> > @@ -0,0 +1,148 @@
> > +/include/ "skeleton.dtsi"
> > +
> > +/ {
> > + ? ? ? model = "NVIDIA Tegra 250";
> 
> NVIDIA Tegra2 or Tegra20 to be more in line with the recent 250->20
> conversion (and Harmony)

I'll remove the model property entirely.  It doesn't make any sense
for the soc include file since "model" describes the system.

g.
