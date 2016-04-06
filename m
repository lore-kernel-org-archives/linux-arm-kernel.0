From: stanimir.varbanov@linaro.org (Stanimir Varbanov)
Date: Wed, 6 Apr 2016 18:05:18 +0300
Subject: [PATCH v2 3/5] dmaengine: qcom: bam_dma: add controlled remotely
 dt property
In-Reply-To: <20160405234425.GD11586@vkoul-mobl.iind.intel.com>
References: <1459896982-30171-1-git-send-email-stanimir.varbanov@linaro.org>
 <1459896982-30171-4-git-send-email-stanimir.varbanov@linaro.org>
 <20160405234425.GD11586@vkoul-mobl.iind.intel.com>
Message-ID: <570525AE.7070700@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/06/2016 02:44 AM, Vinod Koul wrote:
> On Wed, Apr 06, 2016 at 01:56:20AM +0300, Stanimir Varbanov wrote:
>>  Documentation/devicetree/bindings/dma/qcom_bam_dma.txt | 2 ++
>>  drivers/dma/qcom/bam_dma.c                             | 7 +++++++
> 
> The binding should be a separate patch..

I'm not sure, isn't this rule valid only when we introduce the binding
document? But if you insist I can make a separate patch.

> 
>>  
>> +	bdev->controlled_remotely = of_property_read_bool(pdev->dev.of_node,
>> +						"qcom,controlled-remotely");
>> +
> 
> we need some defaults here, how will this work with boards withe older DT.
> 

if the introduced property missing from DT node the driver behavior is
preserved.

-- 
regards,
Stan
