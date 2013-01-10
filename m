From: nareshgbhat@gmail.com (Naresh Bhat)
Date: Thu, 10 Jan 2013 19:40:51 +0530
Subject: KDUMP on ARM cortex-a15
Message-ID: <CAJXQGf+SC2p0PdRboD0opzenG0Fkvyk_4ev2uM8QWukOE6KMFQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi

I am trying KDUMP feature on ARM Versatile Express Cortex-A15 target.

Target - Daughterboard Site 1: V2P-CA15_A7 Cortex A15
Kernel - git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
kexec-tools - git://git.kernel.org/pub/scm/utils/kernel/kexec/kexec-tools.git

I have referred the
https://wiki.linaro.org/KenWerner/Sandbox/crash-utility and passed
crashkernel command line argument as below

crashkernel=128M at 0x20000000

My command line arguments is bootargs="root=/dev/nfs rw ip=dhcp
console=ttyAMA0,38400n8 nosmp crashkernel=128M at 0x20000000"

But the target is got stuck as below

.........
................
Loading: #
done
Bytes transferred = 12141 (2f6d hex)
## Booting kernel from Legacy Image at 80000000 ...
   Image Name:   Linux-3.8.0-rc3
   Image Type:   ARM Linux Kernel Image (uncompressed)
   Data Size:    2586312 Bytes = 2.5 MiB
   Load Address: fffffff2
   Entry Point:  fffffff2
   Verifying Checksum ... OK
## Flattened Device Tree blob at 81f00000
   Booting using the fdt blob at 0x81f00000
   Loading Kernel Image ... OK
OK
   Loading Device Tree to 9fee3000, end 9fee8f6c ... OK

Starting kernel ...


Can anybody please suggest me a proper crashkernel=X at Y ?


-- Thanks and Regards
-Naresh Bhat
