From: sboyd@codeaurora.org (Stephen Boyd)
Date: Wed, 10 Feb 2016 10:35:04 -0800
Subject: [PATCH 01/14] mfd: intel_quark_i2c_gpio: Use clkdev_create()
In-Reply-To: <20160210162349.GJ3782@x1>
References: <1454982341-22715-1-git-send-email-sboyd@codeaurora.org>
 <1454982341-22715-2-git-send-email-sboyd@codeaurora.org>
 <20160210162349.GJ3782@x1>
Message-ID: <20160210183504.GG30978@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 02/10, Lee Jones wrote:
> On Mon, 08 Feb 2016, Stephen Boyd wrote:
> 
> > Convert this driver to use clkdev_create() instead of
> > clk_register_clkdevs(). The latter API is only used by this driver,
> > although this driver only allocates one clk to add anyway.
> > Furthermore, this driver allocates the clk_lookup structure with
> > devm, but clkdev_drop() will free that structure when passed,
> > leading to a double free when this driver is removed. Clean it
> > all up and pave the way for the removal of clk_register_clkdevs().
> > 
> > Cc: Lee Jones <lee.jones@linaro.org>
> > Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> > Cc: Russell King <linux@arm.linux.org.uk>
> > Signed-off-by: Stephen Boyd <sboyd@codeaurora.org>
> > ---
> >  drivers/mfd/intel_quark_i2c_gpio.c | 26 +++++++++-----------------
> >  1 file changed, 9 insertions(+), 17 deletions(-)
> 
> I never much liked this code [0]
> 
> Glad for it to be simplified.
> 
> Applied, thanks.
> 

Can you please ack the patch instead? I'd like to take it through
the clk tree so that I can remove clk_register_clkdevs() as well.

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
