From: shawnguo@kernel.org (Shawn Guo)
Date: Thu, 9 Jul 2015 21:42:00 +0800
Subject: [PATCH v2 6/8] ARM: dts: imx: add imx6ul and imx6ul evk board
 support
In-Reply-To: <CAHrpEqQMtaL_ReeFP4VR2bfg_HDaQAHc0BUMB3X4KM3b23ra0A@mail.gmail.com>
References: <1434727951-4852-1-git-send-email-Frank.Li@freescale.com>
 <1434727951-4852-7-git-send-email-Frank.Li@freescale.com>
 <CAH=tA9G_x=6wNTOWbOc2FGGARTxioikUSwqyENKk74wL=7uzaw@mail.gmail.com>
 <CAHrpEqQMtaL_ReeFP4VR2bfg_HDaQAHc0BUMB3X4KM3b23ra0A@mail.gmail.com>
Message-ID: <20150709134200.GH23464@tiger>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jun 19, 2015 at 01:55:46PM -0500, Zhi Li wrote:
> On Fri, Jun 19, 2015 at 12:05 PM, Nicolae Rosia <nicolae.rosia@gmail.com> wrote:
> > Hi,
> >
> > On Fri, Jun 19, 2015 at 6:32 PM,  <Frank.Li@freescale.com> wrote:
> >> From: Frank Li <Frank.Li@freescale.com>
> > [...]
> >> +       cpus {
> >> +               #address-cells = <1>;
> >> +               #size-cells = <0>;
> >> +
> >> +               cpu0: cpu at 0 {
> >> +                       compatible = "arm,cortex-a7";
> >> +                       device_type = "cpu";
> >> +                       reg = <0>;
> >> +                       clock-latency = <61036>; /* two CLK32 periods */
> >> +                       operating-points = <
> >> +                               /* kHz  uV */
> >> +                               528000  1250000
> >> +                               396000  1150000
> >> +                               198000  1150000
> >> +                       >;
> >> +                       fsl,soc-operating-points = <
> >> +                               /* KHz  uV */
> >> +                               528000  1250000
> >> +                               396000  1150000
> >> +                               198000  1150000
> >> +                       >;
> > Why is this necessary? Can't you adapt the driver to use operating-points?
> > I have looked through other imx dts and saw that some had different
> > values in these two tables.
> 
> It is used by internal busfreq driver. I will remove it at next version.

It's used by mainline imx6q-cpufreq driver, but it's a piece of
undocumented binding.  Basically, on i.MX6 series, when CPU frequency
scales, there are two voltages, 'core' and 'soc', need to scale
accordingly.  The OPP binding v1 only supports one voltage.

Shawn
