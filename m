From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Tue, 17 Jul 2012 15:32:55 +0200
Subject: Device tree.
In-Reply-To: <4030979.D58EjbuuB0@flexo>
References: <500552C9.4090107@codethink.co.uk>
 <500556CF.6030704@codethink.co.uk> <20120717142926.05c0c17f@skate>
 <4030979.D58EjbuuB0@flexo>
Message-ID: <20120717153255.2d171eac@skate>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Le Tue, 17 Jul 2012 14:41:35 +0200,
Florian Fainelli <florian@openwrt.org> a ?crit :

> > What I typically do is generate a zImage, do the appending, and then
> > generate the uImage manually with mkimage. But I agree it could be
> > useful to have a 'make uImage.myboard' target which would happen the
> > myboard.dtb before preparing the uImage.
> 
> Appending a given device tree blob to a zImage is something that
> should be solved outside of the kernel build imho.

Well, both PowerPC and Microblaze, and apparently C6X, have some sort
of <imageFormat>.<dtbName> make target:

$ make ARCH=microblaze help
[...]
  simpleImage.<dt> - ELF image with /boot/dts/<dt>.dts linked in
                   - stripped elf with fdt blob
  simpleImage.<dt>.unstrip - full ELF image with fdt blob

$ make ARCH=powerpc help
[...]
  cuImage.<dt>    - Backwards compatible U-Boot image for older
                    versions which do not support device trees
  dtbImage.<dt>   - zImage with an embedded device tree blob
  simpleImage.<dt> - Firmware independent image.
  treeImage.<dt>  - Support for older IBM 4xx firmware (not U-Boot)

$ make ARCH=c6x help
[...]
  dtbImage.<dt>   - ELF image with /boot/dts/<dt>.dts linked in
                  - stripped elf with fdt blob

Thomas
-- 
Thomas Petazzoni, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
