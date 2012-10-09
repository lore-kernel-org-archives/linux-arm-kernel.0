From: cavokz@gmail.com (Domenico Andreoli)
Date: Wed, 10 Oct 2012 01:04:03 +0200
Subject: [PATCH 2/6] ARM: bcm476x: Add system timer
In-Reply-To: <50738F48.5010002@wwwdotorg.org>
References: <20121007015300.828366635@gmail.com>
 <20121007015406.470633343@gmail.com> <1822741.oh36baA1m8@flexo>
 <50738F48.5010002@wwwdotorg.org>
Message-ID: <20121009230403.GB7758@glitch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Oct 08, 2012 at 08:43:20PM -0600, Stephen Warren wrote:
> On 10/08/2012 05:50 AM, Florian Fainelli wrote:
> > On Sunday 07 October 2012 03:53:02 Domenico Andreoli wrote:
> >> From: Domenico Andreoli <domenico.andreoli@linux.com>
> >>
> >> System timer implementation for the BCM476x SoCs.
> 
> >> Index: b/arch/arm/boot/dts/bcm476x.dtsi
> 
> >> +		timer {
> >> +			compatible = "brcm,bcm476x-system-timer";
> >> +			reg = <0xba000 0x1000>;
> >> +			interrupt-parent = <&vic0>;
> >> +			interrupts = <4>, <11>;
> >> +			clock-frequency = <24000000>;
> >> +		};
> > 
> > This should rather be timer: timer at ba0000 for this node to be uniquely named.
> 
> I only see 1 timer node in this series, so "timer" is already unique,
> isn't it?

I don't mind to add the address, this SoC actually has three timer blocks.

Dome
