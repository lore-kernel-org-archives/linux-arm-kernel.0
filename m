From: contact.aneesh@gmail.com (Aneesh Bhasin)
Date: Mon, 16 Nov 2009 14:57:38 +0530
Subject: kernel panic - Attempted to kill init
In-Reply-To: <564715.9008.qm@web7604.mail.in.yahoo.com>
References: <564715.9008.qm@web7604.mail.in.yahoo.com>
Message-ID: <f662f0210911160127i1941c8f9w1f67f5c5123dac72@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,
are the dev nodes (/dev/*) properly populated ? Or in case they are not made
at runtime, have you made them properly ?

On Mon, Nov 16, 2009 at 12:59 PM, abhijeet tripathi <
abhijeet.tripathy@yahoo.co.in> wrote:

> Hello,
>
> I am trying to do a nfs booting of arm-pb1176 but I am getting kernel panic
> "Kernel panic - not syncing: Attempted to kill init!".
> I checked my filesystem and it has "/sbin/init". Please let me know if I am
> missing anything. Below is the console logs:
>
> =======
> RealView_PB # tftpboot
> LAN9118 ethernet chip detected
> TFTP from server 10.170.0.51; our IP address is 10.170.0.53
> Filename 'at_uImage_pb1176'.
> Load address: 0x7fc0
> Loading: #################################################################
>         #################################################################
>         #################################################################
>         #################################################################
>         #################################################################
>         #################################################################
>         #################################################################
>         ##############################
> done
> Bytes transferred = 2483036 (25e35c hex)
> RealView_PB # bootm
> ## Booting image at 00007fc0 ...
>   Image Name:   Linux-2.6.28-arm1
>   Image Type:   ARM Linux Kernel Image (uncompressed)
>   Data Size:    2482972 Bytes =  2.4 MB
>   Load Address: 00008000
>   Entry Point:  00008000
> OK
>
> Starting kernel ...
>
> Uncompressing
> Linux..........................................................................................................
> Initializing cgroup subsys cpu
> Linux version 2.6.28-arm1 (root at xscale) (gcc version 4.2.0) #20 PREEMPT
> Sat No9
> CPU: ARMv6-compatible processor [410fb764] revision 4 (ARMv7), cr=00c5387f
> CPU: VIPT aliasing data cache, VIPT aliasing instruction cache
> Machine: ARM-RealView PB1176
> Ignoring unrecognised tag 0x00000000
> Memory policy: ECC disabled, Data cache writeback
> Built 1 zonelists in Zone order, mobility grouping on.  Total pages: 32512
> Kernel command line: mem=128M console=ttyAMA0,38400n8 ip=dhcp root=/dev/nfs
> rw
> PID hash table entries: 512 (order: 9, 2048 bytes)
> Console: colour dummy device 80x30
> Dentry cache hash table entries: 16384 (order: 4, 65536 bytes)
> Inode-cache hash table entries: 8192 (order: 3, 32768 bytes)
> allocated 655360 bytes of page_cgroup
> please try cgroup_disable=memory option if you don't want
> Memory: 128MB = 128MB total
> Memory: 123576KB available (4636K code, 737K data, 152K init)
> SLUB: Genslabs=12, HWalign=32, Order=0-3, MinObjects=0, CPUs=1, Nodes=1
> Calibrating delay loop... 226.91 BogoMIPS (lpj=1134592)
> Security Framework initialized
> SELinux:  Initializing.
> Mount-cache hash table entries: 512
> Initializing cgroup subsys ns
> Initializing cgroup subsys cpuacct
> Initializing cgroup subsys memory
> Initializing cgroup subsys devices
> Initializing cgroup subsys freezer
> CPU: Testing write buffer coherency: ok
> net_namespace: 768 bytes
> regulator: core version 0.5
> NET: Registered protocol family 16
> L2X0 cache controller enabled
> SCSI subsystem initialized
> usbcore: registered new interface driver usbfs
> usbcore: registered new interface driver hub
> usbcore: registered new device driver usb
> NetLabel: Initializing
> NetLabel:  domain hash size = 128
> NetLabel:  protocols = UNLABELED CIPSOv4
> NetLabel:  unlabeled traffic allowed by default
> NET: Registered protocol family 2
> IP route cache hash table entries: 1024 (order: 0, 4096 bytes)
> TCP established hash table entries: 4096 (order: 3, 32768 bytes)
> TCP bind hash table entries: 4096 (order: 2, 16384 bytes)
> TCP: Hash tables configured (established 4096 bind 4096)
> TCP reno registered
> NET: Registered protocol family 1
> audit: initializing netlink socket (disabled)
> type=2000 audit(0.480:1): initialized
> VFS: Disk quotas dquot_6.5.1
> Dquot-cache hash table entries: 1024 (order 0, 4096 bytes)
> Installing knfsd (copyright (C) 1996 okir at monad.swb.de).
> msgmni has been set to 241
> alg: No test for stdrng (krng)
> Block layer SCSI generic (bsg) driver version 0.4 loaded (major 253)
> io scheduler noop registered
> io scheduler anticipatory registered
> io scheduler deadline registered
> io scheduler cfq registered (default)
> Non-volatile memory driver v1.2
> Serial: 8250/16550 driver4 ports, IRQ sharing enabled
> Serial: AMBA driver
> Serial: AMBA PL011 UART driver
> dev:f1: ttyAMA0 at MMIO 0x1010c000 (irq = 50) is a AMBA/PL011
> console [ttyAMA0] enabled
> dev:f2: ttyAMA1 at MMIO 0x1010d000 (irq = 51) is a AMBA/PL011
> dev:f3: ttyAMA2 at MMIO 0x1010e000 (irq = 52) is a AMBA/PL011
> fpga:09: ttyAMA3 at MMIO 0x1010f000 (irq = 53) is a AMBA/PL011
> brd: module loaded
> loop: module loaded
> smsc911x: Driver version 2008-10-21.
> smsc911x-mdio: probed
> eth0: attached PHY driver [SMSC LAN911x Internal PHY]
> (mii_bus:phy_addr=0:01, irq=-1)
> net eth0: MAC Address: 00:02:f7:00:2f:e7
> Driver 'sd' needs updating - please use bus_type methods
> Driver 'sr' needs updating - please use bus_type methods
> mice: PS/2 mouse device common for all mice
> device-mapper: uevent: version 1.0.3
> device-mapper: ioctl: 4.14.0-ioctl (2008-04-23) initialised:
> dm-devel at redhat.com
> cpuidle: using governor ladder
> cpuidle: using governor menu
> usbcore: registered new interface driver hiddev
> usbcore: registered new interface driver usbhid
> usbhid: v2.6:USB HID core driver
> nf_conntrack version 0.5.0 (2048 buckets, 8192 max)
> CONFIG_NF_CT_ACCT is deprecated and will be removed soon. Please use
> nf_conntrack.acct=1 kernel paramater, acct=1 nf_conntrack module option or
> sysctl net.netfilter.nf_conntrack_acct=1 to enable it.
> ip_tables: (C) 2000-2006 Netfilter Core Team
> TCP cubic registered
> Initializing XFRM netlink socket
> NET: Registered protocol family 17
> RPC: Registered udp transport module.
> RPC: Registered tcp transport module.
> VFP support v0.3: implementor 41 architecture 1 part 20 variant b rev 5
> registered taskstats version 1
> net eth0: SMSC911x/921x identified at 0xc8880000, IRQ: 74
> Sending DHCP requests .., OK
> IP-Config: Got DHCP answer from 10.170.0.51, my address is 10.170.0.53
> IP-Config: Complete:
>     device=eth0, addr=10.170.0.53, mask=255.255.255.0, gw=10.170.0.4,
>     host=10.170.0.53, domain=, nis-domain=(none),
>     bootserver=10.170.0.51, rootserver=10.170.0.51, rootpath=/mnt/opt/fs
> md: Waiting for all devices to be available before autodetect
> md: If you don't use raid, use raid=noautodetect
> md: Autodetecting RAID arrays.
> md: Scanned 0 and added 0 devices.
> md: autorun ...
> md: ... autorun DONE.
> Looking up port of RPC 100003/2 on 10.170.0.51
> Looking up port of RPC 100005/1 on 10.170.0.51
> VFS: Mounted root (nfs filesystem).
> Freeing init memory: 152K
> Kernel panic - not syncing: Attempted to kill init!
> Dumping ftrace buffer:
>   (ftrace buffer empty)
> =======
>
> Thanks in advance.
>
> --regards,
> Abhijeet
>
>
>      The INTERNET now has a personality. YOURS! See your Yahoo! Homepage.
> http://in.yahoo.com/
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
>
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20091116/a0890cf9/attachment-0001.htm>
