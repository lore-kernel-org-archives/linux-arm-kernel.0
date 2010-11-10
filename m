From: mkl0301@gmail.com (Lin Mac)
Date: Wed, 10 Nov 2010 12:07:53 +0800
Subject: Booting CNS3420 EVB v 1.3 failed with 2.6.36 (and 2.6.35)
In-Reply-To: <20101109103550.GB2869@n2100.arm.linux.org.uk>
References: <AANLkTik-4p=rBVO9GVoa8L2pEVQtaPkyYmWebuZwAshG@mail.gmail.com>
	<20101105074418.GA5864@oksana.dev.rtsoft.ru>
	<AANLkTimH0JVcB31usN5srPNYCR8sR75J23FtTPQK1Chf@mail.gmail.com>
	<20101109101433.GA17423@oksana.dev.rtsoft.ru>
	<20101109103550.GB2869@n2100.arm.linux.org.uk>
Message-ID: <AANLkTikDEq=5ULX-sxaN95GaW9sQHX8qrCBwmcA6FD1E@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2010/11/9 Russell King - ARM Linux <linux@arm.linux.org.uk>:
> On Tue, Nov 09, 2010 at 01:14:33PM +0300, Anton Vorontsov wrote:
>> On Tue, Nov 09, 2010 at 03:12:25PM +0800, Lin Mac wrote:
>> > > setenv bootargs console=ttyS0,38400 ip=on
>> > Changing this doesn't take effect. I was trying console=ttyS0,115200
>> > and root=/dev/ram0, but it just boot with the configured parameter
>> > instead of the given one.
>> > Is it also the issue of u-boot?
>> Nope. Just remove CONFIG_CMDLINE from your kernel .config file. ;-)
> No. ?The external command line overrides the built-in one unless
> CMDLINE_FORCE is set.

I have confirmed that CONFIG_CMDLINE_FORCE is not set.
Removing the CONFIG_CMDLINE caused linux boot fails:
--
CNS3000 # print
baudrate=38400
ethaddr=00:53:43:4F:54:54
ipaddr=172.20.5.230
serverip=172.20.5.200
netmask=255.255.0.0
bootfile="/tftpboot/uImage"
tftp_bsize=512
udp_frag_size=512
bootdelay=1
cpu_clock=600
machid=ad8
kfile=uImage
ramaddr=4000000
bootcmd=mmc;fatload mmc 0 $(ramaddr) $(kfile); bootm $(ramaddr)
bootargs=console=ttyS0,38400 mem=128M root=/dev/mmcblk0p1 ro rootwait
stdin=serial
stdout=serial
stderr=serial

Environment size: 405/131068 bytes
CNS3000 #

U-Boot 2008.10-mpcore-dirty (Nov  8 2010 - 11:44:24)
Cavium Networks CNS3XXX informal version after v1.0-1462

CPU: Cavium Networks CNS3000
ID Code: 410fb024 (Part number: 0xB02, Revision number: 4)
CPU ID: 900
Chip Version: c

DRAM:  256 MB
Flash: 128 MB
In:    serial
Out:   serial
Err:   serial
CPU works at 600 MHz (600/1/1)
DDR2 Speed is 400 MHz
Hit any key to stop autoboot:  0
mmc_init
Detected SD Card
reading uImage

1002232 bytes read
## Booting kernel from Legacy Image at 04000000 ...
   Image Name:   Linux-2.6.36+
   Created:      2010-11-10   4:04:35 UTC
   Image Type:   ARM Linux Kernel Image (uncompressed)
   Data Size:    1002168 Bytes = 978.7 kB
   Load Address: 00200000
   Entry Point:  00200000
   Verifying Checksum ... OK
   Loading Kernel Image ... OK
OK
Using machid 0xad8 from environment

Starting kernel ...

Uncompressing Li done, booting t
---

Best Regards,
Mac Lin
