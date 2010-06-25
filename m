From: rabin@rab.in (Rabin Vincent)
Date: Fri, 25 Jun 2010 07:39:22 +0530
Subject: strange segfaults with CompactFlash in "true-ide" mode on PXA270
In-Reply-To: <19490.10015.10027.750374@ipc1.ka-ro>
References: <201006231706.33182.schindele@nentec.de>
	<19490.10015.10027.750374@ipc1.ka-ro>
Message-ID: <AANLkTilj-ma9RgIBZNtJLlNFWsSDLG5tHfdllG_0_wNY@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jun 23, 2010 at 8:54 PM, Lothar Wa?mann <LW@karo-electronics.de> wrote:
>> we have a strange problem when booting from a Compact Flash card
>> as root-device. In one of 10 cases while booting an application from
>> root-filesystem dies with "Segmentation fault" without a visible error.
>> After booting the same application runs hundred times without error.
>> (we're talking about standard appl. like chat, pppd, hwclock and so on)
>>
>> For debugging purposes we put printk's in kernels IDE driver
>> and the problem disappeared. But replacing the printk by a usleep
>> or so (which is not a solution !) brings the problem back.
>> It seems that the application received faulty data from CF.
>> But how and why ?????????????????????????????
>>
>> We tested with a custom PXA270 board with a CompactFlash in
>> "true ide" on processor bus driven by "generic ide / pata_platform"
>> driver from linux-2.6.27.x.
>> (by the way linux-2.6.20.x showed the same problem).
>>
>> Any ideas, hints, experiences, patches are very welcome :-)
>> --------------------------------------------------------------
> I guess that is the old cache problem that apparently was never really
> fixed:
> http://marc.info/?t=108537828400002&r=1&w=2

Catalin recently posted some patches addressing the cache
problem:

http://thread.gmane.org/gmane.linux.ports.arm.kernel/82987

Rabin
