From: robherring2@gmail.com (Rob Herring)
Date: Thu, 10 Nov 2011 11:07:37 -0600
Subject: [PATCH 1/3 V2] ARM: pxa: Add DT support to pxa2xx-uart
In-Reply-To: <201111101759.33994.marek.vasut@gmail.com>
References: <1320172354-3795-1-git-send-email-marek.vasut@gmail.com>
 <1320701506-26812-2-git-send-email-marek.vasut@gmail.com>
 <20111110120058.GQ12913@n2100.arm.linux.org.uk>
 <201111101759.33994.marek.vasut@gmail.com>
Message-ID: <4EBC04D9.1050007@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/10/2011 10:59 AM, Marek Vasut wrote:
>> On Mon, Nov 07, 2011 at 10:31:43PM +0100, Marek Vasut wrote:
>>> @@ -781,11 +783,48 @@ static const struct dev_pm_ops serial_pxa_pm_ops =
>>> {
>>>
>>>  };
>>>  #endif
>>>
>>> +#ifdef CONFIG_OF
>>> +static struct of_device_id serial_pxa_dt_ids[] = {
>>> +	{ .compatible = "marvell,pxa2xx-uart" },
>>> +	{ /* sentinel */ }
>>> +};
>>> +MODULE_DEVICE_TABLE(of, serial_pxa_dt_ids);
>>> +
>>> +static int serial_pxa_probe_dt(struct platform_device *pdev, int
>>> *portid) +{
>>> +	struct device_node *np = pdev->dev.of_node;
>>> +	int ret;
>>> +
>>> +	if (!np)
>>> +		return -ENODEV;
>>> +
>>> +	ret = of_alias_get_id(np, "serial");
>>> +	if (ret < 0) {
>>> +		dev_err(&pdev->dev, "Failed to get alias id, errno %d\n", ret);
>>
>> Is this documented somewhere (eg, an example dt snippet for a PXA uart).
> 
> Yes it is, in patch 3/3 I'm adding an example DT code for vpac270 machine.

No, you need to add both machine and uart binding documentation in
Documentation/devicetree/bindings/

Rob

> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
