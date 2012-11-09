From: avinashphilip@ti.com (Philip, Avinash)
Date: Fri, 9 Nov 2012 10:59:30 +0000
Subject: [PATCH v2 08/10] pwm: pwm-tiehrpwm: Adding TBCLK gating support.
In-Reply-To: <20121109081104.GB26007@avionic-0098.mockup.avionic-design.de>
References: <1352361197-27442-1-git-send-email-avinashphilip@ti.com>
 <1352361197-27442-9-git-send-email-avinashphilip@ti.com>
 <20121109081104.GB26007@avionic-0098.mockup.avionic-design.de>
Message-ID: <518397C60809E147AF5323E0420B992E3E9E4501@DBDE01.ent.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Nov 09, 2012 at 13:41:04, Thierry Reding wrote:
> On Thu, Nov 08, 2012 at 01:23:15PM +0530, Philip, Avinash wrote:
...
> > +	/* Some platforms require explicit tbclk gating */
> > +	if (of_property_read_bool(pdev->dev.of_node, "tbclkgating")) {
> 
> Is it really necessary to have an extra boolean property for this?
> Couldn't this just be handled by not defining a clock for the tbclk
> consumer in board setup/DT

If no clk node defined, driver can still continue expecting this platform 
the requirement is not there. So I will check for tbclk with devm_clk_get()
and continue by removing Boolean property.

> 
> > +		pc->tbclk = clk_get(&pdev->dev, "tbclk");
> 
> You should be using devm_clk_get() or add a matching clk_put() in
> .remove().

Ok

Thanks
Avinash

> 
> Thierry
> 
