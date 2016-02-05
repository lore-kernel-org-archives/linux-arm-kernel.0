From: yang.shi@linaro.org (Shi, Yang)
Date: Fri, 5 Feb 2016 12:45:25 -0800
Subject: [PATCH] PCI: layerscape: add ls2085a compatible
In-Reply-To: <20160205203858.GA11780@localhost>
References: <1453915925-19198-1-git-send-email-yang.shi@linaro.org>
 <20160205203858.GA11780@localhost>
Message-ID: <56B509E5.2050602@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2/5/2016 12:38 PM, Bjorn Helgaas wrote:
> [+cc Rob, et al]
>
> On Wed, Jan 27, 2016 at 09:32:05AM -0800, Yang Shi wrote:
>> The layerscape PCI host driver needs recognize ls2085a compatible when using
>> firmware with ls2085a compatible property, otherwise the PCI bus won't be
>> detected even though ls2085a compatible is included by the dts.
>>
>> Signed-off-by: Yang Shi <yang.shi@linaro.org>
>> ---
>>   drivers/pci/host/pci-layerscape.c | 1 +
>>   1 file changed, 1 insertion(+)
>>
>> diff --git a/drivers/pci/host/pci-layerscape.c b/drivers/pci/host/pci-layerscape.c
>> index 3923bed..c40d8b2 100644
>> --- a/drivers/pci/host/pci-layerscape.c
>> +++ b/drivers/pci/host/pci-layerscape.c
>> @@ -203,6 +203,7 @@ static const struct of_device_id ls_pcie_of_match[] = {
>>   	{ .compatible = "fsl,ls1021a-pcie", .data = &ls1021_drvdata },
>>   	{ .compatible = "fsl,ls1043a-pcie", .data = &ls1043_drvdata },
>>   	{ .compatible = "fsl,ls2080a-pcie", .data = &ls2080_drvdata },
>> +	{ .compatible = "fsl,ls2085a-pcie", .data = &ls2080_drvdata },
>
> Hmm, "fsl,ls2085a-pcie" doesn't appear in
> Documentation/devicetree/bindings/pci/.
>
> Aren't we supposed to add these strings to the bindings before or at
> the same time we add them to drivers?

The below patch will add it into dts and binding doc. I should mentioned 
this in the commit log.

https://patchwork.kernel.org/patch/7767061/

Thanks,
Yang

>
> checkpatch doesn't complain though, so maybe I'm wrong about this.
>
>>   	{ },
>>   };
>>   MODULE_DEVICE_TABLE(of, ls_pcie_of_match);
>> --
>> 2.0.2
>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-pci" in
>> the body of a message to majordomo at vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
