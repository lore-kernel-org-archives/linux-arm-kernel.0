From: ivan.khoronzhuk@ti.com (ivan.khoronzhuk)
Date: Mon, 25 Nov 2013 13:09:07 +0200
Subject: Fwd: [PATCH 6/8] watchdog: davinci: reuse driver for keystone arch
In-Reply-To: <201311231902.02807.arnd@arndb.de>
References: <1383680783-12114-7-git-send-email-ivan.khoronzhuk@ti.com>
 <527A28DE.4030906@ti.com> <201311231902.02807.arnd@arndb.de>
Message-ID: <52932FD3.10508@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/23/2013 08:02 PM, Arnd Bergmann wrote:
> On Wednesday 06 November 2013, ivan.khoronzhuk wrote:
> 
>> @@ -1,13 +1,20 @@
>> -DaVinci Watchdog Timer (WDT) Controller
>> +Texas Instruments DaVinci/Keystone Watchdog Timer (WDT) Controller
>>   
>>   Required properties:
>> -- compatible : Should be "ti,davinci-wdt"
>> +
>> +- compatible:          "ti,davinci-wdt"
>> +                       "ti,keystone-wdt"
>> +
>>   - reg : Should contain WDT registers location and length
>>   
> 
> ...
> 
>> @@ -229,6 +229,7 @@ static int davinci_wdt_remove(struct platform_device *pdev)
>>   
>>   static const struct of_device_id davinci_wdt_of_match[] = {
>>          { .compatible = "ti,davinci-wdt", },
>> +       { .compatible = "ti,keystone-wdt", },
>>          {},
>>   };
>>   MODULE_DEVICE_TABLE(of, davinci_wdt_of_match);
> 
> You should clarify the compatible list here: It seems that the devices are fully
> compatible, so the driver should only need to check for "ti,davinci-wdt" as the
> compatible string, while the dtb files should list both "ti,davinci-wdt" and
> "ti,keystone-wdt" for keystone, but only the davinci string for davinci.
> 
> 	Arnd
> 

Ok, I will remove "ti,keystone-wdt" compatible from driver and for the keystone WDT node
describe compatible as:

compatible = "ti,keystone-wdt", "ti,davinci-wdt";

-- 
Regards,
Ivan Khoronzhuk
