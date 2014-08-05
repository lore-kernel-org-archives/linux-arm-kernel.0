From: cov@codeaurora.org (Christopher Covington)
Date: Tue, 05 Aug 2014 16:17:20 -0400
Subject: Regarding CONFIG_BLK_DEV_RAM and CONFIG_BLK_DEV_RAM_SIZE in
 arch/arm64/configs/defconfig
In-Reply-To: <53E124FE.5070205@freescale.com>
References: <53E0DB92.2030609@freescale.com> <53E0E56B.9080601@codeaurora.org>
 <53E124FE.5070205@freescale.com>
Message-ID: <53E13BD0.4070207@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08/05/2014 02:39 PM, Arnab Basu wrote:
> On 08/05/2014 07:38 PM, Christopher Covington wrote:
>> On 08/05/2014 09:26 AM, Arnab Basu wrote:
>>> Hi
>>>
>>> While trying to boot Linux with an initrd I found that CONFIG_BLK_DEV_RAM and
>>> CONFIG_BLK_DEV_RAM_SIZE are not part of the arm64 defconfig. Is this because
>>> no one has got around to adding them or is this something that has been
>>> omitted on purpose?
>>
>> I've been running initrds fine without this option. What requires it?

Perhaps I should have said "initramfs"--I was going by the QEMU option I use
to specify it.

https://www.kernel.org/doc/Documentation/filesystems/ramfs-rootfs-initramfs.txt

> Without these options I get:
> 
> VFS: Cannot open root device "ram0" or unknown-block(0,0): error -6

> With these options I get:
> 
> RAMDISK: gzip image found at block 0
> VFS: Mounted root (ext2 filesystem) readonly on device 1:0.
> Freeing unused kernel memory: 220K (ffffffc000636000 - ffffffc00066d000)
> 
> My kernel command line is:
> 
> Kernel command line: console=ttyS1,115200 root=/dev/ram0
> earlyprintk=uart8250-8bit,0x21c0600
> 
> Any pointers on what else could be causing this?

With a (newc/SVR4 format) CPIO archive and not setting root= at all in the
command line I see:

Unpacking initramfs...
Freeing initrd memory: 256384K (fffffe0008000000 - fffffe0017a60000)

Christopher

-- 
Employee of Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
hosted by the Linux Foundation.
