From: horms@verge.net.au (Simon Horman)
Date: Tue, 24 Apr 2018 11:22:20 +0200
Subject: [PATCH 1/2] arm64: dts: renesas: r8a77980: add MMC support
In-Reply-To: <5be1ecdb-8f36-ca1e-aba6-012fbb263894@cogentembedded.com>
References: <611daf1f-42a2-d463-0814-ebf762871018@cogentembedded.com>
 <aaa58189-2c27-e51f-1f97-3671c50a1479@cogentembedded.com>
 <20180420095857.latofivdh3dnvu2z@verge.net.au>
 <5be1ecdb-8f36-ca1e-aba6-012fbb263894@cogentembedded.com>
Message-ID: <20180424092220.s6qgtxloinmimqa7@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Apr 20, 2018 at 10:06:03PM +0300, Sergei Shtylyov wrote:
> On 04/20/2018 12:58 PM, Simon Horman wrote:
> 
> >> Define the generic R8A77980 part of the MMC0 (SDHI2) device node.
> >>
> >> Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
> >>
> >> ---
> >>  arch/arm64/boot/dts/renesas/r8a77980.dtsi |   12 ++++++++++++
> >>  1 file changed, 12 insertions(+)
> >>
> >> Index: renesas/arch/arm64/boot/dts/renesas/r8a77980.dtsi
> >> ===================================================================
> >> --- renesas.orig/arch/arm64/boot/dts/renesas/r8a77980.dtsi
> >> +++ renesas/arch/arm64/boot/dts/renesas/r8a77980.dtsi
> >> @@ -371,6 +371,18 @@
> >>  			dma-channels = <16>;
> >>  		};
> >>  
> >> +		mmc0: mmc at ee140000 {
> > 
> > Please use sdhi2: sd at ee140000 for consistency with other SoCs
> > (I refereed to the r8a7795).
> 
>    Mmm... note that this controller has MMC signals (8 data bits, DS, no CD/WP),
> see manual v0.55. I think it's more correct to call it MMC0 (trken from the
> manual as well)...

Ok, point taken. I've applied this. But in general I would like the
dtsi files to be consistent where it makes sense.
