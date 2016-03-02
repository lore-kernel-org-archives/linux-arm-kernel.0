From: ramesh.shanmugasundaram@bp.renesas.com (Ramesh Shanmugasundaram)
Date: Wed, 2 Mar 2016 07:29:04 +0000
Subject: [PATCH] arm64: dts: r8a7795: Add CAN FD support
In-Reply-To: <56D59538.2060100@cogentembedded.com>
References: <1456826640-23237-1-git-send-email-ramesh.shanmugasundaram@bp.renesas.com>
 <56D59538.2060100@cogentembedded.com>
Message-ID: <SG2PR06MB1038FBA247777C89F70E2633C3BC0@SG2PR06MB1038.apcprd06.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Sergei,

> On 3/1/2016 1:04 PM, Ramesh Shanmugasundaram wrote:
> 
> > Adds CAN FD controller node for r8a7795.
> >
> > Note: CAN FD controller register base address specified in R-Car Gen3
> > Hardware User Manual v0.5E is incorrect. The correct address is:
> >
> > CAN FD - 0xe66c0000
> >
> > Signed-off-by: Ramesh Shanmugasundaram
> > <ramesh.shanmugasundaram@bp.renesas.com>
> > ---
> > Hi All,
> >
> >     This patch is based on linux-next (tag:next-20160225) with the
> following
> >     patches applied on top.
> >
> >     [PATCH v2] arm64: dts: r8a7795: Add CAN external clock support
> >     [PATCH] arm64: dts: r8a7795: Add CAN support
> >
> >     The respective CAN subsystem changes are submitted separately here
> > (https://www.mail-archive.com/linux-renesas-soc at vger.kernel.org/msg013
> > 88.html)
> >
> > Thanks,
> > Ramesh
> > ---
> >   arch/arm64/boot/dts/renesas/r8a7795.dtsi | 24 ++++++++++++++++++++++++
> >   1 file changed, 24 insertions(+)
> >
> > diff --git a/arch/arm64/boot/dts/renesas/r8a7795.dtsi
> > b/arch/arm64/boot/dts/renesas/r8a7795.dtsi
> > index a88f8d8..5049ba6 100644
> > --- a/arch/arm64/boot/dts/renesas/r8a7795.dtsi
> > +++ b/arch/arm64/boot/dts/renesas/r8a7795.dtsi
> > @@ -553,6 +553,30 @@
> >   			status = "disabled";
> >   		};
> >
> > +		canfd: canfd at e66c0000 {
> 
>     The node name should still be "can at e66c0000", I think.

Thanks for the review.

The SoC has CAN controller too and hence I chose this node name to differentiate. A grep of canfd on sysfs would tell if the controller is enabled. The channels on "net" would still be named "canx".

I'll change it if you still feel "can at e66c0000" is more appropriate.

Thanks,
Ramesh
