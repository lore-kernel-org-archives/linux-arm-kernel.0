From: ryan@bluewatersys.com (Ryan Mallon)
Date: Tue, 29 Mar 2011 08:48:54 +1300
Subject: [PATCH] ep93xx: add support Vision EP9307 SoM
In-Reply-To: <0D753D10438DA54287A00B027084269764D194F007@AUSP01VMBX24.collaborationhost.net>
References: <201103281127.42908.hartleys@visionengravers.com>
	<4D90E1B8.7080405@bluewatersys.com>
	<0D753D10438DA54287A00B027084269764D194F007@AUSP01VMBX24.collaborationhost.net>
Message-ID: <4D90E626.6020404@bluewatersys.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 03/29/2011 08:46 AM, H Hartley Sweeten wrote:
> On Monday, March 28, 2011 12:30 PM, Ryan Mallon wrote:
>> On 03/29/2011 07:27 AM, H Hartley Sweeten wrote:
>>> Add support for Vision Engraving Systems EP9307 based SoM.
>>>
>>> Signed-off-by: Hartley Sweeten <hartleys@visionengravers.com>
>>> Cc: Ryan Mallon <ryan@bluewatersys.com>
>>
>> Hi Hartley,
>>
>> Looks mostly good. Couple of minor comments below.
> 
>>> +static void vision_lcd_blank(int blank_mode, struct fb_info *info)
>>> +{
>>> +	if (blank_mode)
>>> +		gpio_set_value(VISION_LCD_ENABLE, 0);
>>> +	else
>>> +		gpio_set_value(VISION_LCD_ENABLE, 1);
>>
>> This can just be:
>>
>> 	gpio_set_value(VISION_LCD_ENABLE, blank_mode ^ 1);
> 
> That does kind of hide the meaning of blank_mode.  Also, it appears blank_mode
> is actually an enum not 0 or 1.  Do you still feel your way is better?

Ah, okay. I just suggest the above as being slightly more concise. If
you think that it is more clear/correct as is then leave it.

> 
>>> +};
>>> +
>>> +static struct i2c_board_info vision_i2c_info[] __initdata = {
>>> +	{
>>> +		I2C_BOARD_INFO("isl1208", 0x6f),
>>> +		.irq		= IRQ_EP93XX_EXT1,
>>> +	}, {
>>
>> Nitpick - opening braces should go on a new line.
> 
> For array definitions like this it appears the '}, {' is more common.

Ok.

~Ryan


-- 
Bluewater Systems Ltd - ARM Technology Solution Centre

Ryan Mallon         		5 Amuri Park, 404 Barbadoes St
ryan at bluewatersys.com         	PO Box 13 889, Christchurch 8013
http://www.bluewatersys.com	New Zealand
Phone: +64 3 3779127		Freecall: Australia 1800 148 751
Fax:   +64 3 3779135			  USA 1800 261 2934
