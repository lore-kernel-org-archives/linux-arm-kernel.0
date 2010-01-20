From: ryan@bluewatersys.com (Ryan Mallon)
Date: Thu, 21 Jan 2010 10:59:51 +1300
Subject: [PATCH] ep93xx: Add support for Simplemachines Sim.One board
In-Reply-To: <BD79186B4FD85F4B8E60E381CAEE1909020E8DF3@mi8nycmail19.Mi8.com>
References: <4B57609E.6050904@bluewatersys.com>
	<BD79186B4FD85F4B8E60E381CAEE1909020E8DDA@mi8nycmail19.Mi8.com>
	<4B576907.8050008@bluewatersys.com>
	<BD79186B4FD85F4B8E60E381CAEE1909020E8DF3@mi8nycmail19.Mi8.com>
Message-ID: <4B577CD7.2050805@bluewatersys.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

H Hartley Sweeten wrote:
> On Wednesday, January 20, 2010 1:35 PM, Ryan Mallon wrote:
>   
>> H Hartley Sweeten wrote:
>>     
>>
>
> Two minor nitpicks below...
>
>   
>> --- /dev/null
>> +++ b/arch/arm/mach-ep93xx/simone.c
>> @@ -0,0 +1,97 @@
>> +/*
>> + * arch/arm/mach-ep93xx/simone.c
>> + * Simplemachines Sim.One support.
>> + *
>> + * Copyright (C) 2009 Ryan Mallon <ryan@bluewatersys.com>
>>     
>
> 2010?
>   
I started writing the patch last year, hence the 2009. Can update if
necessary.
>> +static struct ep93xxfb_mach_info simone_fb_info = {
>> +	.num_modes	= EP93XXFB_USE_MODEDB,
>> +	.bpp		= 16,
>> +	.flags		= EP93XXFB_USE_SDCSN0 | EP93XXFB_PCLK_FALLING,
>> +};
>>     
>
> Nitpick.. Please put the fb stuff above after the i2c stuff below.
>   
Can do if necessary. Its pretty minor though.
>
> Did you happen to look at the patch I sent on 12/23/2009 with subject
> [PATCH] ep93xx: add missing SDRAM options for EDB93xx
>
> I think the EP93XX_SDCE0_PHYS_BASE can be changed to PHYS_OFFSET in
> all the ep93xx platform init code.  I'm not sure what Uwe Kleine-K?nig
> is going to do with the run time determined PHYS_OFFSET but I think
> that would at least get ep93xx ready for it.
>   
The other boards are all still using the old way. I can change this
board now, or just leave as is and we can change all of the boards later?
>  
> Other that that, looks good to me.  This pretty much matches what I had
> pending.  Have you at least compile tested this?
>
> It would be nice if someone could actually test this to make sure the
> kernel boots correctly on the Sim.One.  But for what it's worth:
>
> Acked-by: H Hartley Sweeten <hsweeten@visionengravers.com>
>   
I'll wait on the guys from Simplemachines to have their say before I put
this into the patch system.

~Ryan

-- 
Bluewater Systems Ltd - ARM Technology Solution Centre

Ryan Mallon         		5 Amuri Park, 404 Barbadoes St
ryan at bluewatersys.com         	PO Box 13 889, Christchurch 8013
http://www.bluewatersys.com	New Zealand
Phone: +64 3 3779127		Freecall: Australia 1800 148 751 
Fax:   +64 3 3779135			  USA 1800 261 2934
