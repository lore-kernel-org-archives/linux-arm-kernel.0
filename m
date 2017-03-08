From: p.zabel@pengutronix.de (Philipp Zabel)
Date: Wed, 08 Mar 2017 10:52:56 +0100
Subject: [PATCH] reset: sunxi: fix for 64-bit compilation
In-Reply-To: <6a0e362b-8ebf-6254-6387-12967ec8c484@arm.com>
References: <1488764156-22197-1-git-send-email-andre.przywara@arm.com>
 <CAGb2v64SozB9vUpotkEOyUK33ba8hq9M-QRQUEzEQ565Bhd93g@mail.gmail.com>
 <6a0e362b-8ebf-6254-6387-12967ec8c484@arm.com>
Message-ID: <1488966776.2467.13.camel@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 2017-03-08 at 09:26 +0000, Andre Przywara wrote:
> Hi,
> 
> On 08/03/17 04:28, Chen-Yu Tsai wrote:
> > On Mon, Mar 6, 2017 at 9:35 AM, Andre Przywara <andre.przywara@arm.com> wrote:
> >> The Allwinner reset controller has 32-bit registers, so translating
> >> the reset cell number into a register and bit offset should not use
> >> any architecture dependent data size. Otherwise this breaks for 64-bit
> >> architectures like arm64.
> >> Fix this by making it clear that it's the hardware register width which
> >> matters here in the calculation.
> >>
> >> Signed-off-by: Andre Przywara <andre.przywara@arm.com>
> > 
> > Acked-by: Chen-Yu Tsai <wens@csie.org>
> 
> Thanks a lot!

Applied, thanks.

> > Though I don't expect this driver to be used with arm64 chips.
> 
> Well, weren't we toying with the idea of using this for the A64 PRCM
> support?
> 
> Also the driver is actually pretty generic, and I have (renaming)
> patches lying around to make this obvious.

That is interesting, I have an untested patch that unifies sunxi,
socfpga, and stm32 floating around. I suppose this could be extended to
also cover ath79 and zx2967. I'll dust it off and send it out.

regards
Philipp
