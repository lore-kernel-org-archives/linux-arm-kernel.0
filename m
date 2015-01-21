From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 21 Jan 2015 12:15:28 +0100
Subject: Unregisrtering a platform driver from another platform driver.
In-Reply-To: <CAAVaN8xnO5mE1uwW=SPENwOugLv3n+JeNCE9ZycEK2_9QmXSPw@mail.gmail.com>
References: <CAAVaN8xnO5mE1uwW=SPENwOugLv3n+JeNCE9ZycEK2_9QmXSPw@mail.gmail.com>
Message-ID: <2724993.T8ceeSDQyL@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 21 January 2015 10:27:35 Andy Ng wrote:
> Dear Colleagues,
> 
> I would like to call "platform_driver_unregister" for a static module
> A from a static  module B.
> The static module A register its name  "physmap-flash".
> 
> Is there any kernel API to search and find the "physmap-flash" device,
> and then call unregistered with "platform_driver_unregister" from
> module B.

I assume you don't actually mean platform_driver_unregister(), as
that would remove the entire driver, not just the connection between
the driver and the device.
 
> Any advice will be very much appreciated.

You can do it from user space using the 'unbind' attribute, but I suppose
that's not what you want.

Can you describe why you want to unbind the device?

	Arnd
