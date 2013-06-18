From: florian.vaussard@epfl.ch (Florian Vaussard)
Date: Tue, 18 Jun 2013 10:53:50 +0200
Subject: [PATCH 1/3] mfd: twl4030-power: Split from twl-core into a
 dedicated module
In-Reply-To: <20130617235644.GB7998@zurbaran>
References: <1369921916-7435-1-git-send-email-florian.vaussard@epfl.ch>
 <1369921916-7435-2-git-send-email-florian.vaussard@epfl.ch>
 <20130617235644.GB7998@zurbaran>
Message-ID: <51C0201E.2040909@epfl.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

Thank you for the review.

On 06/18/2013 01:56 AM, Samuel Ortiz wrote:
> Hi Florian,
>
> On Thu, May 30, 2013 at 03:51:54PM +0200, Florian Vaussard wrote:
>> For now, the call to twl4030-power is hard-wired inside twl-core.
>> To ease the future transition to DT, make twl4030-power as a
>> separate module, like what is already done for twl4030-audio
>> and others.
>>
>> Signed-off-by: Florian Vaussard <florian.vaussard@epfl.ch>
>> ---
>>   drivers/mfd/twl-core.c      |   12 ++++++---
>>   drivers/mfd/twl4030-power.c |   54 +++++++++++++++++++++++++++++++++++--------
>>   include/linux/i2c/twl.h     |    1 -
>>   3 files changed, 52 insertions(+), 15 deletions(-)
> Looks good, I only have one comment:
>
>> +static struct platform_driver twl4030_power_driver = {
>> +	.driver = {
>> +		.name	= "twl4030_power",
>> +		.owner	= THIS_MODULE,
>> +	},
>> +	.probe		= twl4030_power_probe,
>> +	.remove		= twl4030_power_remove,
>> +};
>> +
>> +static int __init twl4030_power_init(void)
>> +{
>> +	return platform_driver_register(&twl4030_power_driver);
>>   }
>> +subsys_initcall(twl4030_power_init);
>> +
>> +static void __exit twl4030_power_exit(void)
>> +{
>> +	platform_driver_unregister(&twl4030_power_driver);
>> +}
>> +module_exit(twl4030_power_exit);
> Please use module_platform_driver() here.
>

Sure!

Regards,

Florian
