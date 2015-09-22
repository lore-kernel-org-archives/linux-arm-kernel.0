From: scottwood@freescale.com (Scott Wood)
Date: Mon, 21 Sep 2015 20:30:29 -0500
Subject: [PATCH 4/6] arm64/ls1043a: add DTS for Freescale LS1043A SoC
In-Reply-To: <20150922012403.GA1535@svinekod>
References: <1442838158-2964-1-git-send-email-B48286@freescale.com>
 <1442838158-2964-5-git-send-email-B48286@freescale.com>
 <20150922012403.GA1535@svinekod>
Message-ID: <1442885429.19102.210.camel@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 2015-09-22 at 02:24 +0100, Mark Rutland wrote:
> > +       clockgen:  clocking at 1ee1000{
> > +               compatible = "fsl,ls1043a-clockgen";
> > +               reg = <0x0 0x1ee1000 0x0 0x1000>;
> > +               #clock-cells = <2>;
> > +               clocks = <&sysclk>;
> > +               sysclk: sysclk {
> > +                       compatible = "fixed-clock";
> > +                       #clock-cells = <0>;
> > +                       clock-frequency = <100000000>;
> > +                       clock-output-names = "sysclk";
> > +               };
> > +       };
> 
> Why does this fixed clock live under the clockgen? It should live directly
> under the root node.

I think this is copy-and-paste from some legacy PPC stuff.  There's no reason 
anymore to put sysclk under clockgen.

-Scott
