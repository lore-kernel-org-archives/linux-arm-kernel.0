From: sshtylyov@mvista.com (Sergei Shtylyov)
Date: Tue, 29 Mar 2011 16:56:14 +0400
Subject: [PATCH] ep93xx: add support Vision EP9307 SoM
In-Reply-To: <4D90E1B8.7080405@bluewatersys.com>
References: <201103281127.42908.hartleys@visionengravers.com>
	<4D90E1B8.7080405@bluewatersys.com>
Message-ID: <4D91D6EE.3090309@ru.mvista.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello.

On 28-03-2011 23:30, Ryan Mallon wrote:

>> Add support for Vision Engraving Systems EP9307 based SoM.

>> Signed-off-by: Hartley Sweeten<hartleys@visionengravers.com>
>> Cc: Ryan Mallon<ryan@bluewatersys.com>

> Hi Hartley,

> Looks mostly good. Couple of minor comments below.

> ~Ryan

>> ---

>> diff --git a/arch/arm/mach-ep93xx/vision_ep9307.c b/arch/arm/mach-ep93xx/vision_ep9307.c
>> new file mode 100644
>> index 0000000..cb2d400
>> --- /dev/null
>> +++ b/arch/arm/mach-ep93xx/vision_ep9307.c
>> @@ -0,0 +1,377 @@
[...]
>> +static void vision_lcd_blank(int blank_mode, struct fb_info *info)
>> +{
>> +	if (blank_mode)
>> +		gpio_set_value(VISION_LCD_ENABLE, 0);
>> +	else
>> +		gpio_set_value(VISION_LCD_ENABLE, 1);

> This can just be:
>
> 	gpio_set_value(VISION_LCD_ENABLE, blank_mode ^ 1);

    Rather:

	gpio_set_value(VISION_LCD_ENABLE, !blank_mode);

WBR, Sergei
