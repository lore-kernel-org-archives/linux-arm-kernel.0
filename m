From: shuahkh@osg.samsung.com (Shuah Khan)
Date: Tue, 10 Jan 2017 17:24:51 -0700
Subject: [PATCH] usb: dwc3-exynos remove suspend clock unspecified debug
 message
In-Reply-To: <74dfb6fb-6ab0-135b-5d0a-60b69f35ff5a@osg.samsung.com>
References: <20170110212059.21995-1-shuahkh@osg.samsung.com>
 <74dfb6fb-6ab0-135b-5d0a-60b69f35ff5a@osg.samsung.com>
Message-ID: <1bf1b0bc-9295-1484-8ab9-a380afd69ccb@osg.samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 01/10/2017 05:18 PM, Javier Martinez Canillas wrote:
> Hello Shuah,
> 
> On 01/10/2017 06:20 PM, Shuah Khan wrote:
>> dwc3-exynos prints debug message when suspend clock is not specified.
>> The suspend clock is optional and driver can work without it.
>>
>> This debug message doesn't add any value and leads to confusion and
>> concern. Remove it.
>>
>> Signed-off-by: Shuah Khan <shuahkh@osg.samsung.com>
>> ---
>> This patch is a result of the disussion on the following patch.
>> https://lkml.org/lkml/2017/1/9/891
>>
>> drivers/usb/dwc3/dwc3-exynos.c | 4 +---
>>  1 file changed, 1 insertion(+), 3 deletions(-)
>>
>> diff --git a/drivers/usb/dwc3/dwc3-exynos.c b/drivers/usb/dwc3/dwc3-exynos.c
>> index e27899b..3e8407a 100644
>> --- a/drivers/usb/dwc3/dwc3-exynos.c
>> +++ b/drivers/usb/dwc3/dwc3-exynos.c
>> @@ -128,10 +128,8 @@ static int dwc3_exynos_probe(struct platform_device *pdev)
>>  	clk_prepare_enable(exynos->clk);
>>  
>>  	exynos->susp_clk = devm_clk_get(dev, "usbdrd30_susp_clk");
>> -	if (IS_ERR(exynos->susp_clk)) {
>> -		dev_info(dev, "no suspend clk specified\n");
> 
> Sorry for being late in the discussion, but what about making it a
> dev_dbg() instead? That way the message may not confuse others but
> still keep information that could be useful for debugging purposes.
> 
> I know the current message isn't great but keeping it as debug allows
> to improve it later.
> 
> Best regards,
> 

I proposed dev debug and the recommendation from  Krzysztof was to
just remove it. Please see response from Krzysztof's response.

thanks,
-- Shuah
