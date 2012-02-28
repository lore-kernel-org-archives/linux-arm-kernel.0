From: stigge@antcom.de (Roland Stigge)
Date: Tue, 28 Feb 2012 14:49:56 +0100
Subject: [PATCH v2] ARM: LPC32xx: Ethernet driver
In-Reply-To: <201202281341.01690.arnd@arndb.de>
References: <AE90C24D6B3A694183C094C60CF0A2F6026B6E83@saturn3.aculab.com>
 <4F4CD781.2090802@antcom.de> <201202281341.01690.arnd@arndb.de>
Message-ID: <4F4CDB84.7070502@antcom.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 02/28/2012 02:41 PM, Arnd Bergmann wrote:
>> So if the hardware defaults to 00:00:00:00:00:00, what is the
>> "consistent policy we want to enforce in all drivers"?
>>
>> A link or hint would be sufficient.
> 
> I think the most common strategy for platform drivers these days is
> 
> 1. use what the hardware provides
> 2. call of_get_mac_address(dev->of_node, ...)
> 3. use random_ether_addr
> 
> in that order. of_get_mac_address just returns NULL when there
> is no device tree or no local-mac-address property, so you can
> put it into the driver right away.

Cool, thanks - will do!

Roland
