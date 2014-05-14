From: mturquette@linaro.org (Mike Turquette)
Date: Wed, 14 May 2014 15:39:35 -0700
Subject: [PATCH v3 5/7] clk: sunxi: add PRCM (Power/Reset/Clock
 Management) clks support
In-Reply-To: <53731BB3.4060504@free-electrons.com>
References: <1399633911-7094-1-git-send-email-boris.brezillon@free-electrons.com>
 <1399633911-7094-6-git-send-email-boris.brezillon@free-electrons.com>
 <20140514005119.16152.19787@quantum> <53731BB3.4060504@free-electrons.com>
Message-ID: <20140514223935.19795.36960@quantum>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Quoting Boris BREZILLON (2014-05-14 00:30:59)
> Hello Mike,
> 
> On 14/05/2014 02:51, Mike Turquette wrote:
> > Quoting Boris BREZILLON (2014-05-09 04:11:49)
> >> +struct clk_ops ar100_ops = {
> >> +       .recalc_rate = ar100_recalc_rate,
> >> +       .determine_rate = ar100_determine_rate,
> >> +       .set_parent = ar100_set_parent,
> >> +       .get_parent = ar100_get_parent,
> >> +       .set_rate = ar100_set_rate,
> >> +};
> > I might be having a brain fart, but is there a valid case for having
> > both a .recalc_rate and a .determine_rate? I believe that the former
> > will never be used and the latter will always be used by the clock
> > framework core.
> 
> I think you're mistaking recalc_rate for round_rate.
> AFAIK, recalc_rate is mandatory for a clk that implement either
> round_rate or determine_rate.

I *was* having a brain fart. You're right of course. Too many .r*_rate()
callbacks...

Thanks,
Mike

> 
> 
> Best Regards,
> 
> Boris
> 
> -- 
> Boris Brezillon, Free Electrons
> Embedded Linux and Kernel engineering
> http://free-electrons.com
> 
