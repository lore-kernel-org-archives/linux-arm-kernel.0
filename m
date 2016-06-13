From: l.stach@pengutronix.de (Lucas Stach)
Date: Mon, 13 Jun 2016 11:24:01 +0200
Subject: [PATCH 1/1] ARM: dts: imx6qdl.dtsi: add "arm, shared-override"
 for pl310
In-Reply-To: <20160611115733.GM20243@tiger>
References: <1465292365-26038-1-git-send-email-peter.chen@nxp.com>
 <20160611115733.GM20243@tiger>
Message-ID: <1465809841.2313.2.camel@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Samstag, den 11.06.2016, 19:57 +0800 schrieb Shawn Guo:
> + Lucas
> 
> On Tue, Jun 07, 2016 at 05:39:25PM +0800, Peter Chen wrote:
> > The imx6 SMP system has the same DMA memory coherency issue [1] with
> > pl310 L2 controller. With this shared override bit set, the customer
> > reports the DMA coherency issue is gone. Besides, I have tested
> > the performance using USB ethernet with/without this bit, it shows
> > no difference.
> > 
> > [1] http://patchwork.ozlabs.org/patch/469362/
> > 
> > Signed-off-by: Peter Chen <peter.chen@nxp.com>
> > ---
> >  arch/arm/boot/dts/imx6qdl.dtsi | 1 +
> >  1 file changed, 1 insertion(+)
> > 
> > diff --git a/arch/arm/boot/dts/imx6qdl.dtsi b/arch/arm/boot/dts/imx6qdl.dtsi
> > index ed613eb..30e21ee 100644
> > --- a/arch/arm/boot/dts/imx6qdl.dtsi
> > +++ b/arch/arm/boot/dts/imx6qdl.dtsi
> > @@ -185,6 +185,7 @@
> >  			cache-level = <2>;
> >  			arm,tag-latency = <4 2 3>;
> >  			arm,data-latency = <4 2 3>;
> > +			arm,shared-override;
> 
> Lucas had an objection to the change [1], considering the case that
> kernel is booted as non-secure.

My objection to this change still stands. Configuring the L2C to be
compliant to the ARMv7 ARM is at the same level as the CPU workarounds
that can not be applied in secure mode. Those must be done in the
firmware, if your firmware doesn't do it it's plain broken.

Regards,
Lucas
