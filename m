From: augulis.darius@gmail.com (Darius Augulis)
Date: Tue, 24 Aug 2010 23:07:47 +0300
Subject: s3c ohci problem
Message-ID: <i518qk$j8u$1@dough.gmane.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi all,

below is boot log of s3c2410-ohci driver.

ohci_hcd: USB 1.1 'Open' Host Controller (OHCI) Driver
ohci_hcd: block sizes: ed 64 td 64
s3c2410-ohci s3c2410-ohci: s3c2410_start_hc:
s3c2410-ohci s3c2410-ohci: S3C24XX OHCI
drivers/usb/core/inode.c: creating file 'devices'
drivers/usb/core/inode.c: creating file '001'
s3c2410-ohci s3c2410-ohci: new USB bus registered, assigned bus number 1
s3c2410-ohci s3c2410-ohci: irq 79, io mem 0x74300000
s3c2410-ohci s3c2410-ohci: created debug files
s3c2410-ohci s3c2410-ohci: fminterval delta -11999
s3c2410-ohci s3c2410-ohci: enabling initreset quirk
s3c2410-ohci s3c2410-ohci: init err (00000000 0000)
ohci_hcd: can't start s3c24xx
s3c2410-ohci s3c2410-ohci: OHCI controller state
s3c2410-ohci s3c2410-ohci: OHCI 0.0, NO legacy support registers
s3c2410-ohci s3c2410-ohci: control 0x000 HCFS=reset CBSR=0
s3c2410-ohci s3c2410-ohci: cmdstatus 0x00000 SOC=0
s3c2410-ohci s3c2410-ohci: intrstatus 0x00000000
s3c2410-ohci s3c2410-ohci: intrenable 0x00000000
s3c2410-ohci s3c2410-ohci: hcca frame #0000
s3c2410-ohci s3c2410-ohci: roothub.a 00000000 POTPGT=0 NDP=0(0)
s3c2410-ohci s3c2410-ohci: roothub.b 00000000 PPCM=0000 DR=0000
s3c2410-ohci s3c2410-ohci: roothub.status 00000000
s3c2410-ohci s3c2410-ohci: startup error -75
s3c2410-ohci s3c2410-ohci: USB bus 1 deregistered
s3c2410-ohci s3c2410-ohci: s3c2410_stop_hc:
s3c2410-ohci: probe of s3c2410-ohci failed with error -75

Kernel is v2.6.36-rc2 with few minor patches adding new devices to 
mach-real6410. Board is Real6410. It seems there isn't any USB 
enable/disable bit s3c6410 registers, also no gpio multiplexing. There 
is no power control for usb on this board, it's always powered on.
Could it be driver problem? Did anybody get USB working on smdk6410 or 
other s3c64xx boards with latest kernel?

Darius.
