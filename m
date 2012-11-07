From: avinashphilip@ti.com (Philip, Avinash)
Date: Wed, 7 Nov 2012 15:20:30 +0000
Subject: [PATCH 6/8] pwm: pwm-tiehrpwm: Adding TBCLK gating support.
In-Reply-To: <B5906170F1614E41A8A28DE3B8D121433EC04483@DBDE01.ent.ti.com>
References: <1352106749-9437-1-git-send-email-avinashphilip@ti.com>
 <1352106749-9437-7-git-send-email-avinashphilip@ti.com>
 <B5906170F1614E41A8A28DE3B8D121433EC04483@DBDE01.ent.ti.com>
Message-ID: <518397C60809E147AF5323E0420B992E3E9DE3AA@DBDE01.ent.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Nov 06, 2012 at 12:16:13, Bedia, Vaibhav wrote:
> On Mon, Nov 05, 2012 at 14:42:27, Philip, Avinash wrote:
> [...]
> 
> > +	/* Some platforms require explicit tbclk gating */
> > +	if (of_property_read_bool(pdev->dev.of_node, "tbclkgating")) {
> > +		pc->tbclk = clk_get(&pdev->dev, "tbclk");
> > +		if (IS_ERR(pc->tbclk)) {
> > +			dev_err(&pdev->dev, "Could not get EHRPWM TBCLK\n");
> > +			return PTR_ERR(pc->tbclk);
> > +		}
> > +	}
> > +
> > +	/* Enable tbclk & leave */
> > +	if (pc->tbclk)
> > +		clk_enable(pc->tbclk);
> > +
> 
> Here also why are you leaving this clock always running?

This is an additional clock gating for EHRPWM functional clock from
control module. The enabling of this clock to pwm_enable 
& disabling to pwm_disable. I will correct it.



Thanks
Avinash

> 
> Regards,
> Vaibhav
> 
