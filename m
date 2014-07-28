From: cw00.choi@samsung.com (Chanwoo Choi)
Date: Mon, 28 Jul 2014 20:18:02 +0900
Subject: [PATCH 2/2] iio: adc: exynos_adc: Add support for S3C24xx ADC
In-Reply-To: <5954793.q4YDWmuNDB@wuerfel>
References: <1405995074-3271-1-git-send-email-cw00.choi@samsung.com>
 <1405995074-3271-3-git-send-email-cw00.choi@samsung.com>
 <5954793.q4YDWmuNDB@wuerfel>
Message-ID: <53D6316A.2010007@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/22/2014 09:59 PM, Arnd Bergmann wrote:
> On Tuesday 22 July 2014 11:11:14 Chanwoo Choi wrote:
>> This patch add support for s3c2410/s3c2416/s3c2440/s3c2443 ADC. The s3c24xx
>> is alomost same as ADCv1. But, There are a little difference as following:
>> - ADCMUX register address to select channel
>> - ADCDAT mask (10bit or 12bit ADC resolution according to SoC version)
>>
>> Signed-off-by: Chanwoo Choi <cw00.choi@samsung.com>
>> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
>>
> 
> While looking at the driver again to see if the touchscreen patch needs
> an update for this, I noticed that the s3c24xx variants don't have the
> ADC_V1_INTCLR and ADC_V1_CLRINTPNDNUP registers, so I assume your patch
> will have to be updated not to acknowledge the interrupts.
> 
> It's possible that writing to the missing registers is harmless though and
> that you don't need that change.

OK, I'll remove the function pointer of clear_irq for s3c24xx.

Best Regards,
Chanwoo Choi
