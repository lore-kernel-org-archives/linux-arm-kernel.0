From: mark.rutland@arm.com (Mark Rutland)
Date: Wed, 22 Apr 2015 10:12:32 +0100
Subject: [PATCH v5 05/11] ARM: dts: add imx7d soc dtsi file
In-Reply-To: <CAHrpEqRqUJ2h2dXiwR3rcugWvszKwt10axy8jGsAJAH6Quafbg@mail.gmail.com>
References: <1429628007-8892-1-git-send-email-Frank.Li@freescale.com>
 <1429628007-8892-6-git-send-email-Frank.Li@freescale.com>
 <20150421172834.GF10164@leverpostej>
 <CAHrpEqTCMgaAx_bUG1JEtS-2_DrkwM_EbWphu_j=6YZuebcoSw@mail.gmail.com>
 <CAHrpEqRqUJ2h2dXiwR3rcugWvszKwt10axy8jGsAJAH6Quafbg@mail.gmail.com>
Message-ID: <20150422091231.GA27345@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Apr 21, 2015 at 08:34:45PM +0100, Zhi Li wrote:
> >>> +
> >>> +       clocks {
> >>> +               #address-cells = <1>;
> >>> +               #size-cells = <0>;
> >>> +
> >>> +               ckil: clock at 0 {
> >>> +                       compatible = "fixed-clock";
> >>> +                       reg = <0>;
> >>> +                       #clock-cells = <0>;
> >>> +                       clock-frequency = <32768>;
> >>> +                       clock-output-names = "ckil";
> >>> +               };
> >>> +
> >>> +               osc: clock at 1 {
> >>> +                       compatible = "fixed-clock";
> >>> +                       reg = <1>;
> >>> +                       #clock-cells = <0>;
> >>> +                       clock-frequency = <24000000>;
> >>> +                       clock-output-names = "osc";
> >>> +               };
> >>> +
> >>> +       };
> >>
> >> Get rid of the clocks container node, and put these under the root.
> >
> > Okay.
> 
> After remove clocks node.
> There will be warning
> 
> Warning (reg_format): "reg" property in /clock at 0 has invalid length (4
> bytes) (#address-cells == 1, #size-cells == 1)
> Warning (reg_format): "reg" property in /clock at 1 has invalid length (4
> bytes) (#address-cells == 1, #size-cells == 1)

The reg property is meainingless, so just remove it and give the clocks
different names.

Mark.
