From: andre.przywara@arm.com (=?UTF-8?Q?Andr=c3=a9_Przywara?=)
Date: Mon, 1 Feb 2016 23:02:15 +0000
Subject: [linux-sunxi] Re: [PATCH 05/11] drivers: pinctrl: add driver for
 Allwinner A64 SoC
In-Reply-To: <20160201184505.GB14737@excalibur.cnev.de>
References: <1454348370-3816-1-git-send-email-andre.przywara@arm.com>
 <1454348370-3816-6-git-send-email-andre.przywara@arm.com>
 <20160201182754.GA14737@excalibur.cnev.de>
 <20160201184505.GB14737@excalibur.cnev.de>
Message-ID: <56AFE3F7.6050204@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 01/02/16 18:45, Karsten Merker wrote:
> Hello,
> 
> I by mistake pressed "send" on my previous mail when I intended
> to further edit it, so here comes a followup.
> I definitely need more coffee ;-).

Or less?  ;-)             vvvvvvvvvv Thinking of twitchy fingers...
> On Mon, Feb 01, 2016 at 07:27:54PM +0100, Karsten Merker wrote:
>> On Mon, Feb 01, 2016 at 05:39:24PM +0000, Andre Przywara wrote:
> 
>>> +static const struct sunxi_pinctrl_desc a64_pinctrl_data = {
>>> +	.pins = a64_pins,
>>> +	.npins = ARRAY_SIZE(a64_pins),
>>> +	.irq_banks = 3,
>>> +};
>>> +
>>> +static int a64_pinctrl_probe(struct platform_device *pdev)
>>> +{
>>> +	return sunxi_pinctrl_init(pdev,
>>> +				  &a64_pinctrl_data);
>>> +}
>>> +
>>> +static const struct of_device_id a64_pinctrl_match[] = {
>>> +	{ .compatible = "allwinner,a64-pinctrl", },
> 
> s/allwinner,a64-pinctrl/allwinner,sun50i-a64-pinctrl/ ?

As mentioned in the other mail, allwinner should be enough to make the
naming unique. Especially as this is about DT namings, which should be
valid outside of the Linux world even.

Cheers,
Andre.

> 
>>> +	{}
>>> +};
>>> +MODULE_DEVICE_TABLE(of, a64_pinctrl_match);
>>> +
>>> +static struct platform_driver a64_pinctrl_driver = {
>>> +	.probe	= a64_pinctrl_probe,
>>> +	.driver	= {
>>> +		.name		= "a64-pinctrl",
>>> +		.of_match_table	= a64_pinctrl_match,
>>> +	},
>>> +};
>>> +module_platform_driver(a64_pinctrl_driver);
>>> +
>>> +MODULE_AUTHOR("Andre Przywara <andre.przywara@arm.com>");
>>> +MODULE_DESCRIPTION("Allwinner A64 pinctrl driver");
>>> +MODULE_LICENSE("GPL");
>>
>> For the above function names one could also think about using the
> 
> s/function names/variable definitions/
> 
>> existing naming scheme including the SoC family as we do in the
>> other sunxi pinctrl drivers, but as they are only internal to the
>> driver, that would really just be a matter of cosmetics :-).
> 
> Regards,
> Karsten
> 
