From: dongas86@gmail.com (Dong Aisheng)
Date: Fri, 14 Apr 2017 23:49:36 +0800
Subject: [PATCH 4/8] ARM: dts: imx7s: Add node for GPC
In-Reply-To: <CAHQ1cqGYs2h1ZFBC4WBYbyAMsctURwOzQmQB+B6nz=wmR0fYoQ@mail.gmail.com>
References: <20170413133242.5068-1-andrew.smirnov@gmail.com>
 <20170413133242.5068-5-andrew.smirnov@gmail.com>
 <20170414034005.GG14915@dragon>
 <CAHQ1cqGYs2h1ZFBC4WBYbyAMsctURwOzQmQB+B6nz=wmR0fYoQ@mail.gmail.com>
Message-ID: <20170414154936.GB1792@b29396-OptiPlex-7040>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Apr 14, 2017 at 08:19:44AM -0700, Andrey Smirnov wrote:
...
> >> +                     gpc: gpc at 303a0000 {
> >> +                             compatible = "fsl,imx7d-gpc";
> >> +                             reg = <0x303a0000 0x10000>;
> >> +                             interrupt-controller;
> >> +                             interrupts = <GIC_SPI 87 IRQ_TYPE_LEVEL_HIGH>;
> >> +                             #interrupt-cells = <3>;
> >> +                             interrupt-parent = <&intc>;
> >> +                             #power-domain-cells = <1>;
> >> +
> >> +                             pgc {
> >> +                                     #address-cells = <1>;
> >> +                                     #size-cells = <0>;
> >> +
> >> +                                     pgc_pcie_phy: pgc-pcie-phy-domain {
> >
> > The node name should be something generic and has a unit-address when
> > there is a 'reg' property in the node.
> >
> 
> I'll change it to pgc-power-domain at 0, let me know if you want
> something different.
> 

I think just power-domain at 0 is ok.
And also better replace unit-address by macro.

Regards
Dong Aisheng
