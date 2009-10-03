From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Sat, 3 Oct 2009 13:48:32 +0100
Subject: Kernel update to 2.6.31.1 on pxa270: udev and usb storage
	cause kernel Oops
In-Reply-To: <1254213562.5586.13.camel@wks02-lin.nanotronic.local>
References: <1254213562.5586.13.camel@wks02-lin.nanotronic.local>
Message-ID: <20091003124832.GA15525@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

I think you need to report this to the USB/udev people.

On Tue, Sep 29, 2009 at 10:39:22AM +0200, hoefle marco wrote:
> Hello,
> we use Kernel 2.6.30.4 on a PXA270 platform (from Phytec). It works good
> with all peripherals on the Phytec board. 
> For an old Sandisk device (diskonchip) we have a driver ported to 2.6.3x
> as the block device driver API has changed. We thought it will be a wise
> decision to do the porting already to 2.6.3x. 
> However, when using the latest Kernel (and the previous one 2.6.30) with
> all the drivers we used in 2.6.30.4 udev and usb storage seem not to
> work any more.
> Does anybody have an idea why?
> Thanks,
> Marco
>  
> 
> 
> 
> usb 1-1.3: new high speed USB device using isp1760 and address 3
> usb 1-1.3: New USB device found, idVendor=136b, idProduct=0918
> usb 1-1.3: New USB device strings: Mfr=1, Product=2, SerialNumber=3
> usb 1-1.3: Product: STEC USB 512MB
> usb 1-1.3: Manufacturer: STEC
> usb 1-1.3: SerialNumber:  STI  EN207277102034
> usb 1-1.3: configuration #1 chosen from 1 choice
> scsi0 : SCSI emulation for USB Mass Storage devices
> IP-Config: Complete:
>      device=eth0, addr=192.168.99.245, mask=255.255.255.0,
> gw=192.168.99.237,
>      host=emdebian, domain=, nis-domain=(none),
>      bootserver=192.168.99.237, rootserver=192.168.99.237, rootpath=
> VFS: Mounted root (jffs2 filesystem) on device 31:2.
> Freeing init memory: 108K
> eth0: link up, 100Mbps, full-duplex, lpa 0x45E1
> init started: BusyBox v1.11.1 (2008-08-08 18:56:00 ART)
> starting pid 179, tty '': '/etc/init.d/rcS'
> Starting the hotplug events dispatcher: udevd.
> Synthesizing the initial hotplug events...Unable to handle kernel paging
> request at virtual address 03a02001
> pgd = c39e8000
> [03a02001] *pgd=00000000
> Internal error: Oops: f5 [#1]
> Modules linked in:
> CPU: 0    Not tainted  (2.6.31.1 #3)
> PC is at strlen+0x18/0x2c
> LR is at kobject_get_path+0x2c/0xac
> pc : [<c013efac>]    lr : [<c013b910>]    psr: 20000013
> sp : c39cbe48  ip : c39cbe58  fp : c39cbe54
> r10: c02e2c9c  r9 : 00000000  r8 : c3802c60
> r7 : c0020260  r6 : 000000d0  r5 : 00000007  r4 : 0000c328
> r3 : 00000000  r2 : 03a02001  r1 : 000000d0  r0 : 03a02001
> Flags: nzCv  IRQs on  FIQs on  Mode SVC_32  ISA ARM  Segment user
> Control: 0000397f  Table: a39e8000  DAC: 00000015
> Process udevadm (pid: 232, stack limit = 0xc39ca270)
> Stack: (0xc39cbe48 to 0xc39cc000)
> be40:                   c39cbe78 c39cbe58 c013b910 c013efa0 c0020258
> 00000003 
> be60: c3932e40 c391d000 c3802c60 c39cbe9c c39cbe7c c015b814 c013b8f0
> 00000000 
> be80: 00000000 00000003 c391d000 c3932e48 c39cbee8 c39cbea0 c013be28
> c015b63c 
> bea0: 00000000 00000000 c399f3e0 c028bc9e c0291f72 c39cbed4 00000000
> 00000000 
> bec0: c3932e40 00000003 c39638e0 c3932e48 c02e2cdc c39638f4 c39cbf80
> c39cbef8 
> bee0: c39cbeec c013c068 c013bc54 c39cbf14 c39cbefc c015b8bc c013c060
> 00000000 
> bf00: c39137c8 00000003 c39cbf24 c39cbf18 c015b0a0 c015b84c c39cbf50
> c39cbf28 
> bf20: c00cb83c c015b084 c38dee60 00016d7c c39cbf80 00000004 00000003
> c39ca000 
> bf40: 00000000 c39cbf7c c39cbf54 c008a804 c00cb73c c39cbf94 c39cbf64
> 00000000 
> bf60: 00000000 c38dee60 00000004 c0024064 c39cbfa4 c39cbf80 c008a984
> c008a75c 
> bf80: 00000000 00000000 00000000 00000003 00016d7c bea5b354 00000000
> c39cbfa8 
> bfa0: c0023ec0 c008a944 00000003 00016d7c 00000003 00016d7c 00000003
> 00000000 
> bfc0: 00000003 00016d7c bea5b354 00025990 00016d7c 00200200 00000000
> 00100100 
> bfe0: 00000000 bea5b34c 0000d0a0 40119274 40000010 00000003 ffffffff
> ffffffff 
> Backtrace: 
> [<c013ef94>] (strlen+0x0/0x2c) from [<c013b910>] (kobject_get_path
> +0x2c/0xac)
> [<c013b8e4>] (kobject_get_path+0x0/0xac) from [<c015b814>] (dev_uevent
> +0x1e4/0x210)
>  r8:c3802c60 r7:c391d000 r6:c3932e40 r5:00000003 r4:c0020258
> [<c015b630>] (dev_uevent+0x0/0x210) from [<c013be28>]
> (kobject_uevent_env+0x1e0/0x40c)
>  r7:c3932e48 r6:c391d000 r5:00000003 r4:00000000
> [<c013bc48>] (kobject_uevent_env+0x0/0x40c) from [<c013c068>]
> (kobject_uevent+0x14/0x18)
> [<c013c054>] (kobject_uevent+0x0/0x18) from [<c015b8bc>] (store_uevent
> +0x7c/0x8c)
> [<c015b840>] (store_uevent+0x0/0x8c) from [<c015b0a0>] (dev_attr_store
> +0x28/0x2c)
>  r5:00000003 r4:c39137c8
> [<c015b078>] (dev_attr_store+0x0/0x2c) from [<c00cb83c>]
> (sysfs_write_file+0x10c/0x144)
> [<c00cb730>] (sysfs_write_file+0x0/0x144) from [<c008a804>] (vfs_write
> +0xb4/0x160)
> [<c008a750>] (vfs_write+0x0/0x160) from [<c008a984>] (sys_write
> +0x4c/0x80)
>  r8:c0024064 r7:00000004 r6:c38dee60 r5:00000000 r4:00000000
> [<c008a938>] (sys_write+0x0/0x80) from [<c0023ec0>] (ret_fast_syscall
> +0x0/0x2c)
>  r6:bea5b354 r5:00016d7c r4:00000003
> Code: e24cb004 e1a02000 ea000000 e2800001 (e5d03000) 
> ---[ end trace 0f9f3a3683bef81b ]---
> Segmentation fault
> failed.
> Waiting for /dev to be fully populated...done.
> scsi 0:0:0:0: Direct-Access     STEC     512MB USB        1.00 PQ: 0
> ANSI: 2
> Unable to handle kernel paging request at virtual address e52de004
> pgd = c39dc000
> [e52de004] *pgd=00000000
> Internal error: Oops: f5 [#2]
> Modules linked in:
> CPU: 0    Tainted: G      D     (2.6.31.1 #3)
> PC is at strlen+0x18/0x2c
> LR is at kobject_get_path+0x2c/0xac
> pc : [<c013efac>]    lr : [<c013b910>]    psr: a0000013
> sp : c3925cc8  ip : c3925cd8  fp : c3925cd4
> r10: c02e2c9c  r9 : 00000000  r8 : c3802c60
> r7 : c39ee2b0  r6 : 000000d0  r5 : 00000048  r4 : 0000c328
> r3 : 00000000  r2 : e52de004  r1 : 000000d0  r0 : e52de004
> Flags: NzCv  IRQs on  FIQs on  Mode SVC_32  ISA ARM  Segment kernel
> Control: 0000397f  Table: a39dc000  DAC: 00000017
> Process usb-stor-scan (pid: 167, stack limit = 0xc3924270)
> Stack: (0xc3925cc8 to 0xc3926000)
> 5cc0:                   c3925cf8 c3925cd8 c013b910 c013efa0 c38447d4
> c39ee2a8 
> 5ce0: c39d7000 c39ee2b0 c3802c60 c3925d44 c3925cfc c013bd70 c013b8f0
> 00000001 
> 5d00: 00000000 c39ee2a8 c028bc9e c02a47b0 00000000 c3925d30 c3925d24
> c38447d4 
> 5d20: c39ee2a8 c3909780 c39ee200 00000000 c02e315c c39ee2b0 c3925d54
> c3925d48 
> 5d40: c013c068 c013bc54 c3925d9c c3925d58 c015c6fc c013c060 c3925d64
> c38447d4 
> 5d60: 00000000 c38cd228 00000008 c38447d4 00000000 c38447d4 00000000
> c39ee2a8 
> 5d80: c39ee200 00000000 c39ee200 c38445c0 c3925dbc c3925da0 c016d1f8
> c015c250 
> 5da0: 00000002 c3963ce8 c3963cf0 c3963d00 c3925e4c c3925dc0 c016afb0
> c016d168 
> 5dc0: c3963ce8 c3963cf0 c3963d00 00000000 00000002 c029e30a 00000000
> c3925ebc 
> 5de0: 00000000 c38447c0 00000000 c3828800 c399f1e0 c02a47b0 c39ee2a8
> 00000024 
> 5e00: 00000012 c3920024 c3925e14 c016a330 00000000 00000000 00000000
> 00000000 
> 5e20: 00000000 00000000 c38288e0 00000000 ffffffff 00000000 00000000
> c38447c0 
> 5e40: c3925ee8 c3925e50 c016b394 c016a760 00000000 00000000 c3925e64
> c02309c8 
> 5e60: c00363e8 c3852e48 c3924000 a0000013 ffff916d c3925f14 000003e8
> c3924000 
> 5e80: 00000000 00000001 c3925ec4 c3925e98 c0230c7c c0042e58 00000000
> 00200200 
> 5ea0: ffff916d c0043414 c3852cc0 c02f24e0 00000001 00000001 c3925f00
> 00000000 
> 5ec0: 00000000 c3828800 c38288e0 ffffffff 00000000 00000000 00000000
> c3925f14 
> 5ee0: c3925eec c016b86c c016b2e4 00000000 00000001 c3828800 ffffffff
> ffffffff 
> 5f00: c3828828 00000000 c3925f40 c3925f18 c016b938 c016b824 00000000
> c3828800 
> 5f20: c3925f8c c3828800 c3924000 00000000 c3828a48 c3925f60 c3925f44
> c016ba14 
> 5f40: c016b8a4 00000000 c3828ae8 c3925f8c c3828800 c3925f88 c3925f64
> c016bd10 
> 5f60: c016b998 00000000 c3828ae8 c3925f8c c3828a2c c3924000 00000000
> c3925fc4 
> 5f80: c3925f8c c01a2c8c c016bb90 00000000 c3852cc0 c004da20 c3925f98
> c3925f98 
> 5fa0: c3925fcc c38e3c04 c3828a2c c01a2b68 00000000 00000000 c3925ff4
> c3925fc8 
> 5fc0: c004d56c c01a2b74 00000000 00000000 c3925fd0 c3925fd0 00000000
> 00000000 
> 5fe0: 00000000 00000000 00000000 c3925ff8 c003c7f4 c004d4f4 ffffffff
> ffffffff 
> Backtrace: 
> [<c013ef94>] (strlen+0x0/0x2c) from [<c013b910>] (kobject_get_path
> +0x2c/0xac)
> [<c013b8e4>] (kobject_get_path+0x0/0xac) from [<c013bd70>]
> (kobject_uevent_env+0x128/0x40c)
>  r8:c3802c60 r7:c39ee2b0 r6:c39d7000 r5:c39ee2a8 r4:c38447d4
> [<c013bc48>] (kobject_uevent_env+0x0/0x40c) from [<c013c068>]
> (kobject_uevent+0x14/0x18)
> [<c013c054>] (kobject_uevent+0x0/0x18) from [<c015c6fc>] (device_add
> +0x4b8/0x62c)
> [<c015c244>] (device_add+0x0/0x62c) from [<c016d1f8>]
> (scsi_sysfs_add_sdev+0x9c/0x1f0)
> [<c016d15c>] (scsi_sysfs_add_sdev+0x0/0x1f0) from [<c016afb0>]
> (scsi_probe_and_add_lun+0x85c/0x9c0)
>  r7:c3963d00 r6:c3963cf0 r5:c3963ce8 r4:00000002
> [<c016a754>] (scsi_probe_and_add_lun+0x0/0x9c0) from [<c016b394>]
> (__scsi_scan_target+0xbc/0x540)
> [<c016b2d8>] (__scsi_scan_target+0x0/0x540) from [<c016b86c>]
> (scsi_scan_channel+0x54/0x80)
> [<c016b818>] (scsi_scan_channel+0x0/0x80) from [<c016b938>]
> (scsi_scan_host_selected+0xa0/0xf4)
> [<c016b898>] (scsi_scan_host_selected+0x0/0xf4) from [<c016ba14>]
> (do_scsi_scan_host+0x88/0x90)
> [<c016b98c>] (do_scsi_scan_host+0x0/0x90) from [<c016bd10>]
> (scsi_scan_host+0x18c/0x1d4)
>  r6:c3828800 r5:c3925f8c r4:c3828ae8
> [<c016bb84>] (scsi_scan_host+0x0/0x1d4) from [<c01a2c8c>]
> (usb_stor_scan_thread+0x124/0x14c)
>  r8:00000000 r7:c3924000 r6:c3828a2c r5:c3925f8c r4:c3828ae8
> [<c01a2b68>] (usb_stor_scan_thread+0x0/0x14c) from [<c004d56c>] (kthread
> +0x84/0x8c)
> [<c004d4e8>] (kthread+0x0/0x8c) from [<c003c7f4>] (do_exit+0x0/0x5c4)
>  r7:00000000 r6:00000000 r5:00000000 r4:00000000
> Code: e24cb004 e1a02000 ea000000 e2800001 (e5d03000) 
> ---[ end trace 0f9f3a3683bef81c ]---
> Setting hostname to 'emdebian-arm'...done.
> Files under mount point '/lib/init/rw' will be hidden. (warning).
> mknod: unrecognized option `--mode=666'
> BusyBox v1.11.1 (2008-08-08 18:56:00 ART) multi-call binary
> 
> Usage: mknod [OPTIONS] NAME TYPE MAJOR MINOR
> 
> Create a special file (block, character, or pipe)
> 
> Options:
>         -m      Create the special file using the specified mode
> (default a=rw)
> TYPEs include:
>         b:      Make a block device
>         c or u: Make a character device
>         p:      Make a named pipe (MAJOR and MINOR are ignored)
> 
> Activating swap:.
> Removing stale PID file /var/run/dbus/pid..
> Starting system message bus: dbus.
> FATAL: Could not load /lib/modules/2.6.31.1/modules.dep: No such file or
> directory
> Can't open /dev/ttyS2: No such file or directory
> process '/sbin/getty -L ttyS2 115200 vt100' (pid 372) exited. Scheduling
> for restart.
> Can't open /dev/ttyS2: No such file or directory
> process '/sbin/getty -L ttyS2 115200 vt100' (pid 385) exited. Scheduling
> for restart.
> Can't open /dev/ttyS2: No such file or directory
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
