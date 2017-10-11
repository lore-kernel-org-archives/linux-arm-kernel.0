From: prabhakar.kushwaha@nxp.com (Prabhakar Kushwaha)
Date: Wed, 11 Oct 2017 09:11:09 +0000
Subject: kdump: need help with kexec -p
Message-ID: <HE1PR04MB12416F54193B1A61BC0652ED974A0@HE1PR04MB1241.eurprd04.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi All,

We are facing some issues while using ?kexec -p on ARM64 NXP platforms. 

1) After calling kexec -p, if immediately "panic" is triggered the crash kernel does not boot. If we run few commands and wait for atleast (20-30 secs), before triggering the panic, the crash kernel boots.
2) We do not see the issue ("1" ), when we do umount -a, before calling the panic after kexec-p.
The issue does not seem to pertain to the NXP software it seems. ? (because this observation has been observed on very simple kernel, where most of the controllers have been removed from device tree). 

Also found some info related to this on? internet where it is mentioned that without un-mounting the mounted filesystems, the boot of next kernel is not recommended. (this is in context of kexec -e though)
https://www.linux.com/news/reboot-racecar-kexec.

Does any one has found similar observations, looking for clues.

Test ?method:
Run base kernel.
At the base kernel:
#./kexec -p ./Image ?--append="root=/dev/ram0 rw console=ttyS0,115200 earlycon=uart8250,0x21c0500,115200 maxcpus=1 "? --initrd="fsl-image-core-ls1043ardb.ext2.gz"
#echo c > /proc/sysrq-trigger

kexec version used is 2.0.14

--prabhakar
