From: horms@verge.net.au (Simon Horman)
Date: Sat, 1 Dec 2012 09:27:40 +0900
Subject: [PATCH 3/5] ARM: mach-shmobile: sh73a0: Initialise MMCIF using DT
In-Reply-To: <3094701.LTMQnxTPNp@avalon>
References: <1354265085-2444-1-git-send-email-horms@verge.net.au>
 <1354265085-2444-4-git-send-email-horms@verge.net.au>
 <3094701.LTMQnxTPNp@avalon>
Message-ID: <20121201002739.GB4416@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Nov 30, 2012 at 01:30:44PM +0100, Laurent Pinchart wrote:
> Hi Simon,
> 
> Thank you for the patch.
> 
> On Friday 30 November 2012 17:44:43 Simon Horman wrote:
> > From: Simon Horman <horms+renesas@verge.net.au>
> > 
> > This device also requires a voltage regulator which
> > should be defined in a board-specific maner. An example
> > dts snipped follows.
> > 
> > / {
> > 	fixedregulator1v8: fixedregulator at 0 {
> > 		compatible = "regulator-fixed";
> > 		regulator-name = "fixed-1.8V";
> > 		regulator-min-microvolt = <1800000>;
> > 		regulator-max-microvolt = <1800000>;
> > 	};
> > };
> > 
> > &mmcif {
> > 	vmmc-supply = <&fixedregulator1v8>;
> > 	vqmmc-supply = <&fixedregulator1v8>;
> > };
> > 
> > Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
> > 
> > ---
> > 
> > v2
> > * Removed SDHI intitialisation as the driver needs updating first
> > * Moved MMC DT from sh73a0.dtsi to sh73a0-reference.dtsi
> >   as it is not appropriate for use by sh73a0-kzm9g.dts yet.
> >   This is because sh73a0-kzm9g.dts and board-kzm9g.c use
> >   both the GIC and INTC interrupt controllers to provide
> >   access to a rich set of devices. This is achieved by initilising
> >   the interrupt controllers using C code. Work on allowing the INC
> >   controller to be initialised using DT is in progress, however,
> >   until that is complete only GIC may be initialised using DT.
> > * Add extra entries to clock-sh73a0.c:lookups[] and
> >   remove auxdata. Ultimtely the clocks will be described
> >   in DT, but the code isn't there yet.
> 
> Could you please add this as a TO-DO item either in the commit message or in 
> arch/arm/mach-shmobile/clock-sh73a0.c ?

Sure, will do.
