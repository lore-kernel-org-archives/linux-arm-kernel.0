From: ryan@bluewatersys.com (Ryan Mallon)
Date: Thu, 01 Oct 2009 10:08:34 +1300
Subject: [PATCH] ep93xx: update i2c support
In-Reply-To: <BD79186B4FD85F4B8E60E381CAEE190901D42C6B@mi8nycmail19.Mi8.com>
References: <BD79186B4FD85F4B8E60E381CAEE190901D41F55@mi8nycmail19.Mi8.com>
	<BD79186B4FD85F4B8E60E381CAEE190901D41F5D@mi8nycmail19.Mi8.com>
	<4AC3BB1F.9050903@bluewatersys.com>
	<BD79186B4FD85F4B8E60E381CAEE190901D42C6B@mi8nycmail19.Mi8.com>
Message-ID: <4AC3C8D2.5060009@bluewatersys.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

H Hartley Sweeten wrote:
> Update the ep93xx i2c support:
> 
>   1) The platform init code passes the configuration data for the
>      i2c-gpio driver.  This allows any gpio pin do be used for the
>      sda and scl pins.  It also allows the platform to specify the
>      udelay and timeout.
>   2) Program the gpio configuration register to enable/disable the
>      open drain drivers.  Note that this really only works if the
>      sda and scl pins are set to EP93XX_GPIO_LINE_EEDAT and
>      EP93XX_GPIO_LINE_EECLK.

Maybe print a warning then if sda/scl_is_open_drain is set and the pin
is not set to EEDAT/EECLK.

~Ryan

-- 
Bluewater Systems Ltd - ARM Technology Solution Centre

Ryan Mallon         		5 Amuri Park, 404 Barbadoes St
ryan at bluewatersys.com         	PO Box 13 889, Christchurch 8013
http://www.bluewatersys.com	New Zealand
Phone: +64 3 3779127		Freecall: Australia 1800 148 751
Fax:   +64 3 3779135			  USA 1800 261 2934
