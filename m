From: hartleys@visionengravers.com (H Hartley Sweeten)
Date: Thu, 9 Jun 2011 11:43:05 -0500
Subject: [PATCH] gpio-ep93xx: convert to platform_driver and use
	basic_mmio_gpio library
In-Reply-To: <20110608220757.GB17138@ponder.secretlab.ca>
References: <201106081435.33578.hartleys@visionengravers.com>
	<20110608220757.GB17138@ponder.secretlab.ca>
Message-ID: <ADE657CA350FB648AAC2C43247A983F001F3820B84D3@AUSP01VMBX24.collaborationhost.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday, June 08, 2011 3:08 PM, Grant Likely wrote:
>
> Merged, thanks.

Thanks.  I just noticed I left in a debug message I added when changing
this to a platform_driver.

>> +static int __init ep93xx_gpio_init(void)
>> +{
>> +	pr_info("%s\n", __func__);
>> +	return platform_driver_register(&ep93xx_gpio_driver);
>>  }

That pr_info shouldn't be there.  It just adds noise.

Would you prefer a full new patch or just an incremental patch to remove
this line?  The patch is already in next-20110609.

Thanks, sorry for the trouble.

Regards,
Hartley
