From: Li.Xiubo@freescale.com (Li.Xiubo at freescale.com)
Date: Fri, 18 Apr 2014 03:55:46 +0000
Subject: [RFC][PATCH 3/3] clocksource: Add Freescale FlexTimer Module
 (FTM) timer support
In-Reply-To: <534FE3C1.4060509@linaro.org>
References: <1397614787-8300-1-git-send-email-Li.Xiubo@freescale.com>
 <1397614787-8300-4-git-send-email-Li.Xiubo@freescale.com>
 <534FE3C1.4060509@linaro.org>
Message-ID: <aa8f83c882144105b4c2c230dc6f517b@BY2PR03MB505.namprd03.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> > +	freq = clk_get_rate(ftm_clk);
> > +
> > +	calc_closest_cound_cyc(freq);
> > +
> > +	BUG_ON(ftm_clocksource_init(freq));
> > +
> > +	BUG_ON(ftm_clockevent_init(freq, irq));
> > +}
> > +CLOCKSOURCE_OF_DECLARE(vf610, "fsl,vf610-ftm-timer", ftm_timer_init);
> 
> 
> I am not a big fan of those BUG_ON every line. Could you please replace
> it by dev_err().
> 

While, for the FlexTimer driver, there hasn't any device creation and
registering, so I'll use pr_err() instead of dev_err()...

Thanks

BRs
Xiubo
