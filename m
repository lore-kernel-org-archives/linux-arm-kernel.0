From: shawn.guo@linaro.org (Shawn Guo)
Date: Tue, 8 Jan 2013 21:10:48 +0800
Subject: [PATCH 2/3] cpufreq: add imx6q-cpufreq driver
In-Reply-To: <20130108112856.GA19534@S2101-09.ap.freescale.net>
References: <1357628043-19256-1-git-send-email-shawn.guo@linaro.org>
 <1357628043-19256-3-git-send-email-shawn.guo@linaro.org>
 <20130108085756.GM1906@pengutronix.de>
 <20130108112856.GA19534@S2101-09.ap.freescale.net>
Message-ID: <20130108131046.GB19534@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jan 08, 2013 at 07:28:59PM +0800, Shawn Guo wrote:
> > > +	cpu_dev->of_node = np;
> > > +
> > > +	arm_clk = clk_get(cpu_dev, "arm");
> > > +	pll1_sys_clk = clk_get(cpu_dev, "pll1_sys");
> > > +	pll1_sw_clk = clk_get(cpu_dev, "pll1_sw");
> > > +	step_clk = clk_get(cpu_dev, "step");
> > > +	pll2_pfd2_396m_clk = clk_get(cpu_dev, "pll2_pfd2_396m");
> > 
> > devm_*?
> > 
> That what I tried to do at the first time.  But the dev of cpu is
> special, and managed functions do not work as we expect with it.
> 
Inspired by the comment, I think I should attach /cpus/cpu at 0 node to
pdev->dev instead of the one retrieved from get_cpu_device(0), so that
both managed functions and dev_* print can work.

Shawn
