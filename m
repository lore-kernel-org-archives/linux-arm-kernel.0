From: briannorris@chromium.org (Brian Norris)
Date: Tue, 30 Aug 2016 10:06:36 -0700
Subject: [PATCH] arm64: dts: rockchip: Explicitly set pclk_pmu_src on
 rk3399
In-Reply-To: <4298293.ZqJ4n19bHK@diego>
References: <1472494284-11315-1-git-send-email-dianders@chromium.org>
 <20160829181841.GA8682@localhost> <57C4DA73.5000505@rock-chips.com>
 <4298293.ZqJ4n19bHK@diego>
Message-ID: <20160830170635.GA129134@google.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Aug 30, 2016 at 09:05:06AM +0200, Heiko Stuebner wrote:
> Am Dienstag, 30. August 2016, 08:59:31 schrieb Elaine Zhang:
> > On 08/30/2016 02:18 AM, Brian Norris wrote:
> > > On Mon, Aug 29, 2016 at 11:11:24AM -0700, Doug Anderson wrote:
> > >> --- a/arch/arm64/boot/dts/rockchip/rk3399.dtsi
> > >> +++ b/arch/arm64/boot/dts/rockchip/rk3399.dtsi
> > >> @@ -908,8 +908,8 @@
> > >> 
> > >>   		reg = <0x0 0xff750000 0x0 0x1000>;
> > >>   		#clock-cells = <1>;
> > >>   		#reset-cells = <1>;
> > >> 
> > >> -		assigned-clocks = <&pmucru PLL_PPLL>;
> > >> -		assigned-clock-rates = <676000000>;
> > >> +		assigned-clocks = <&pmucru PLL_PPLL>, <&pmucru PCLK_SRC_PMU>;
> > >> +		assigned-clock-rates = <676000000>, <112666667>;
> > > 
> > > I think this makes sense and is a good idea. One alternative would be to
> > > have the various children actually set a rate that they expect, but
> > > several of them don't have a separate driver at all, and that would be
> > > of dubious value anyway I think.
> > 
> > I agree with you. This clk default div is set in the uboot or coreboot.
> > And if is need to set in kernel ,I hope the freq is 50M(<48285714>).
> > This freq can meet the performance,and the power consumption is not too
> > much.
> 
> can you maybe also provide a tag like the one Brian did below. Your sentence 
> above indicates that you reviewed and approve, but it's helpful to also state 
> that explicitly :-)

If I understand Elaine correctly, that's not actually a full agreement;
it looks like a suggestion to change that from 112 MHz to 48.2 MHz. I
haven't tested that out personally yet, but if that's a formal
recommendation from Rockchip, we'd like to know more about it :)

Brian
