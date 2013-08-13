From: zonque@gmail.com (Daniel Mack)
Date: Tue, 13 Aug 2013 17:45:08 +0200
Subject: [PATCH] usb: musb dsps: fix pdev cast in suspend/resume
In-Reply-To: <20130813153738.GJ27954@radagast>
References: <1376397630-26863-1-git-send-email-zonque@gmail.com>
 <20130813153738.GJ27954@radagast>
Message-ID: <520A5484.5060908@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 13.08.2013 17:37, Felipe Balbi wrote:
> On Tue, Aug 13, 2013 at 02:40:30PM +0200, Daniel Mack wrote:

>> diff --git a/drivers/usb/musb/musb_dsps.c b/drivers/usb/musb/musb_dsps.c
>> index 5233804..f20218e 100644
>> --- a/drivers/usb/musb/musb_dsps.c
>> +++ b/drivers/usb/musb/musb_dsps.c
>> @@ -692,7 +692,7 @@ static int dsps_remove(struct platform_device *pdev)
>>  #ifdef CONFIG_PM_SLEEP
>>  static int dsps_suspend(struct device *dev)
>>  {
>> -	struct platform_device *pdev = to_platform_device(dev->parent);
>> +	struct platform_device *pdev = to_platform_device(dev);
>>  	struct dsps_glue *glue = platform_get_drvdata(pdev);
> 
> actually, can you get rid of the platform_device access here ? The
> following should work:
> 
> 	struct dsps_glue *glue = dev_get_drvdata(dev);
> 

Right, thank you Felipe. I just sent out v2.


Daniel
