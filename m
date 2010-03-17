From: hartleys@visionengravers.com (H Hartley Sweeten)
Date: Wed, 17 Mar 2010 11:39:02 -0500
Subject: [PATCH] ep93xx/core.c: remove redundant static variable
In-Reply-To: <19360.35416.358644.406403@ipc1.ka-ro>
References: <0D753D10438DA54287A00B02708426976368534061@AUSP01VMBX24.collaborationhost.net>
	<0D753D10438DA54287A00B0270842697636858C6FE@AUSP01VMBX24.collaborationhost.net>
	<19360.35416.358644.406403@ipc1.ka-ro>
Message-ID: <0D753D10438DA54287A00B0270842697636858D3AE@AUSP01VMBX24.collaborationhost.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday, March 17, 2010 12:53 AM, Lothar Wa?mann wrote:
>
> Hi,

Hello.

>> Use the pointer to the passed board support data directly instead of 
>> copying it to local static variables.
>> 
>> This updates the ethernet, i2c, and framebuffer devices.
>> 
>> While here, also document the functions used to register the devices.
>> 
>> Signed-off-by: H Hartley Sweeten <hsweeten@visionengravers.com>
>> Cc: Ryan Mallon <ryan@bluewatersys.com>
>> 
>> ---

> I don't think this is a good idea.
> In a multi platform kernel each platform that could potentially
> register the device needs to have the platform_data lying around in
> memory even if it's never used.
> 
> In the old way the platforms could have the platform_data that is
> passed to the ep93xx_register_eth() function marked as __initdata and
> only one copy that is actually used would be kept.

Ok. That makes sense.

Based on that, all the ep93xx board init code needs to be checked to
make sure any data that is passed to the core code and copied to a local
static variable is marked as __initdata.

I'll rework this and post a new patch in a bit.

Thanks,
Hartley
