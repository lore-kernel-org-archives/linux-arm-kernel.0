From: rmallon@gmail.com (Ryan Mallon)
Date: Tue, 12 Jun 2012 07:50:59 +1000
Subject: [PATCH] arm: ep93xx: Enable i2c support for ep9302
In-Reply-To: <ADE657CA350FB648AAC2C43247A983F0020698D1354E@AUSP01VMBX24.collaborationhost.net>
References: <alpine.LFD.2.00.1206101542100.21012@FC9.localdomain>
 <4FD534A5.1030301@gmail.com>
 <ADE657CA350FB648AAC2C43247A983F0020698D1354E@AUSP01VMBX24.collaborationhost.net>
Message-ID: <4FD66843.6000504@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 12/06/12 01:45, H Hartley Sweeten wrote:

> On Sunday, June 10, 2012 4:58 PM, Ryan Mallon wrote:
>> On 10/06/12 22:44, Todor Colov wrote:
>>>
>>> Enable i2c support for ep9302. i2c support is needed when external RTC is 
>>> used. 
>>>
>>> Signed-off-by: Todor Colov <todorcolov@gmail.com>
>>
>> Thanks. Applied to ep93xx-fixes.
> 
> Ryan,
> 
> I'm not sure about this patch...
> 
> The EDB9302 does not have a built-on external RTC connected to the I2C
> bus. The EECLK and EEDAT pins are simply routed to two headers. They are
> not connected to any I2C devices built onto the board.
> 
> This patch will cause _all_ edb9302 boards to bind the ds1337 driver to the
> I2C bus but that device will only exist if a user has connected the part
> externally to the board.
> 
> Just my 2 cents...


Hmm, the binding is not really a problem, since it will just fail if the
ds1337 device is not present at that i2c address. I guess the main problem
is if there are users of the edb9302 who want i2c on the headers and others
who want to use the pins as gpio. Without being able to auto-detect such
boards at runtime (which seems very unlikely) I can't think of a good 
solution to this, other than it being time for me to do more DT reading :-).

I'm inclined to leave the patch in. The ep93xx doesn't have a lot of users,
so I think it is okay to tailor it a bit to the users we do have. I'm happy
to revert it, and find a better solution if this breaks someone else's 
setup.

~Ryan
