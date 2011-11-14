From: pdeschrijver@nvidia.com (Peter De Schrijver)
Date: Mon, 14 Nov 2011 17:25:18 +0200
Subject: [PATCH v4 01/10] arm/tegra: initial device tree for tegra30
In-Reply-To: <4EBDE766.5080505@gmail.com>
References: <1321010541-31337-1-git-send-email-pdeschrijver@nvidia.com>
 <1321010541-31337-2-git-send-email-pdeschrijver@nvidia.com>
 <4EBDE766.5080505@gmail.com>
Message-ID: <20111114152518.GJ19069@tbergstrom-lnx.Nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Nov 12, 2011 at 04:26:30AM +0100, Rob Herring wrote:
> On 11/11/2011 05:22 AM, Peter De Schrijver wrote:
> > This patch adds the initial device tree for tegra30
> > 
> > Signed-off-by: Peter De Schrijver <pdeschrijver@nvidia.com>
> > ---
> >  arch/arm/boot/dts/tegra30.dtsi |  127 ++++++++++++++++++++++++++++++++++++++++
> >  1 files changed, 127 insertions(+), 0 deletions(-)
> >  create mode 100644 arch/arm/boot/dts/tegra30.dtsi
> > 
> > diff --git a/arch/arm/boot/dts/tegra30.dtsi b/arch/arm/boot/dts/tegra30.dtsi
> > new file mode 100644
> > index 0000000..fabe243
> > --- /dev/null
> > +++ b/arch/arm/boot/dts/tegra30.dtsi
> > @@ -0,0 +1,127 @@
> > +/include/ "skeleton.dtsi"
> > +
> > +/ {
> > +	compatible = "nvidia,tegra30";
> 
> Needs documentation.
> 
> > +	interrupt-parent = <&intc>;
> > +
> > +	intc: interrupt-controller at 50041000 {
> > +		compatible = "nvidia,tegra30-gic", "nvidia,tegra20-gic";
> > +		interrupt-controller;
> > +		#interrupt-cells = <1>;
> 
> Is the Tegra GIC really different from a standard A9 gic? You need to
> update to use the gic binding. The cells should be 3 for example.

It has an extra 'legacy' interrupt controller like tegra20 has. This is used
when waking up the CPU from power off mode.

Cheers,

Peter.
