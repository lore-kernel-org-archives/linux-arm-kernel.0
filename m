From: pingbo.wen@linaro.org (Pingbo Wen)
Date: Mon, 21 Dec 2015 12:00:28 +0800
Subject: 16KB PAGE_SIZE not work on DB410C
Message-ID: <5677795C.2060409@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello, 

I want to do some tests over 16KB page size on dragonboard 410c. And I merged 
arm64-upstream branch over 

  https://git.linaro.org/landing-teams/working/qualcomm/kernel.git integration-linux-qcomlt

which is based on Linux Kernel 4.3.

The db410c can boot into ubuntu in 4KB / 64KB page size, but when I set 16K page size, with
47bit VA, the kernel hang before kernel_start(), no log output.

Does db410c support 16K page size? What can I do to boot it up?

Below is what I got through serial port:

B -    437888 - QSEE Execution, Start
D -        61 - QSEE Execution, Delta
B -    443561 - SBL1, End
D -    245982 - SBL1, Delta
S - Flash Throughput, 111000 KB/s  (1151760 Bytes,  10309 us)
S - DDR Frequency, 400 MHz
Android Bootloader - UART_DM Initialized!!!
[0] welcome to lk

[10] platform_init()
[10] target_init()
[40] SDHC Running in HS200 mode
[90] Done initialization of the card
[90] pm8x41_get_is_cold_boot: cold boot
[90] No 'frp' partition found
[100] Not able to search the panel:
[100] Display not enabled for 24 HW type
[100] Target panel init not found!
[110] pm8x41_get_is_cold_boot: cold boot
[110] partition misc doesn't exist
[110] error in emmc_recovery_init
[120] Unable to locate /bootselect partition
[120] No 'misc' partition found
[120] Error reading MISC partition
[130] failed to get ffbm cookie[130] use_signed_kernel=0, is_unlocked=0, is_tampered=0.
[140] Loading boot image (15704064): start
[240] Loading boot image (15704064): done
[350] DTB Total entry: 15, DTB version: 2
[360] Using DTB entry 0x000000f7/00000000/0x00010018/0 for device 0x000000f7/00010000/0x00010018/0
[370] Using pmic info 0x2000b/0x0/0x0/0x0 for device 0x2000b/0x0/0x0/0x0
[370] target_display_panel_node:510: hw_id=24 panel_name=""
[380] cmdline: root=/dev/disk/by-partlabel/rootfs rw rootwait console=tty0 console=ttyMSM0,115200n8 earlycon=msm_serial androidboot.emmc=true androidboot.serialno=a4ce2318 androidboot.baseband=apq mdss_mdp.panel=0:dsi:0:
[400] Updating device tree: start
[490] Updating device tree: done
[500] booting linux @ 0x80080000, ramdisk @ 0x82000000 (2854016), tags/device tree @ 0x81e00000
[500] Jumping to kernel via monitor

Pingbo
