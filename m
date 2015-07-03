From: vaibhav.hiremath@linaro.org (Vaibhav Hiremath)
Date: Fri, 03 Jul 2015 23:47:10 +0530
Subject: [PATCH-V2 11/12] i2c: pxa: Add ILCR (tLow & tHigh) configuration
 support
In-Reply-To: <87vbe1b6ra.fsf@belgarion.home>
References: <vaibhav.hiremath@linaro.org>	<1434383399-2370-1-git-send-email-vaibhav.hiremath@linaro.org>	<1434383399-2370-12-git-send-email-vaibhav.hiremath@linaro.org>
 <87vbe1b6ra.fsf@belgarion.home>
Message-ID: <5596D1A6.7030600@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On Friday 03 July 2015 08:58 PM, Robert Jarzmik wrote:
> Vaibhav Hiremath <vaibhav.hiremath@linaro.org> writes:
>
>> +	i2c->clk = devm_clk_get(&dev->dev, NULL);
>> +	if (IS_ERR(i2c->clk)) {
>> +		dev_err(&dev->dev, "failed to get the clk\n");
>> +		dev_err(&dev->dev, "failed to get the clk: %ld\n", PTR_ERR(i2c->clk));
>
>> +		return PTR_ERR(i2c->clk);
>> +	}
> Why is this block moving up ? I can't find the reason in the commit message or
> in the code.
>

Because of obvious reason :)

The clk_rate is being used in i2c_pxa_probe_dt() function.

Although I did not mention in commit description as I felt it is
evident from the patch.
Probably should have been more descriptive here, sorry for that.
I will take care of it in next version.

Thanks,
Vaibhav
