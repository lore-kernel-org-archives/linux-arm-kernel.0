From: hartleys@visionengravers.com (H Hartley Sweeten)
Date: Mon, 11 Jun 2012 10:45:26 -0500
Subject: [PATCH] arm: ep93xx: Enable i2c support for ep9302
In-Reply-To: <4FD534A5.1030301@gmail.com>
References: <alpine.LFD.2.00.1206101542100.21012@FC9.localdomain>
 <4FD534A5.1030301@gmail.com>
Message-ID: <ADE657CA350FB648AAC2C43247A983F0020698D1354E@AUSP01VMBX24.collaborationhost.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sunday, June 10, 2012 4:58 PM, Ryan Mallon wrote:
> On 10/06/12 22:44, Todor Colov wrote:
>> 
>> Enable i2c support for ep9302. i2c support is needed when external RTC is 
>> used. 
>> 
>> Signed-off-by: Todor Colov <todorcolov@gmail.com>
>
> Thanks. Applied to ep93xx-fixes.

Ryan,

I'm not sure about this patch...

The EDB9302 does not have a built-on external RTC connected to the I2C
bus. The EECLK and EEDAT pins are simply routed to two headers. They are
not connected to any I2C devices built onto the board.

This patch will cause _all_ edb9302 boards to bind the ds1337 driver to the
I2C bus but that device will only exist if a user has connected the part
externally to the board.

Just my 2 cents...

Regards,
Hartley
