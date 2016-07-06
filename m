From: myy@miouyouyou.fr (Myy)
Date: Wed, 06 Jul 2016 17:04:27 +0000
Subject: RK3188 : Kernel installation madness
Message-ID: <2fc5082b15eac774f6947c782f03de8f@miouyouyou.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Greetings,

I asked on the ARM Community Forum how to compile and flash a new kernel 
on a RK3188 device ( https://community.arm.com/thread/10159 ) and I was 
told that the ARM LKML would be the best place for that kind of 
questions. I sent a mail to the arm-lkml but, in the same ARM Community 
Forum thread, I was again told that arm-linux-kernel would be best 
suited for that kind of questions. So here I am.

I currently own a Cube GT2 tablet, which uses a RK3188 chip.
My goal is to install a new (4.7.x) kernel on this device. However, 
between the facts that the NAND driver still requires some reverse 
engineering and the fact that I do not know how kernels are booted on 
that kind of hardware, I'm stuck.

So my current objectives are :
- Load a modified initrd image.
- Load a modified initrd containing the graphic driver (if possible), 
the Wifi driver, wpa_supplicant and sshd, with the currently installed 
kernel.
- Replace the kernel with a new stock kernel, using the same initrd.

So my current questions are :
- Where does the system loads the initrd images from ?
    I extracted the android boot image stored in the boot partition, 
using rkflashkit, replaced the initrd, repacked the image and reflahsed 
it but, STILL, when returning on Android, it clearly seems that a 
different initrd file was used. Same thing when flashing the modified 
image to the "kernel" partition too.
- How to pack kernels and initrd ?
    There's a ton of rk3188 3.0.36+ kernels available on Github that do 
NOT compile. The only kernel I was able to compile is the official one. 
Of course, when trying to boot from my new kernel, the systems started a 
reboot loop, with no informations about what went wrong... I do not 
understand what rkcrc do and the kernel inside the Android boot Image do 
not have any standard Linux Kernel header. So, what is the official 
procedure for packing AND unpacking kernels and initrd images ?

The param file of my tablet is as follows :

FIRMWARE_VER:4.1.1
MACHINE_MODEL:U30GT 2
MACHINE_ID:007
MANUFACTURER:RK30SDK
MAGIC: 0x5041524B
ATAG: 0x60000800
MACHINE: 3066
CHECK_MASK: 0x80
KERNEL_IMG: 0x60408000
#RECOVER_KEY: 1,1,0,20,0
CMDLINE:console=ttyFIQ0 androidboot.console=ttyFIQ0 init=/init 
initrd=0x62000000,0x00800000 
mtdparts=rk29xxnand:0x00002000 at 0x00002000(misc),0x00006000 at 0x00004000(kernel),0x00006000 at 0x0000A000(boot),0x00010000 at 0x00010000(recovery),0x00020000 at 0x00020000(backup),0x00040000 at 0x00040000(cache),0x00400000 at 0x00080000(userdata),0x00002000 at 0x00480000(kpanic),0x00100000 at 0x00482000(system),- at 0x00582000(user)

There seems to be some fragments of documentation about how to load some 
LiveSD system, but I don't know if it's possible with this tablet. And 
quite frankly, half of the documentation is badly put together.

Best regards,

-- 
Myy
