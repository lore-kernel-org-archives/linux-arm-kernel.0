From: zhengyu.shen@nxp.com (Zhengyu Shen)
Date: Tue, 16 Aug 2016 20:40:08 +0000
Subject: [PATCH v2] Added perf functionality to mmdc driver
In-Reply-To: <20160815194945.GB1120@svinekod>
References: <20160815223035.5429-1-zhengyu.shen@nxp.com>
 <20160815165050.GB31080@svinekod>
 <DB5PR04MB14309188D99C35809DDA377B9F130@DB5PR04MB1430.eurprd04.prod.outlook.com>
 <20160815194945.GB1120@svinekod>
Message-ID: <DB5PR04MB1430F6105A94E0E95FF3C8FF9F130@DB5PR04MB1430.eurprd04.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> > > > +	hrtimer_start(&pmu_mmdc->hrtimer, mmdc_timer_period(),
> > > > +			HRTIMER_MODE_REL_PINNED);
> > >
> > > Why is a hrtimer necessary? Is this just copy-pasted from CCN, or do
> > > you have similar HW issues?
> > >
> > > Is there no overflow interrupt?
> >
> > When overflow occurs, a register bit is set to one. There is no
> > overflow interrupt which is why the timer is needed.
> 
> I see. Please have add comment in the driver explaining this, so that this is
> obvious.
> 
> Does the counter itself wrap and continue counting, or does it saturate?
> 
> How have you tuned your polling period so as to avoid missing events in the
> case of an overflow?
> 
> Thanks,
> Mark.
The counter wraps around once every ten seconds for total-cycles (which is the 
Fastest increasing counter). Polling is done every one second just to be safe.
