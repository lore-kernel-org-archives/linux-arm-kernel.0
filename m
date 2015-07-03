From: vaibhav.hiremath@linaro.org (Vaibhav Hiremath)
Date: Fri, 03 Jul 2015 23:44:06 +0530
Subject: [PATCH-V2 07/12] i2c:pxa: Use devm_ variants in probe function
In-Reply-To: <873815clbx.fsf@belgarion.home>
References: <vaibhav.hiremath@linaro.org>	<1434383399-2370-1-git-send-email-vaibhav.hiremath@linaro.org>	<1434383399-2370-8-git-send-email-vaibhav.hiremath@linaro.org>
 <873815clbx.fsf@belgarion.home>
Message-ID: <5596D0EE.8080008@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On Friday 03 July 2015 08:58 PM, Robert Jarzmik wrote:
> Vaibhav Hiremath <vaibhav.hiremath@linaro.org> writes:
>
>> @@ -1201,16 +1201,17 @@ static int i2c_pxa_probe(struct platform_device *dev)
>>
>>   	strlcpy(i2c->adap.name, "pxa_i2c-i2c", sizeof(i2c->adap.name));
>>
>> -	i2c->clk = clk_get(&dev->dev, NULL);
>> +	i2c->clk = devm_clk_get(&dev->dev, NULL);
>>   	if (IS_ERR(i2c->clk)) {
>> -		ret = PTR_ERR(i2c->clk);
>> -		goto eclk;
>> +		dev_err(&dev->dev, "failed to get the clk\n");
> For consistency's sake, please use :
> 		dev_err(&dev->dev, "failed to get the clk: %ld\n", PTR_ERR(i2c->clk));
>

Will include it in next version.

> Once that is done, you can add my :
> Acked-by: Robert Jarzmik <robert.jarzmik@free.fr>
>

Thanks for your ack

Thanks,
Vaibhav
