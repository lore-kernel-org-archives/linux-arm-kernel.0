From: ryan@bluewatersys.com (Ryan Mallon)
Date: Thu, 18 Mar 2010 10:43:40 +1300
Subject: [PATCH] ep93xx: pass platform startup data as __initdata
In-Reply-To: <0D753D10438DA54287A00B0270842697636858D5BC@AUSP01VMBX24.collaborationhost.net>
References: <0D753D10438DA54287A00B0270842697636858D5BC@AUSP01VMBX24.collaborationhost.net>
Message-ID: <4BA14D0C.40503@bluewatersys.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

H Hartley Sweeten wrote:
> A number of the peripherals for the ep93xx are registered at
> startup using platform_data that is passed from the board init
> code to the core code.  This data is then copied to a local
> static variable in the core code.  Since the data is copied,
> the original data can be marked as __initdata and discarded
> after startup is complete.
> 
> This adds the __initdata tag to all the appropriate data in
> the various ep93xx board init's.  Specifically, all the
> struct ep93xx_eth_data, struct ep93xxfb_mach_info, and
> struct i2c_gpio_platform_data.
> 
> Also, document the various registration functions and note
> what data should be marked as __initdata.
> 
> While here, also cleanup a couple over zealous whitespace tabs.
> 
> Signed-off-by: H Hartley Sweeten <hsweeten@visionengravers.com>
> Cc: Ryan Mallon <ryan@bluewatersys.com>

Looks good, and appears to work okay.

Acked-by: Ryan Mallon <ryan@bluewatersys.com>

-- 
Bluewater Systems Ltd - ARM Technology Solution Centre

Ryan Mallon         		5 Amuri Park, 404 Barbadoes St
ryan at bluewatersys.com         	PO Box 13 889, Christchurch 8013
http://www.bluewatersys.com	New Zealand
Phone: +64 3 3779127		Freecall: Australia 1800 148 751
Fax:   +64 3 3779135			  USA 1800 261 2934
