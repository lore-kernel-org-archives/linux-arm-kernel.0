From: mark.rutland@arm.com (Mark Rutland)
Date: Wed, 17 Aug 2016 11:04:25 +0100
Subject: [PATCH v2] Added perf functionality to mmdc driver
In-Reply-To: <DB5PR04MB1430F6105A94E0E95FF3C8FF9F130@DB5PR04MB1430.eurprd04.prod.outlook.com>
References: <20160815223035.5429-1-zhengyu.shen@nxp.com>
 <20160815165050.GB31080@svinekod>
 <DB5PR04MB14309188D99C35809DDA377B9F130@DB5PR04MB1430.eurprd04.prod.outlook.com>
 <20160815194945.GB1120@svinekod>
 <DB5PR04MB1430F6105A94E0E95FF3C8FF9F130@DB5PR04MB1430.eurprd04.prod.outlook.com>
Message-ID: <20160817100425.GB30900@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Aug 16, 2016 at 08:40:08PM +0000, Zhengyu Shen wrote:
> > > > > +	hrtimer_start(&pmu_mmdc->hrtimer, mmdc_timer_period(),
> > > > > +			HRTIMER_MODE_REL_PINNED);
> > > >
> > > > Why is a hrtimer necessary? Is this just copy-pasted from CCN, or do
> > > > you have similar HW issues?
> > > >
> > > > Is there no overflow interrupt?
> > >
> > > When overflow occurs, a register bit is set to one. There is no
> > > overflow interrupt which is why the timer is needed.
> > 
> > I see. Please have add comment in the driver explaining this, so that this is
> > obvious.
> > 
> > Does the counter itself wrap and continue counting, or does it saturate?
> > 
> > How have you tuned your polling period so as to avoid missing events in the
> > case of an overflow?
> > 
> > Thanks,
> > Mark.
> The counter wraps around once every ten seconds for total-cycles (which is the 
> Fastest increasing counter). Polling is done every one second just to be safe.

Ok. It would be worth noting this with a comment next to either the
hrtimer handler or registration thereof.

I assume that on overflow the counter wraps rather than saturating?

Thanks,
Mark.
