From: andreas2025@gmail.com (Andy Ng)
Date: Wed, 21 Jan 2015 12:10:45 +0000
Subject: Unregisrtering a platform driver from another platform driver.
In-Reply-To: <2724993.T8ceeSDQyL@wuerfel>
References: <CAAVaN8xnO5mE1uwW=SPENwOugLv3n+JeNCE9ZycEK2_9QmXSPw@mail.gmail.com>
 <2724993.T8ceeSDQyL@wuerfel>
Message-ID: <CAAVaN8weDZPS5RHCuH3TYuZiQ1NUvgoUxmD00GWxqWBtUAm-jA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Thank you for your reply.
It is during the kernel boot phase, and I just want to remove it with
unregister mechanism.


On Wed, Jan 21, 2015 at 11:15 AM, Arnd Bergmann <arnd@arndb.de> wrote:
> On Wednesday 21 January 2015 10:27:35 Andy Ng wrote:
>> Dear Colleagues,
>>
>> I would like to call "platform_driver_unregister" for a static module
>> A from a static  module B.
>> The static module A register its name  "physmap-flash".
>>
>> Is there any kernel API to search and find the "physmap-flash" device,
>> and then call unregistered with "platform_driver_unregister" from
>> module B.
>
> I assume you don't actually mean platform_driver_unregister(), as
> that would remove the entire driver, not just the connection between
> the driver and the device.
>
>> Any advice will be very much appreciated.
>
> You can do it from user space using the 'unbind' attribute, but I suppose
> that's not what you want.
>
> Can you describe why you want to unbind the device?
>
>         Arnd
