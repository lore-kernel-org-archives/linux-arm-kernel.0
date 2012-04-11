From: shubhrajyoti@ti.com (Shubhrajyoti)
Date: Wed, 11 Apr 2012 17:26:26 +0530
Subject: [PATCHv7 11/18] I2C: OMAP: use devm_* functions
In-Reply-To: <20120411113456.GF12064@arwen.pp.htv.fi>
References: <1334142776-10583-1-git-send-email-shubhrajyoti@ti.com>
 <1334142776-10583-12-git-send-email-shubhrajyoti@ti.com>
 <20120411113456.GF12064@arwen.pp.htv.fi>
Message-ID: <4F85716A.4030308@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 11 April 2012 05:04 PM, Felipe Balbi wrote:
> On Wed, Apr 11, 2012 at 04:42:49PM +0530, Shubhrajyoti D wrote:
>> The various devm_ functions allocate memory that is released when a driver
>> detaches. This patch uses devm_kzalloc, devm_request_mem_region and
>> devm_ioremap for data that is allocated in the probe function of a platform
>> device and is only freed in the remove function.
>>
>> Signed-off-by: Shubhrajyoti D <shubhrajyoti@ti.com>
>> ---
>>  drivers/i2c/busses/i2c-omap.c |   29 +++++++++--------------------
>>  1 files changed, 9 insertions(+), 20 deletions(-)
>>
>> diff --git a/drivers/i2c/busses/i2c-omap.c b/drivers/i2c/busses/i2c-omap.c
>> index 121c52e..86be475 100644
>> --- a/drivers/i2c/busses/i2c-omap.c
>> +++ b/drivers/i2c/busses/i2c-omap.c
>> @@ -995,17 +995,17 @@ omap_i2c_probe(struct platform_device *pdev)
>>  		return -ENODEV;
>>  	}
>>  
>> -	ioarea = request_mem_region(mem->start, resource_size(mem),
>> -			pdev->name);
>> +	ioarea = devm_request_mem_region(&pdev->dev, mem->start,
>> +			resource_size(mem), pdev->name);
> you could use devm_request_and_ioremap()
OK will do that.

thanks,
