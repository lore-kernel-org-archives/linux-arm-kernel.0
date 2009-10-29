From: dk-arm-linux@gmx.de (Dieter Kiermaier)
Date: Thu, 29 Oct 2009 10:36:40 +0200
Subject: marvell kirkwood / openrd-base kernel freeze on bootup with PICe->PCI
	bridge
Message-ID: <200910290936.40397.dk-arm-linux@gmx.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi all,

I've got a strange problem with latest git kernel. If I connect a PCIe->PCI bridge (without any connected PCI device!)
to my openrd-base board the kernel freezes during bootup if PCI is enabled:
Filename 'uImage_openrd'.
Load address: 0x800000
Loading: #################################################################
         #################################################################
         #################################################################
         #################################################################
         #################################################################
         #################################################################
         #################################################################
         ############
done
Bytes transferred = 2390120 (247868 hex)
## Booting kernel from Legacy Image at 00800000 ...
   Image Name:   Linux-2.6.32-rc5-00081-g964fe08-
   Image Type:   ARM Linux Kernel Image (uncompressed)
   Data Size:    2390056 Bytes =  2.3 MB
   Load Address: 00008000
   Entry Point:  00008000
   Verifying Checksum ... OK
   Loading Kernel Image ... OK
OK

Starting kernel ...

Uncompressing Linux............................................................................................................................................................ done.

The PCIe->PCI bridge is a Marvell 88SB2211 evaluation board and I expect it works well - at least it does in all other environments I've tested so far.

If I insert eg a PCIe Network card everything works fine.
With former marvell 2.6.22 stock kernel / u-boot kernel boots up and I can access PCI card connected after my bridge.

Please can someone help me to track this down?
Some tips how to debug such a problem using openocd are very welcome, too!
I'm completely lost in space :(



Many thanks,
Dieter
