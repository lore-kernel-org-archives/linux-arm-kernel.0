From: robert.jarzmik@free.fr (Robert Jarzmik)
Date: Fri, 03 Jul 2015 17:28:09 +0200
Subject: [PATCH-V2 11/12] i2c: pxa: Add ILCR (tLow & tHigh) configuration
 support
References: <vaibhav.hiremath@linaro.org>
 <1434383399-2370-1-git-send-email-vaibhav.hiremath@linaro.org>
 <1434383399-2370-12-git-send-email-vaibhav.hiremath@linaro.org>
Message-ID: <87vbe1b6ra.fsf@belgarion.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Vaibhav Hiremath <vaibhav.hiremath@linaro.org> writes:

> +	i2c->clk = devm_clk_get(&dev->dev, NULL);
> +	if (IS_ERR(i2c->clk)) {
> +		dev_err(&dev->dev, "failed to get the clk\n");
> +		dev_err(&dev->dev, "failed to get the clk: %ld\n", PTR_ERR(i2c->clk));

> +		return PTR_ERR(i2c->clk);
> +	}
Why is this block moving up ? I can't find the reason in the commit message or
in the code.

Cheers.

-- 
Robert
