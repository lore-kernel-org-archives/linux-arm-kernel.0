From: R00091@freescale.com (Nguyen Dinh-R00091)
Date: Mon, 16 May 2011 20:54:03 +0000
Subject: USB issue on Freescale's i.MX35 3-stack board
In-Reply-To: <20110516203211.GA17698@kroah.com>
References: <56132A77AB93C141BF06E6B96CA6CFEA23CF08@039-SN1MPN1-004.039d.mgd.msft.net>
	<20110516203211.GA17698@kroah.com>
Message-ID: <56132A77AB93C141BF06E6B96CA6CFEA23EDC3@039-SN1MPN1-004.039d.mgd.msft.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Greg,

>-----Original Message-----
>From: Greg KH [mailto:greg at kroah.com]
>Sent: Monday, May 16, 2011 3:32 PM
>To: Nguyen Dinh-R00091
>Cc: linux-usb at vger.kernel.org; linux-arm-kernel at lists.infradead.org; daniel at caiaq.de;
>grant.likely at secretlab.ca; u.kleine-koenig at pengutronix.de; dbrownell at users.sourceforge.net;
>s.hauer at pengutronix.de; Mahadevan Mahesh-R9AADQ
>Subject: Re: USB issue on Freescale's i.MX35 3-stack board
>
>On Mon, May 16, 2011 at 02:15:36PM +0000, Nguyen Dinh-R00091 wrote:
>> Hi,
>>
>> On the Freescale i.MX35 3DS board, there is a total of 256MB of DDR2
>> and the configuration is 128MB on Chip-select 0 and 128MB on
>> chip-select 1. So physically, the memory is not contiguous, so we boot
>> up the system with these mem= parameters(mem=128M at 0x80000000
>> mem=128M at 0x90000000). The system seems to be operating fine and passes
>> stress testing using memtester and oprofile, except for USB.
>>
>> Running a USB copy stress test on USB mass storage between a USB HDD
>> and an SD/MMC card causes the system to hang. The hang can occur at
>> any time between 10 minutes to 2 hours. The hang is much harder to
>> re-create if logs or delays are introduced.
>
>What kernel version are you using, and what host controller drivers?

It's the EHCI USB controller. I'm currently debugging on 2.6.35, but the bug is can also be seen on 2.6.38.

Dinh
>
>thanks,
>
>greg k-h
