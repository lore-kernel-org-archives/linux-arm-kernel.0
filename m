From: horms@verge.net.au (Simon Horman)
Date: Mon, 18 Apr 2016 13:40:59 +1000
Subject: [PATCH 31/47] ARM: dts: r8a7794: Reference both DMA controllers
 in SCIFA nodes
In-Reply-To: <CAMuHMdUUz-0EhgogpHGV-yE6htbwvAjuoAm2+DtDLa3xiG1XkA@mail.gmail.com>
References: <cover.1459732726.git.horms+renesas@verge.net.au>
 <65c295f4b305330162795b0cc2508a207ed23a98.1459732726.git.horms+renesas@verge.net.au>
 <CAOesGMgBBmUvoWdb35vcq0UAJNkMk5LD6-ERWDAaSKWEpGwu9A@mail.gmail.com>
 <CAMuHMdUUz-0EhgogpHGV-yE6htbwvAjuoAm2+DtDLa3xiG1XkA@mail.gmail.com>
Message-ID: <20160418034059.GA1966@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Apr 13, 2016 at 09:55:14PM +0200, Geert Uytterhoeven wrote:
> Hi Olof,
> 
> On Wed, Apr 13, 2016 at 9:48 PM, Olof Johansson <olof@lixom.net> wrote:
> > On Sun, Apr 3, 2016 at 6:23 PM, Simon Horman <horms+renesas@verge.net.au> wrote:
> >> diff --git a/arch/arm/boot/dts/r8a7794.dtsi b/arch/arm/boot/dts/r8a7794.dtsi
> >> index eacb2b291361..4256557ca041 100644
> >> --- a/arch/arm/boot/dts/r8a7794.dtsi
> >> +++ b/arch/arm/boot/dts/r8a7794.dtsi
> >> @@ -296,8 +296,9 @@
> >>                 interrupts = <GIC_SPI 144 IRQ_TYPE_LEVEL_HIGH>;
> >>                 clocks = <&mstp2_clks R8A7794_CLK_SCIFA0>;
> >>                 clock-names = "fck";
> >> -               dmas = <&dmac0 0x21>, <&dmac0 0x22>;
> >> -               dma-names = "tx", "rx";
> >> +               dmas = <&dmac0 0x21>, <&dmac0 0x22>,
> >> +                      <&dmac1 0x21>, <&dmac1 0x22>;
> >> +               dma-names = "tx", "rx", "tx", "rx";
> >>                 power-domains = <&cpg_clocks>;
> >>                 status = "disabled";
> >>         };
> >
> > The names are no longer unique. So a get_<foo>_by_name() function no
> > longer can work as expected.
> 
> That's intentional, and a relic of how dma_request_slave_channel_compat()
> works: if e.g. the first "tx" channel can't be gotten (e.g. because
> the referenced
> DMAC instance ran out of channels), it will try the next one.

Hi Olof,

is the above acceptable to you?
