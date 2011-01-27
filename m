From: hartleys@visionengravers.com (H Hartley Sweeten)
Date: Wed, 26 Jan 2011 18:04:11 -0600
Subject: [PATCH] ep93xx: add framebuffer support to edb93xx boards
In-Reply-To: <4D40B37D.7030608@bluewatersys.com>
References: <0D753D10438DA54287A00B027084269764C41240B9@AUSP01VMBX24.collaborationhost.net>
	<4D40B37D.7030608@bluewatersys.com>
Message-ID: <0D753D10438DA54287A00B027084269764CEC45F84@AUSP01VMBX24.collaborationhost.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday, January 26, 2011 4:51 PM, Ryan Mallon wrote:
> On 01/08/2011 11:38 AM, H Hartley Sweeten wrote:
>> The ep9307, ep9312, and ep9315 variants of the ep93xx processor include the
>> raster engine needed for framebuffer support.
>> 
>> This allows the EDB93xx boards with those processors to use the framebuffer
>> driver.
>> 
>> Tested on an EDB9307A with the following kernel parameters:
>> 	video=640x480-16 at 60
>> 	video=1024x768-16 at 60
>> 
>> Signed-off-by: H Hartley Sweeten <hsweeten@visionengravers.com>
>> 

>> +static int __init edb93xx_has_fb(void)
>> +{
>> +	if (machine_is_edb9307() || machine_is_edb9307a() ||
>> +	    machine_is_edb9312() || machine_is_edb9315() ||
>> +	    machine_is_edb9315a()) {
>
> return (machine_is_edb9307() || machine_is_edb9307a() ...

OK.

I'm wondering if these *_has_{peripheral} helpers should just be defines and
moved to one of the mach headers.  That way the other ep93xx platforms can
use the same helpers.

Regards,
Hartley
