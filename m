From: iain@mcfarlanes.me (Iain McFarlane)
Date: Wed, 21 Oct 2015 22:22:50 +0100
Subject: I/O issues with writing to mtdblock devices on kirkwood
In-Reply-To: <1445461864.32735.21.camel@debian.org>
References: <1444722697.16876.55.camel@debian.org>
 <5626B4DC.8000407@mcfarlanes.me> <5627F4E8.3030907@mcfarlanes.me>
 <1445461864.32735.21.camel@debian.org>
Message-ID: <5628022A.9050707@mcfarlanes.me>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 21/10/15 22:11, Ian Campbell wrote:
> On Wed, 2015-10-21 at 21:26 +0100, Iain McFarlane wrote:
>> Summary of progress:
> Thanks for the info. I've reinstated the CC list here.
>
>> I ended up connecting using a serial cable which was invaluable as my
>> initrd was not working (see below)
>>
>> I tried going backwards:
>> 4.2.0 - SATA errors when flashing initrd
>> 4.1.0 - SATA errors when flashing initrd
>> 4.0.0 - SATA errors when flashing initrd
>> 3.16 - No SATA errors when updating initrd - the kernel is flashed using
>> dtb but how do I tell if it is used?
> /proc/device-tree will exist. Also the Hardware field in /proc/cpuinfo
> would differ, IIRC with a board file it says "QNAP TS-119/TS-219" and
> with DTB it says "QNAP TS219 family".
>
> Ian.
>
>> it didn't help that somewhere along the line udev/initramfs/systemd is
>> broken so that I had to remove all the UUID values from my fstab and go
>> back to device names.
>>
>>
>> On 20/10/15 22:40, Iain McFarlane wrote:
>>> Posting from archive as previously not subscribed.
>>>
>>> I have a qnap ts-219p (kirkwood) in pieces at the moment as it is
>>> failing to boot the 4.2 kernel from a brand new install of stretch.
>>>
>>> I am also seeing problems with the sata controller interacting with the
>>> mtdblock driver
>>>
>>> I am going to see if rolling back a version or 2 of the kernel will work
>>> tomorrow and will feedback to the list.
>>>
>>> Regards
>>>
>>> Iain
>>>
>>
In which case it is using the board file

How do I force it to use the dtb?

On a different note anyone know why udev would not be running modprobe? 
Every time I reboot this box I have to the reload any of the modules not
specified in the initrd even things like mvmdio to get the network working.

Iain
