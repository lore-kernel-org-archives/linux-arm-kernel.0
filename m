From: shawn.guo@linaro.org (Shawn Guo)
Date: Tue, 14 Aug 2012 09:35:19 +0800
Subject: [PATCH v2 1/2] ARM: i.MX35: Add kernel oftree support
In-Reply-To: <20120813153503.GC2232@pengutronix.de>
References: <1344591170-13638-1-git-send-email-u.kleine-koenig@pengutronix.de>
 <20120813081518.GA27480@S2101-09.ap.freescale.net>
 <20120813153503.GC2232@pengutronix.de>
Message-ID: <20120814013517.GC27792@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Aug 13, 2012 at 05:35:03PM +0200, Uwe Kleine-K?nig wrote:
> Hi Shawn,
> 
> On Mon, Aug 13, 2012 at 04:15:21PM +0800, Shawn Guo wrote:
> > On Fri, Aug 10, 2012 at 11:32:49AM +0200, Uwe Kleine-K?nig wrote:
> > > +		emi at 80000000 { /* External Memory Interface */
> > > +			compatible = "fsl,emi", "simple-bus";
> > > +			#address-cells = <1>;
> > > +			#size-cells = <1>;
> > > +			reg = <0x80000000 0x40000000>;
> > > +			ranges;
> > > +
> > > +			nand at bb000000 {
> > > +				#address-cells = <1>;
> > > +				#size-cells = <1>;
> > > +
> > These should not be needed, until you will have sub-nodes with "reg"
> > property.
> 
> The obvious sub-nodes are partitions. I thought it sensible to already
> add #address-cells and #size-cells because they are identical for all
> users and so repeating is minimized.
> 
Yes, you are right.  How did I forget such an obvious use case?

-- 
Regards,
Shawn
