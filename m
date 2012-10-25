From: jason@lakedaemon.net (Jason Cooper)
Date: Thu, 25 Oct 2012 09:18:18 -0400
Subject: [PATCH 2/2] arm: mvebu: adding SATA support: dt binding and
 config update
In-Reply-To: <5087F5B9.0@free-electrons.com>
References: <1351086561-13569-1-git-send-email-gregory.clement@free-electrons.com>
 <1351086561-13569-3-git-send-email-gregory.clement@free-electrons.com>
 <20121024160139.6dbf5e16@skate> <5087F5B9.0@free-electrons.com>
Message-ID: <20121025131818.GF18811@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Oct 24, 2012 at 04:05:45PM +0200, Gregory CLEMENT wrote:
> On 10/24/2012 04:01 PM, Thomas Petazzoni wrote:
> > Hello,
> > 
> > Shouldn't you split into one commit adding the SATA definition in
> > the .dtsi + doing the defconfig change (the "SoC" level modifications),
> > and then another commit for the .dts change? I don't really care
> > personally, it's really up to Jason/Andrew on this.
> > 
> > Another comment below, though.
> > 
> > On Wed, 24 Oct 2012 15:49:21 +0200, Gregory CLEMENT wrote:
> > 
> >> diff --git a/arch/arm/boot/dts/armada-370-xp.dtsi b/arch/arm/boot/dts/armada-370-xp.dtsi
> >> index 94b4b9e..3f08233 100644
> >> --- a/arch/arm/boot/dts/armada-370-xp.dtsi
> >> +++ b/arch/arm/boot/dts/armada-370-xp.dtsi
> >> @@ -69,6 +69,16 @@
> >>  			compatible = "marvell,armada-addr-decoding-controller";
> >>  			reg = <0xd0020000 0x258>;
> >>  		};
> >> +
> >> +		sata at d00a0000 {
> >> +                        compatible = "marvell,orion-sata";
> >> +                        reg = <0xd00a0000 0x2400>;
> >> +                        interrupts = <55>;
> >> +                        nr-ports = <2>;
> >> +			clocks = <&coreclk 0>;//,  <&coreclk 0>;
> > 
> > Alignment problem + remainings of tests or something like that.
> 
> True I missed this one.
> 
> Jason, Andrew, do you want I split this patch as suggested by Thomas or
> are you fine with having one single patch?

Yes, please make the defconfig changes a separate patch.  Also, please
make sure only the minimum is enabled (eq RAID... isn't needed).

thx,

Jason.
