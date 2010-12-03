From: robert.jarzmik@free.fr (Robert Jarzmik)
Date: Fri, 03 Dec 2010 21:20:21 +0100
Subject: PXA270 Random Hangs at Low Core Freq
In-Reply-To: <201010261647.04676.marek.vasut@gmail.com> (Marek Vasut's message
	of "Tue\, 26 Oct 2010 16\:47\:04 +0200")
References: <471CD45F-4531-4C87-B292-411CE519D0A5@prograde.net>
	<201010252146.05874.marek.vasut@gmail.com>
	<D31D5F61-63E8-4C37-A880-7840336935F8@prograde.net>
	<201010261647.04676.marek.vasut@gmail.com>
Message-ID: <878w06zjzu.fsf@free.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Marek Vasut <marek.vasut@gmail.com> writes:

> On Monday 25 October 2010 22:53:32 Michael Cashwell wrote:
>> On Oct 25, 2010, at 3:46 PM, Marek Vasut wrote:
>> > I think I noticed something similar running ZipitZ2 on 312MHz ... yet I
>> > was unable to figure out the problem as well ...
>> 
>> Out of curiosity, what was your trigger event? MMC activity or something
>> else?
>
> I believe it might have been MMC activity, as in initramfs it wasn't triggered

On the mioa701 with a PXA272, the problem occurs as well in the lowest frequency
(104 MHz). If I block the frequency at 208MHz, no hang occurs.

The hang occured several times in the boot sequence, before rootfs was even
loaded.

This happens even with no SD card inserted, with USB gadget driver loading the
CPU, and then idling.

--
Robert
