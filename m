From: harninder.rai@nxp.com (Harninder Rai)
Date: Thu, 17 Mar 2016 16:57:53 +0000
Subject: Help needed with kexec on arm64
Message-ID: <DB5PR04MB16882EFB355C766842A6887DE68B0@DB5PR04MB1688.eurprd04.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Takahiro Akashi/Geoff,

I was trying to run kexec on NXP's ls2085ardb board (based on arm64) but I am facing following issue

root at ls2085ardb:~# kexec -p /run/media/mmcblk0p1/vmlinux
Memory for crashkernel is not reserved
Please reserve memory by passing"crashkernel=X at Y" parameter to kernel
Then try to loading kdump kernel

I am using git://git.kernel.org/pub/scm/linux/kernel/git/geoff/linux-kexec.git commit ae2804a21b4686df02890027e64c11088439854c

I have done the following in bootargs
--------------------------------------------------

dmesg |grep crash -i
[    0.000000] Reserving 64MB of memory at 2240MB for crashkernel
[    0.000000] Kernel command line: console=ttyS1,115200 root=/dev/ram0 earlycon=uart8250,mmio,0x21c0600 ramdisk_size=0x200000 default_hugepagesz=2m hugepagesz=2m hugepages=256 crashkernel=64M at 2240M

All the required kernel configs are also enabled
--------------------------------------------------

root at ls2085ardb:~# zcat /proc/config.gz |grep -i sysfs
# CONFIG_SYSFS_DEPRECATED is not set
CONFIG_SYSFS_SYSCALL=y
# CONFIG_GPIO_SYSFS is not set
CONFIG_RTC_INTF_SYSFS=y
# CONFIG_DMI_SYSFS is not set
CONFIG_SYSFS=y
root at ls2085ardb:~# zcat /proc/config.gz |grep -i kexec
CONFIG_KEXEC_CORE=y
CONFIG_KEXEC=y
root at ls2085ardb:~# zcat /proc/config.gz |grep -i kdump
root at ls2085ardb:~# zcat /proc/config.gz |grep -i debug_info
CONFIG_DEBUG_INFO=y
# CONFIG_DEBUG_INFO_REDUCED is not set
# CONFIG_DEBUG_INFO_SPLIT is not set
# CONFIG_DEBUG_INFO_DWARF4 is not set
root at ls2085ardb:~# zcat /proc/config.gz |grep -i crash
CONFIG_CRASH_DUMP=y


Any pointer in this regard would be much appreciated

Thanks and Regards
Harry++
