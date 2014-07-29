From: andrew@lunn.ch (Andrew Lunn)
Date: Tue, 29 Jul 2014 03:53:52 +0200
Subject: CPU1 fails to boot on Armada 375 DB with 3.16.0-rc6
In-Reply-To: <53D6F564.5070803@opengear.com>
References: <53D6F564.5070803@opengear.com>
Message-ID: <20140729015352.GC12303@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jul 29, 2014 at 11:14:12AM +1000, Ken Wilson wrote:
> Hi Thomas,
> We're running 3.16.0-rc6 on our Rev 2 Armada 375 DB, and we've found
> that the second CPU is not coming up.
> Are there any known issues here?
> 
> I've also tried starting the 2nd CPU after boot using the sysfs
> interface, but I get the same error.
> We're tftpbooting the kernel, using an in-memory ramdisk
> 
> Snip from dmesg:
> 
> Uncompressing Linux... done, booting the kernel.
> Booting Linux on physical CPU 0x0
> Linux version 3.16.0-rc6-dirty (kenw at build-ken) (gcc version 4.8.1
> (GCC) ) #7 SMP Tue Jul 29 09:47:30 EST 2014
> CPU: ARMv7 Processor [414fc091] revision 1 (ARMv7), cr=10c5387d
> CPU: PIPT / VIPT nonaliasing data cache, VIPT aliasing instruction cache
> Machine model: Marvell Armada 375 Development Board
> bootconsole [earlycon0] enabled
> Memory policy: Data cache writeback
> BUG: mapping for 0xf1012000 at 0xfff12000 out of vmalloc space

Humm, is that the serial port? Do you get a working serial port?

> CPU: All CPU(s) started in SVC mode.
> PERCPU: Embedded 7 pages/cpu @ee7d5000 s7680 r8192 d12800 u32768
> Built 1 zonelists in Zone order, mobility grouping on.  Total pages: 522768
> Kernel command line: console=ttyS0,115200 earlyprintk root=/dev/ram
> PID hash table entries: 4096 (order: 2, 16384 bytes)
> Dentry cache hash table entries: 131072 (order: 7, 524288 bytes)
> Inode-cache hash table entries: 65536 (order: 6, 262144 bytes)
> Memory: 2063736K/2097152K available (4932K kernel code, 259K rwdata,

Do you have 2G RAM? The DTS file indicates DB has 1G RAM. But if
u-boot is passing the right stuff to the kernel, that should not
matter.

	Andrew
