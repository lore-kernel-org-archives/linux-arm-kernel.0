From: horms@verge.net.au (Simon Horman)
Date: Tue, 25 Feb 2014 10:54:48 +0900
Subject: [PATCH v2 1/2] ARM: shmobile: r8a7778/r8a7779 dtsi: Improve and
 correct HSPI bindings
In-Reply-To: <20140224002837.GA3898@verge.net.au>
References: <1392908239-22645-1-git-send-email-geert@linux-m68k.org>
 <20140224002837.GA3898@verge.net.au>
Message-ID: <20140225015445.GA8995@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Feb 24, 2014 at 09:28:40AM +0900, Simon Horman wrote:
> On Thu, Feb 20, 2014 at 03:57:18PM +0100, Geert Uytterhoeven wrote:
> > From: Geert Uytterhoeven <geert+renesas@linux-m68k.org>
> > 
> > Binding documentation:
> >   - Add future-proof "renesas,hspi-<soctype>" compatible values,
> >   - Add "interrupt-parent", "#address-cells" and "#size-cells" properties,
> >   - Add reference to pinctrl documentation,
> >   - Add example bindings.
> > 
> > r8a7778 and r8a7779 dtsi:
> >   - Add "renesas,hspi-r8a7778" resp. "renesas,hspi-r8a7779" compatible
> >     values,
> >   - Correct reference to parent interrupt controller
> >     (use "interrupt-parent" instead of "interrupt-controller"),
> >   - Add missing "#address-cells" and "#size-cells" properties, which are
> >     needed when populating the SPI buses.
> > 
> > Signed-off-by: Geert Uytterhoeven <geert+renesas@linux-m68k.org>
> > Tested-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com> [HSPI/BockW]
> > Cc: Mark Brown <broonie@linaro.org>
> > ---
> > v2:
> >   - Add Tested-by
> >   - List full example compatible properties with soctypes instead of just
> >     the soctypes, so checkpatch can validate DTSes.
> 
> Thanks, I have queued this up.

I have dropped this patch and because it updates both driver documentation
and shmobile code.

Please split the patch into two, one to be taken by the driver maintainer,
Mark Brown. And one to be taken by me. Thanks

I have also dropped the second patch of this series, which depends on this
patch.
