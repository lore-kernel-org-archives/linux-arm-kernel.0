From: timur@codeaurora.org (Timur Tabi)
Date: Thu, 1 Jun 2017 17:43:20 -0500
Subject: Need help booting allmodconfig on arm64
Message-ID: <CAOZdJXUr6wAE5CZBzmADOAVBGL692FVzaaGwaC7hzJ7GtJmxtA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

I'm trying to boot an allmodconfig kernel on my arm64 ACPI system, and
although I'm very close, I can't seem to get the kernel to boot the
rootfs.

I build using this command:

make ARCH=arm64 KCONFIG_ALLCONFIG=boot-allmod.config allmodconfig

where boot-allmod.config contains this:

CONFIG_CPU_BIG_ENDIAN=n
CONFIG_SERIAL_AMBA_PL011=y
CONFIG_SERIAL_AMBA_PL011_CONSOLE=y
CONFIG_DEBUG_KOBJECT_RELEASE=n
CONFIG_DEBUG_TEST_DRIVER_REMOVE=n
CONFIG_KASAN=n
CONFIG_FTRACE_STARTUP_TEST=n
CONFIG_DEBUG_BLOCK_EXT_DEVT=n
CONFIG_EXT4_FS=y
CONFIG_SATA_AHCI=y
CONFIG_SATA_AHCI_PLATFORM=y
CONFIG_CMDLINE_FORCE=n
CONFIG_DEBUG_WX=n

The last few lines of dmesg are:

   96.588564] ### dt-test ### FAIL
of_unittest_overlay_high_level():2131 overlay_base_root not
initialized
[   96.597878] ### dt-test ### end of unittest - 142 passed, 1 failed
[   96.604056] PM: Hibernation image not present or could not be loaded.
[   96.610767] Unable to open file: /etc/keys/x509_ima.der (-2)
[   96.610814] Unable to open file: /etc/keys/x509_evm.der (-2)
[   96.621504] Freeing unused kernel memory: 8192K
[   96.630749] rodata_test: all tests were successful
[   96.635768] Failed to execute /init (error -8)

It boots to my initramfs, but not my SATA rootfs.  I think the problem
is that /init is a shell script, and there's no interpreter?

-- 
Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project.
