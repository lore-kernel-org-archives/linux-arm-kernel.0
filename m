From: rumjantsev@papillon.ru (237 Rumjantsev Egor (PROG))
Date: Wed, 26 May 2010 09:47:23 +0600
Subject: vpack270 and sleep mode
In-Reply-To: <201005252247.57688.marek.vasut@gmail.com>
References: <1272311167-576-1-git-send-email-marek.vasut@gmail.com>
	<4BFBD01E.8010101@papillon.ru>
	<20100525202447.GD16204@n2100.arm.linux.org.uk>
	<201005252247.57688.marek.vasut@gmail.com>
Message-ID: <4BFC99CB.2090902@papillon.ru>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

26.05.2010 02:47, Marek Vasut ?????:
> Dne ?t 25. kv?tna 2010 22:24:47 Russell King - ARM Linux napsal(a):
>> On Tue, May 25, 2010 at 07:26:54PM +0600, 237 Rumjantsev Egor (PROG) wrote:
>>> Unable to handle kernel paging request at virtual address a03ab26f
>>> pgd = c7b10000
>>> [a03ab26f] *pgd=8020040e(bad)
>>> Internal error: Oops: 803 [#1] PREEMPT
>>> Modules linked in: ipv6 pxa_reg
>>> CPU: 0    Not tainted  (2.6.28.10-vpac3-splash #90)
>>> PC is at bad_channel+0x80166/0x91f28
>>> LR is at platform_pm_resume_noirq+0x48/0x54
>>
>> My guess is that some platform driver hasn't been properly updated,
>> and was registered using driver_register() rather than
>> platform_driver_register().
>>
>> Check your platform drivers to make sure that they're properly up to
>> date.
>
> I suspect that pxa_reg module. Like I said earlier.
>
i've tried to run the kernel without loading pxa_reg but core test still 
fails.

Here is a part of boot & core pm test logs. As you can see there is the 
only ipv6 module loaded.
Do i have to remove one by one platform devices from my machine 
description to find which device fails to suspend/resume ?

I forgot to say that i use root file system via NFS. Can it be a problem 
in suspend/resume process ?


Starting syslog daemon
Starting klog daemon
Starting system message bus:... OK
Bringing up loopback interface
ip: RTNETLINK answers: File exists
Enabling IPv4 packet forwarding
net.ipv4.ip_forward = 1
Bringing up interface bnep0
ifup: ignoring unknown interface bnep0
Bringing up interface eth0
ip: RTNETLINK answers: File exists
$Starting APM daemon: OK
Starting proftpdwarning: `proftpd' uses 32-bit capabilities (legacy 
support in use)
...OK

mount: can't find /mnt/flash in /etc/fstab or /etc/mtab
/usr/sbin/alsactl: load_state:1608: No soundcards found...
Starting sshd
NET: Registered protocol family 10
startup success

hwclock: can't open '/dev/misc/rtc': No such file or directory
time zone info file /usr/share/zoneinfo/Asia/Yekaterinburg used
25567 00021.314     647.0     48.9  1274844525650972.8 110000.6         0
hwclock: can't open '/dev/misc/rtc': No such file or directory
PM: Adding info for No Bus:vcs1
PM: Adding info for No Bus:vcsa1
PM: Adding info for No Bus:vcs2
PM: Adding info for No Bus:vcsa2
PM: Removing info for No Bus:vcs2
PM: Removing info for No Bus:vcsa2
PM: Adding info for No Bus:vcs2
PM: Adding info for No Bus:vcsa2
PM: Adding info for No Bus:vcs3
PM: Adding info for No Bus:vcsa3
pxafb_getmode(): search proper mode
pxafb_getmode(): found mode[0] w: 320 h: 240
pxafb_check_var(): depth: 32
pxafb_check_var(): found our mode
pxafb_bpp_to_lccr3(): our mode selected
eth0: no IPv6 routers present
pxa_pm_valid(): enter to pm valid: 3
Power regs:
GPDR0: 0xCBF9E200
PWER: 0x00000001
PFER: 0x00000000
PRER: 0x00000001
PGSR0: 0x00010000
PGSR1: 0x000F2000
PGSR2: 0x0404C000
PGSR3: 0x00000020
pxa_pm_valid(): go to pxa_valid
PM: Syncing filesystems ... done.
PM: Preparing system for mem sleep
pxafb_getmode(): search proper mode
pxafb_getmode(): found mode[0] w: 320 h: 240
pxafb_check_var(): depth: 32
pxafb_check_var(): found our mode
pxafb_bpp_to_lccr3(): our mode selected
Freezing user space processes ... (elapsed 0.01 seconds) done.
Freezing remaining freezable tasks ... (elapsed 0.00 seconds) done.
PM: Entering mem sleep
platform pxa27x-udc: preparing suspend
pxa2xx-uart pxa2xx-uart.0: preparing suspend
pxa2xx-uart pxa2xx-uart.1: preparing suspend
pxa2xx-uart pxa2xx-uart.2: preparing suspend
platform pxa2xx-i2s: preparing suspend
platform sa1100-rtc: preparing suspend
platform pxa2xx-i2c.1: preparing suspend
platform pxa27x-ssp.0: preparing suspend
platform pxa27x-ssp.1: preparing suspend
platform pxa27x-ssp.2: preparing suspend
platform pxa27x-pwm.0: preparing suspend
platform pxa27x-pwm.1: preparing suspend
dm9000 dm9000.0: preparing suspend
vpac270-ssp vpac270-ssp.0: preparing suspend
platform vpac270-pm.0: preparing suspend
platform pxa_g64_driver.0: preparing suspend
platform pxa2xx_dir_keypad.0: preparing suspend
platform pxa_capture.0: preparing suspend
platform pxa2xx-ac97: preparing suspend
platform mfrc531-ssp.0: preparing suspend
pxa2xx-flash pxa2xx-flash.0: preparing suspend
platform pxa2xx-mci.0: preparing suspend
platform pxa2xx-i2c.0: preparing suspend
pxa2xx-fb pxa2xx-fb: preparing suspend
pxa27x-ohci pxa27x-ohci: preparing suspend
platform regulatory.0: preparing suspend
usb usb1: preparing type suspend, may wakeup
usb usb1: type suspend, may wakeup
platform regulatory.0: suspend
pxa27x-ohci pxa27x-ohci: suspend
pxa2xx-fb pxa2xx-fb: suspend
platform pxa2xx-i2c.0: suspend
platform pxa2xx-mci.0: suspend
pxa2xx-flash pxa2xx-flash.0: suspend
platform mfrc531-ssp.0: suspend
platform pxa2xx-ac97: suspend
platform pxa_capture.0: suspend
platform pxa2xx_dir_keypad.0: suspend
platform pxa_g64_driver.0: suspend
platform vpac270-pm.0: suspend
vpac270-ssp vpac270-ssp.0: suspend
dm9000 dm9000.0: suspend
platform pxa27x-pwm.1: suspend
platform pxa27x-pwm.0: suspend
platform pxa27x-ssp.2: suspend
platform pxa27x-ssp.1: suspend
platform pxa27x-ssp.0: suspend
platform pxa2xx-i2c.1: suspend
platform sa1100-rtc: suspend
platform pxa2xx-i2s: suspend
pxa2xx-uart pxa2xx-uart.2: suspend
pxa2xx-uart pxa2xx-uart.1: suspend
pxa2xx-uart pxa2xx-uart.0: suspend
platform pxa27x-udc: suspend
pxa_pm_prepare(): enter to pm prepare
pxa27x_cpu_pm_prepare(): prepare to suspend
platform regulatory.0: LATE suspend
pxa27x-ohci pxa27x-ohci: LATE suspend
pxa2xx-fb pxa2xx-fb: LATE suspend
platform pxa2xx-i2c.0: LATE suspend
platform pxa2xx-mci.0: LATE suspend
pxa2xx-flash pxa2xx-flash.0: LATE suspend
platform mfrc531-ssp.0: LATE suspend
platform pxa2xx-ac97: LATE suspend
platform pxa_capture.0: LATE suspend
platform pxa2xx_dir_keypad.0: LATE suspend
platform pxa_g64_driver.0: LATE suspend
platform vpac270-pm.0: LATE suspend
vpac270-ssp vpac270-ssp.0: LATE suspend
dm9000 dm9000.0: LATE suspend
platform pxa27x-pwm.1: LATE suspend
platform pxa27x-pwm.0: LATE suspend
platform pxa27x-ssp.2: LATE suspend
platform pxa27x-ssp.1: LATE suspend
platform pxa27x-ssp.0: LATE suspend
platform pxa2xx-i2c.1: LATE suspend
platform sa1100-rtc: LATE suspend
platform pxa2xx-i2s: LATE suspend
pxa2xx-uart pxa2xx-uart.2: LATE suspend
pxa2xx-uart pxa2xx-uart.1: LATE suspend
pxa2xx-uart pxa2xx-uart.0: LATE suspend
platform pxa27x-udc: LATE suspend
suspend debug: Waiting for 5 seconds.

platform pxa27x-udc: EARLY resume
pxa2xx-uart pxa2xx-uart.0: EARLY resume
pxa2xx-uart pxa2xx-uart.1: EARLY resume
pxa2xx-uart pxa2xx-uart.2: EARLY resume
platform pxa2xx-i2s: EARLY resume
platform sa1100-rtc: EARLY resume
platform pxa2xx-i2c.1: EARLY resume
platform pxa27x-ssp.0: EARLY resume
platform pxa27x-ssp.1: EARLY resume
platform pxa27x-ssp.2: EARLY resume
platform pxa27x-pwm.0: EARLY resume
platform pxa27x-pwm.1: EARLY resume
dm9000 dm9000.0: EARLY resume
vpac270-ssp vpac270-ssp.0: EARLY resume
platform vpac270-pm.0: EARLY resume
platform pxa_g64_driver.0: EARLY resume
platform pxa2xx_dir_keypad.0: EARLY resume
platform pxa_capture.0: EARLY resume
platform pxa2xx-ac97: EARLY resume
platform mfrc531-ssp.0: EARLY resume
pxa2xx-flash pxa2xx-flash.0: EARLY resume
Unable to handle kernel paging request at virtual address a03ab26f
pgd = c6aac000
[a03ab26f] *pgd=8020040e(bad)
Internal error: Oops: 803 [#1] PREEMPT
Modules linked in: ipv6
CPU: 0    Not tainted  (2.6.28.10-vpac3-splash #90)
PC is at bad_channel+0x80166/0x91f28
LR is at platform_pm_resume_noirq+0x48/0x54
pc : [<a03ab23e>]    lr : [<a01cb758>]    psr: a00000b3
sp : c6a97e64  ip : c6a97e74  fp : c6a97e70
r10: 00000004  r9 : c7af7474  r8 : c7a1c000
r7 : 00000005  r6 : a03da1b0  r5 : a03f22e4  r4 : a03dd328
r3 : a03ab23b  r2 : 00000000  r1 : a03f22e4  r0 : a03dd320
Flags: NzCv  IRQs off  FIQs on  Mode SVC_32  ISA Thumb  Segment user
Control: 0000397f  Table: a6aac000  DAC: 00000015
Process sh (pid: 300, stack limit = 0xc6a96268)
Stack: (0xc6a97e64 to 0xc6a98000)
7e60: c6a97e88 c6a97e74 a01cd9b0 a01cb71c a03dd328 00000010 c6a97ea8
7e80: c6a97e8c a01ce248 a01cd968 00000010 00000000 00000003 a030d660 
c6a97ebc
7ea0: c6a97eac a01ce8c8 a01ce1e4 00000000 c6a97ed8 c6a97ec0 a006fd10 
a01ce8b8
7ec0: 0000dbff a038c7db 00000003 c6a97ef4 c6a97edc a006ff20 a006fc10 
a038c7db
7ee0: 00000003 00000003 c6a97f1c c6a97ef8 a0070040 a006fdfc c780dc14 
00000004
7f00: c7af7460 c781ada0 a03eeea4 c6a97f80 c6a97f2c c6a97f20 a018afe8 
a006ffb0
7f20: c6a97f58 c6a97f30 a00e1da8 a018afd0 c7a7ff20 4001d000 c6a97f80 
00000004
7f40: a00300a4 c6a96000 00000000 c6a97f7c c6a97f5c a0099b58 a00e1ca8 
c6a97f80
7f60: 00000000 00000000 c7a7ff20 00000004 c6a97fa4 c6a97f80 a0099cb8 
a0099ab0
7f80: 00000000 00000000 00000000 00000004 4001d000 401565f8 00000000 
c6a97fa8
7fa0: a002ff00 a0099c78 00000004 4001d000 00000001 4001d000 00000004 
00000000
7fc0: 00000004 4001d000 401565f8 00000004 00000001 9e96fb58 00000000 
9e96fa44
7fe0: 00000000 9e96f98c 4008df64 400e28b4 60000010 00000001 001b0375 
00001702
Backtrace:
[<a01cb710>] (platform_pm_resume_noirq+0x0/0x54) from [<a01cd9b0>] 
(pm_noirq_op+0x54/0x88)
[<a01cd95c>] (pm_noirq_op+0x0/0x88) from [<a01ce248>] 
(dpm_power_up+0x70/0xec)
  r5:00000010 r4:a03dd328
[<a01ce1d8>] (dpm_power_up+0x0/0xec) from [<a01ce8c8>] 
(device_power_up+0x1c/0x20)
  r7:a030d660 r6:00000003 r5:00000000 r4:00000010
[<a01ce8ac>] (device_power_up+0x0/0x20) from [<a006fd10>] 
(suspend_devices_and_enter+0x10c/0x1b4)
  r4:00000000
[<a006fc04>] (suspend_devices_and_enter+0x0/0x1b4) from [<a006ff20>] 
(enter_state+0x130/0x1b4)
  r6:00000003 r5:a038c7db r4:0000dbff
[<a006fdf0>] (enter_state+0x0/0x1b4) from [<a0070040>] 
(state_store+0x9c/0xc4)
  r6:00000003 r5:00000003 r4:a038c7db
[<a006ffa4>] (state_store+0x0/0xc4) from [<a018afe8>] 
(kobj_attr_store+0x24/0x28)
[<a018afc4>] (kobj_attr_store+0x0/0x28) from [<a00e1da8>] 
(sysfs_write_file+0x10c/0x144)
[<a00e1c9c>] (sysfs_write_file+0x0/0x144) from [<a0099b58>] 
(vfs_write+0xb4/0x140)
[<a0099aa4>] (vfs_write+0x0/0x140) from [<a0099cb8>] (sys_write+0x4c/0x80)
  r7:00000004 r6:c7a7ff20 r5:00000000 r4:00000000
[<a0099c6c>] (sys_write+0x0/0x80) from [<a002ff00>] 
(ret_fast_syscall+0x0/0x2c)
  r6:401565f8 r5:4001d000 r4:00000004
Code: 74732820 20657461 0a296425 69666300 (646d635f)
---[ end trace 0a425c17b54b883b ]---




-- 
Rumjantsev Egor
