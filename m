From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Mon, 13 Aug 2012 17:35:03 +0200
Subject: [PATCH v2 1/2] ARM: i.MX35: Add kernel oftree support
In-Reply-To: <20120813081518.GA27480@S2101-09.ap.freescale.net>
References: <1344591170-13638-1-git-send-email-u.kleine-koenig@pengutronix.de>
 <20120813081518.GA27480@S2101-09.ap.freescale.net>
Message-ID: <20120813153503.GC2232@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Shawn,

On Mon, Aug 13, 2012 at 04:15:21PM +0800, Shawn Guo wrote:
> On Fri, Aug 10, 2012 at 11:32:49AM +0200, Uwe Kleine-K?nig wrote:
> > +		emi at 80000000 { /* External Memory Interface */
> > +			compatible = "fsl,emi", "simple-bus";
> > +			#address-cells = <1>;
> > +			#size-cells = <1>;
> > +			reg = <0x80000000 0x40000000>;
> > +			ranges;
> > +
> > +			nand at bb000000 {
> > +				#address-cells = <1>;
> > +				#size-cells = <1>;
> > +
> These should not be needed, until you will have sub-nodes with "reg"
> property.

The obvious sub-nodes are partitions. I thought it sensible to already
add #address-cells and #size-cells because they are identical for all
users and so repeating is minimized.

> > +				compatible = "fsl,imx35-nand", "fsl,imx25-nand";
> > +				reg = <0xbb000000 0x2000>;
> > +				interrupts = <33>;
> > +				status = "disabled";
> > +			};
> > +		};
> > +	};
> > +};
> > [...]
> > +	imx3_init_l2x0();
> 
> Any problem with using l2x0_of_init instead here?
Yeah, the problem is that I never used l2x0_of_init and so it's
unimplemented and untested on i.MX35 :-)

I will take a look.

> > +	pinctrl_provide_dummies();
> 
> Ideally, we should not have this.  But at least have a comment saying
> this is a stop-gap solution before pinctrl is ready, and should be
> removed once pinctrl is in place.
I will look into this, too.

Thanks for your feedback,
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
