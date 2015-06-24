From: sr@denx.de (Stefan Roese)
Date: Wed, 24 Jun 2015 14:12:42 +0200
Subject: mvebu: Problem booting Armada XP with mainline U-Boot
Message-ID: <558A9EBA.9000902@denx.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi!

I'm currently testing Linux booting from mainline U-Boot (full version
with DDR training integrated as SPL - no bin_hdr) on the Marvell
Armada XP Development Board DB-MV784MP-GP. And this results in 
(at least) those 2 problems:

a) Secondary CPU(s) fail to come online:

...
[    0.130692] CPU: Testing write buffer coherency: ok
[    0.135785] CPU0: thread -1, cpu 0, socket 0, mpidr 80000000
[    0.141892] Setting up static identity map for 0x82c0 - 0x8318
[    0.148013] mvebu-soc-id: MVEBU SoC ID=0x7846, Rev=0x2
[    0.153357] mvebu-pmsu: Initializing Power Management Service Unit
[    0.160323] Booting CPU 1
[    1.158867] CPU1: failed to come online
[    1.162960] Booting CPU 2
[    2.158866] CPU2: failed to come online
[    2.162954] Booting CPU 3
[    3.158865] CPU3: failed to come online
[    3.162810] Brought up 1 CPUs
[    3.165870] SMP: Total of 1 processors activated (1594.16 BogoMIPS).
[    3.172329] CPU: All CPU(s) started in SVC mode.
...

b) Booting hangs completely while/after loading some device drivers:

...
[    4.031651] ehci_hcd: USB 2.0 'Enhanced' Host Controller (EHCI) Driver
[    4.038209] ehci-pci: EHCI PCI platform driver
[    4.042694] ehci-orion: EHCI orion driver
[    4.046784] orion-ehci f1050000.usb: EHCI Host Controller
[    4.052207] orion-ehci f1050000.usb: new USB bus registered, assigned bus number 1
[    4.059851] orion-ehci f1050000.usb: irq 27, io mem 0xf1050000

Disabling USB results in this hangup :

...
[    4.076795] Registering SWP/SWPB emulation handler
[    4.082575] rtc-mv f1010300.rtc: setting system clock to 2013-01-01 13:27:46 UTC (1357046866)

etc...

This happens with v4.1 and v4.0.5. Please find the complete boot
log attached.

Any ideas why those problems might occur with mainline U-Boot?
Most likely some register setup is missing that is usually done
in bin_hdr. Where could I check / test for this CPU online
problem?

Thanks,
Stefan
-------------- next part --------------
A non-text attachment was scrubbed...
Name: linux-boot.log
Type: text/x-log
Size: 12484 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150624/0c5e7993/attachment.bin>
