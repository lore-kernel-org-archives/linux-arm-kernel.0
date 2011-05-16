From: R00091@freescale.com (Nguyen Dinh-R00091)
Date: Mon, 16 May 2011 20:56:45 +0000
Subject: USB issue on Freescale's i.MX35 3-stack board
In-Reply-To: <Pine.LNX.4.44L0.1105161647420.2013-100000@iolanthe.rowland.org>
References: <56132A77AB93C141BF06E6B96CA6CFEA23CF08@039-SN1MPN1-004.039d.mgd.msft.net>
	<Pine.LNX.4.44L0.1105161647420.2013-100000@iolanthe.rowland.org>
Message-ID: <56132A77AB93C141BF06E6B96CA6CFEA23EDEA@039-SN1MPN1-004.039d.mgd.msft.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Alan,

>-----Original Message-----
>From: Alan Stern [mailto:stern at rowland.harvard.edu]
>Sent: Monday, May 16, 2011 3:49 PM
>To: Nguyen Dinh-R00091
>Cc: linux-usb at vger.kernel.org; linux-arm-kernel at lists.infradead.org; daniel at caiaq.de;
>grant.likely at secretlab.ca; u.kleine-koenig at pengutronix.de; s.hauer at pengutronix.de; Mahadevan Mahesh-
>R9AADQ
>Subject: Re: USB issue on Freescale's i.MX35 3-stack board
>
>On Mon, 16 May 2011, Nguyen Dinh-R00091 wrote:
>
>> Hi,
>>
>> On the Freescale i.MX35 3DS board, there is a total of 256MB of DDR2 and the configuration is 128MB
>on Chip-select 0 and 128MB on chip-select 1. So physically, the memory is not contiguous, so we boot
>up the system with these mem= parameters(mem=128M at 0x80000000 mem=128M at 0x90000000). The system seems to
>be operating fine and passes stress testing using memtester and oprofile, except for USB.
>>
>> Running a USB copy stress test on USB mass storage between a USB HDD and an SD/MMC card causes the
>system to hang. The hang can occur at any time between 10 minutes to 2 hours. The hang is much harder
>to re-create if logs or delays are introduced.
>
>Your test involves both the USB and MMC subsystems.  How can you tell
>which one is responsible for the hang?
>
>Have you tried testing these subsystems one at a time?

Yes, I've stress tested on USB alone and MMC alone. The issue doesn't seem to appear with a MMC test, but appears when I am moving files between 2 USB HDDs. I apologize for not adding that additional data point on my original email.

Dinh

>
>Alan Stern
>
