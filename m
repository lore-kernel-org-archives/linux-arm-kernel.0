From: arnab.basu@freescale.com (Arnab Basu)
Date: Wed, 6 Aug 2014 00:09:58 +0530
Subject: Regarding CONFIG_BLK_DEV_RAM and CONFIG_BLK_DEV_RAM_SIZE in
 arch/arm64/configs/defconfig
In-Reply-To: <53E0E56B.9080601@codeaurora.org>
References: <53E0DB92.2030609@freescale.com> <53E0E56B.9080601@codeaurora.org>
Message-ID: <53E124FE.5070205@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08/05/2014 07:38 PM, Christopher Covington wrote:
> On 08/05/2014 09:26 AM, Arnab Basu wrote:
>> Hi
>>
>> While trying to boot Linux with an initrd I found that CONFIG_BLK_DEV_RAM and
>> CONFIG_BLK_DEV_RAM_SIZE are not part of the arm64 defconfig. Is this because
>> no one has got around to adding them or is this something that has been
>> omitted on purpose?
>
> I've been running initrds fine without this option. What requires it?
>

Without these options I get:

VFS: Cannot open root device "ram0" or unknown-block(0,0): error -6
Please append a correct "root=" boot option; here are the available 
partitions:
Kernel panic - not syncing: VFS: Unable to mount root fs on 
unknown-block(0,0)
CPU: 7 PID: 1 Comm: swapper/0 Not tainted 3.16.0+ #1
Call trace:
[<ffffffc000088084>] dump_backtrace+0x0/0x12c
[<ffffffc0000881c0>] show_stack+0x10/0x1c
[<ffffffc0004a686c>] dump_stack+0x74/0xc4
[<ffffffc0004a37dc>] panic+0xe4/0x220
[<ffffffc000635ed8>] mount_block_root+0x1d4/0x278
[<ffffffc000636090>] mount_root+0x114/0x134
[<ffffffc0006361ec>] prepare_namespace+0x13c/0x188
[<ffffffc000635b2c>] kernel_init_freeable+0x1b8/0x1dc
[<ffffffc0004a0fc4>] kernel_init+0xc/0xd4

...

[<ffffffc000083da0>] el1_irq+0x60/0xd0
[<ffffffc0000e0680>] cpu_startup_entry+0xfc/0x14c
[<ffffffc00008e7f0>] secondary_start_kernel+0x118/0x128
---[ end Kernel panic - not syncing: VFS: Unable to mount root fs on 
unknown-blo
ck(0,0)


With these options I get:

RAMDISK: gzip image found at block 0
VFS: Mounted root (ext2 filesystem) readonly on device 1:0.
Freeing unused kernel memory: 220K (ffffffc000636000 - ffffffc00066d000)


My kernel command line is:

Kernel command line: console=ttyS1,115200 root=/dev/ram0 
earlyprintk=uart8250-8bit,0x21c0600

Any pointers on what else could be causing this?

Thanks
Arnab


> Christopher
>
