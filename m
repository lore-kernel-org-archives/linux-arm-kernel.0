From: quentin.schulz@free-electrons.com (Quentin Schulz)
Date: Tue, 19 Jul 2016 10:35:46 +0200
Subject: [PATCH v2 3/4] mfd: add support for Allwinner SoCs ADC
In-Reply-To: <de8ebab2-cde9-d209-3c9a-e1868fafb84b@kernel.org>
References: <1468576754-3273-1-git-send-email-quentin.schulz@free-electrons.com>
 <1468576754-3273-4-git-send-email-quentin.schulz@free-electrons.com>
 <de8ebab2-cde9-d209-3c9a-e1868fafb84b@kernel.org>
Message-ID: <578DE662.90007@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 18/07/2016 15:25, Jonathan Cameron wrote:
> On 15/07/16 10:59, Quentin Schulz wrote:
>> The Allwinner SoCs all have an ADC that can also act as a touchscreen
>> controller and a thermal sensor. For now, only the ADC and the thermal
>> sensor drivers are probed by the MFD, the touchscreen controller support
>> will be added later.
>>
>> Signed-off-by: Quentin Schulz <quentin.schulz@free-electrons.com>
> Hmm. Previous patch includes the header this one creates.  Ordering issue?
> The depends kind of prevents build failures by ensuring that can't be built
> until this one is in place, but it is certainly an ugly way to do it.
> 
> Few little bits innline.
[...]
>> +static int sunxi_gpadc_mfd_probe(struct platform_device *pdev)
>> +{
>> +	struct sunxi_gpadc_mfd_dev *sunxi_gpadc_mfd_dev = NULL;
>> +	struct resource *mem = NULL;
> Neither of the above assignments is necessary as both will be explicitly
> assigned before they are otherwise used.

ACK.

[...]
>> +	dev_info(&pdev->dev, "successfully loaded\n");
> Seems like noise to me, but not my subsystem :)

ACK.
[...]
