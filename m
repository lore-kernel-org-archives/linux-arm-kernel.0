From: horms@verge.net.au (Simon Horman)
Date: Wed, 20 Dec 2017 12:53:48 +0100
Subject: [PATCH 2/2] ARM: dts: r8a7792: move timer node out of bus
In-Reply-To: <CAMuHMdXRCvw3mMd4uWapin70_3h4F964qbD-xMkfF2MxgLafdA@mail.gmail.com>
References: <20171218213233.3373-1-horms+renesas@verge.net.au>
 <20171218213233.3373-3-horms+renesas@verge.net.au>
 <CAMuHMdXRCvw3mMd4uWapin70_3h4F964qbD-xMkfF2MxgLafdA@mail.gmail.com>
Message-ID: <20171220115347.dgg4imm36w6frw4f@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Dec 19, 2017 at 09:39:56AM +0100, Geert Uytterhoeven wrote:
> On Mon, Dec 18, 2017 at 10:32 PM, Simon Horman
> <horms+renesas@verge.net.au> wrote:
> > The timer node does not have any register properties and thus shouldn't be
> > placed on the bus.
> >
> > This problem is flagged by the compiler as follows:
> > $ make dtbs W=1
> > ...
> >   DTC     arch/arm/boot/dts/r8a7792-wheat.dtb
> > arch/arm/boot/dts/r8a7792-blanche.dtb: Warning (simple_bus_reg): Node /soc/timer missing or empty reg/ranges property
> > arch/arm/boot/dts/r8a7792-wheat.dtb: Warning (simple_bus_reg): Node /soc/timer missing or empty reg/ranges property
> >
> > Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
> 
> Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Thanks, applied.
