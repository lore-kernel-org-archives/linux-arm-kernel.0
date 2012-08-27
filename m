From: nareshgbhat@gmail.com (Naresh Bhat)
Date: Mon, 27 Aug 2012 16:16:02 +0530
Subject: Boot v3.5 kernel on QEMU for vexpress-a15 architecture with cpu as
 cortex-a15
Message-ID: <CAJXQGfLUyP=J6=Asd8eM6wcHN90Vc52=wekM=16XoH_D_KXPbA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi All,

I want to boot kernel.org v3.5 image (zImage) using QEMU with machine
architecture as vexpress-a15 and cpu as cortex-a15 on my Fedora-17
desktop machine.  I have followed the below method but resulted
nothing.  Can anybody please point me in a right direction ?

1. Clone the Torvalds kernel
   # git clone git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git

2. Checkout to v3.5-rc7 branch
    # git branch linux-3.5-rc7 v3.5-rc7

3. Cross compile the kernel
    # make ARCH=arm CROSS_COMPILE=arm-cortex_a15-linux-gnueabi-
vexpress_defconfig
    # make ARCH=arm CROSS_COMPILE=arm-cortex_a15-linux-gnueabi- uImage modules

4. Grab Pawe?'s DTS tree: git://linux-arm.org/arm-dts.git

5. From your kernel tree, run:
    # ./script/dtc/dtc -O dtb -o rtsm_ve-cortex_a15x4.dtb
wherever_your_arm-dts_tree_is/fast_models/rtsm_ve-cortex_a15x4.dts
    # cat rtsm_ve-cortex_a15x2.dtb >>arch/arm/boot/zImage

6.  Try to boot using QEMU

# qemu-system-arm -kernel arch/arm/boot/zImage -dtb
./rtsm_ve-cortex_a15x4.dtb -m 512 -M vexpress-a15 -cpu cortex-a15
-append "console=ttyAMA0"
oss: Could not initialize DAC
oss: Failed to open `/dev/dsp'
oss: Reason: No such file or directory
oss: Could not initialize DAC
oss: Failed to open `/dev/dsp'
oss: Reason: No such file or directory
audio: Failed to create voice `lm4549.out'
.................
........................

I am just a beginner in QEMU.  Am I doing any steps wrong ?? can you
please suggest right method ? I will appreciate your help.

-- Thanks and Regards
"For things to change, we must change"
-Naresh Bhat
