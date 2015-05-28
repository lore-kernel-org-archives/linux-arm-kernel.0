From: swarren@wwwdotorg.org (Stephen Warren)
Date: Thu, 28 May 2015 16:10:24 -0600
Subject: [PATCH 2/3 v4] ARM: bcm2835: Add the Raspberry Pi firmware driver
In-Reply-To: <55678BBC.5090507@tronnes.org>
References: <20150528114500.GP11677@x1>
 <1432837987-22861-1-git-send-email-eric@anholt.net>
 <55678BBC.5090507@tronnes.org>
Message-ID: <55679250.1040708@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05/28/2015 03:42 PM, Noralf Tr?nnes wrote:
> 
> Den 28.05.2015 20:33, skrev Eric Anholt:
>> This gives us a function for making mailbox property channel requests
>> of the firmware, which is most notable in that it will let us get and
>> set clock rates.

>> +static int rpi_firmware_remove(struct platform_device *pdev)
>> +{
>> +    struct rpi_firmware *fw = platform_get_drvdata(pdev);
>> +
>> +    mbox_free_channel(fw->chan);
> 
> I guess driver data has to be reset here:
> platform_set_drvdata(pdev, NULL);

The value of the drvdata is irrelevant before the device has probed, or
after it has been removed. Hence, drivers should not manually clear
drvdata. (Many drivers used to, but that code is being purged out).
