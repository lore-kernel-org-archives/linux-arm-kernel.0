From: vaibhav.bedia@ti.com (Bedia, Vaibhav)
Date: Tue, 6 Nov 2012 06:46:13 +0000
Subject: [PATCH 6/8] pwm: pwm-tiehrpwm: Adding TBCLK gating support.
In-Reply-To: <1352106749-9437-7-git-send-email-avinashphilip@ti.com>
References: <1352106749-9437-1-git-send-email-avinashphilip@ti.com>
 <1352106749-9437-7-git-send-email-avinashphilip@ti.com>
Message-ID: <B5906170F1614E41A8A28DE3B8D121433EC04483@DBDE01.ent.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Nov 05, 2012 at 14:42:27, Philip, Avinash wrote:
[...]

> +	/* Some platforms require explicit tbclk gating */
> +	if (of_property_read_bool(pdev->dev.of_node, "tbclkgating")) {
> +		pc->tbclk = clk_get(&pdev->dev, "tbclk");
> +		if (IS_ERR(pc->tbclk)) {
> +			dev_err(&pdev->dev, "Could not get EHRPWM TBCLK\n");
> +			return PTR_ERR(pc->tbclk);
> +		}
> +	}
> +
> +	/* Enable tbclk & leave */
> +	if (pc->tbclk)
> +		clk_enable(pc->tbclk);
> +

Here also why are you leaving this clock always running?

Regards,
Vaibhav
