From: ryan@bluewatersys.com (Ryan Mallon)
Date: Thu, 27 Jan 2011 13:10:22 +1300
Subject: [PATCH] ep93xx: add framebuffer support to edb93xx boards
In-Reply-To: <0D753D10438DA54287A00B027084269764CEC45F84@AUSP01VMBX24.collaborationhost.net>
References: <0D753D10438DA54287A00B027084269764C41240B9@AUSP01VMBX24.collaborationhost.net>
	<4D40B37D.7030608@bluewatersys.com>
	<0D753D10438DA54287A00B027084269764CEC45F84@AUSP01VMBX24.collaborationhost.net>
Message-ID: <4D40B7EE.1080507@bluewatersys.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 01/27/2011 01:04 PM, H Hartley Sweeten wrote:
> On Wednesday, January 26, 2011 4:51 PM, Ryan Mallon wrote:
>> On 01/08/2011 11:38 AM, H Hartley Sweeten wrote:
>>> The ep9307, ep9312, and ep9315 variants of the ep93xx processor include the
>>> raster engine needed for framebuffer support.
>>>
>>> This allows the EDB93xx boards with those processors to use the framebuffer
>>> driver.
>>>
>>> Tested on an EDB9307A with the following kernel parameters:
>>> 	video=640x480-16 at 60
>>> 	video=1024x768-16 at 60
>>>
>>> Signed-off-by: H Hartley Sweeten <hsweeten@visionengravers.com>
>>>
> 
>>> +static int __init edb93xx_has_fb(void)
>>> +{
>>> +	if (machine_is_edb9307() || machine_is_edb9307a() ||
>>> +	    machine_is_edb9312() || machine_is_edb9315() ||
>>> +	    machine_is_edb9315a()) {
>>
>> return (machine_is_edb9307() || machine_is_edb9307a() ...
> 
> OK.
> 
> I'm wondering if these *_has_{peripheral} helpers should just be defines and
> moved to one of the mach headers.  That way the other ep93xx platforms can
> use the same helpers.

I would think that they are only really needed for the edb board file
which supports all of the processors types. IIRC, The other boards all
have a specific processor and so the peripheral setup is fixed.

~Ryan

-- 
Bluewater Systems Ltd - ARM Technology Solution Centre

Ryan Mallon         		5 Amuri Park, 404 Barbadoes St
ryan at bluewatersys.com         	PO Box 13 889, Christchurch 8013
http://www.bluewatersys.com	New Zealand
Phone: +64 3 3779127		Freecall: Australia 1800 148 751
Fax:   +64 3 3779135			  USA 1800 261 2934
