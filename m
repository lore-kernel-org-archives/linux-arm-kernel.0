From: awg@embtoolkit.org (Abdoulaye Walsimou GAYE)
Date: Tue, 21 Sep 2010 07:28:39 +0200
Subject: [PATCH] ARM: s3c2442: Setup gpio {set,get}_pull callbacks
In-Reply-To: <4C97F11B.50806@fluff.org>
References: <1285020052-20020-1-git-send-email-lars@metafoo.de>
	<4C97F11B.50806@fluff.org>
Message-ID: <4C984287.7020009@embtoolkit.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 09/21/2010 01:41 AM, Ben Dooks wrote:
> On 20/09/10 23:00, Lars-Peter Clausen wrote:
>    
>> Currently the {set,get}_pull callbacks of the s3c24xx_gpiocfg_default structure
>> are not initalized for the s3c2442 cpu type. This results in a NULL-pointer
>> deref upon calling s3c_gpio_setpull.
>>
>> The s3c2442 has pulldowns instead of pullups compared to the s3c2440.
>> The method of controlling them is the same though.
>> So this patch modifies the existing s3c_gpio_{get,set}pull_1up helper functions
>> to take an additional parameter deciding whether the pin has a pullup or
>> pulldown.
>> The s3c_gpio_{get,set}pull_1{down,up} functions then wrap that functions passing
>> either S3C_GPIO_PULL_UP or S3C_GPIO_PULL_DOWN.
>>
>> Furthermore this patch sets up the s3c24xx_gpiocfg_default.{get,set}_pull fields
>> in the s3c2442 cpu init function to the new pulldown helper functions.
>>
>> Signed-off-by: Lars-Peter Clausen<lars@metafoo.de>
>>      
> Initial reading looks ok, will see about adding it to my -next tree.
>    


Hello,
It is very urgent to get rid on these issues in gpiolib, I think they 
prevent many
s3c24xx based boards to boot and I reported it 3 months ago.
So fixes in this area should not go in any kind on of -next branch but 
instead -urgent-fixes.

Best regards,
AWG
