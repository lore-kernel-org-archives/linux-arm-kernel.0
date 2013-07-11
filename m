From: rogerq@ti.com (Roger Quadros)
Date: Thu, 11 Jul 2013 13:24:19 +0300
Subject: [PATCH] ARM: OMAP3: Beagle: Fix USB Host on beagle xM Ax/Bx
In-Reply-To: <51DC1B47.7070504@denx.de>
References: <1366024808-4691-1-git-send-email-rogerq@ti.com>
 <51DC09E7.1070302@denx.de> <51DC164B.5010608@ti.com>
 <51DC1B47.7070504@denx.de>
Message-ID: <51DE87D3.5030600@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/09/2013 05:16 PM, Stefan Roese wrote:
> Hi Roger,
> 
>>
>> I have been too lazy to setup NFS :). But I will give it a shot soon to see what's going
>> wrong.
> 
> Really appreciated. :) Please let me know if you need anything else from
> me to reproduce this issue.

Stefan,

I tried it out today and it worked 5/5 times. I used a bare bones debian root filesystem for
the NFS root.

Could it be possible that the boot scripts on your filesystem are somehow shutting down
the ethernet interface? Might be worth checking on a fresh filesystem.

My u-boot script is below and boot log is attached.

setenv bootargs console=ttyO2,115200n8 root=/dev/nfs rw nfsroot=192.168.2.1:/srv/nfsroot/ ip=192.168.2.2 rootwait

setenv usbethaddr A6:66:4D:B0:69:04
setenv netmask 255.255.255.0
setenv ipaddr 192.168.2.2
setenv serverip 192.168.2.1

usb start

tftpboot 0x825f0000 omap3-beagle.dtb
tftpboot 0x80300000 uImage
set fdt_high 0xffffffff

bootm 0x80300000 - 0x825f0000

cheers,
-roger

-------------- next part --------------
A non-text attachment was scrubbed...
Name: nfs-boot.log
Type: text/x-log
Size: 19655 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130711/dc853f1d/attachment-0001.bin>
