From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Mon, 7 Jan 2013 12:26:13 +0100
Subject: [PATCH 1/4] arm: mvebu: limit OpenBlocks AX3-4 to 1 GB of RAM
In-Reply-To: <20130107110712.GT3392@lunn.ch>
References: <1357315498-4570-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <1357315498-4570-2-git-send-email-thomas.petazzoni@free-electrons.com>
 <50E710CB.8070007@lunn.ch> <20130104183139.20492204@skate>
 <50E71356.3030203@lunn.ch> <20130104190345.460151d1@skate>
 <50E9EE7A.1080301@free-electrons.com>
 <20130106235312.0839a879@skate> <20130107094747.GR3392@lunn.ch>
 <20130107110712.GT3392@lunn.ch>
Message-ID: <20130107122613.64f4ace5@skate>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Andrew Lunn,

On Mon, 7 Jan 2013 12:07:12 +0100, Andrew Lunn wrote:

> BootROM 1.15
> Booting from NOR flash
> DDR3 Training Sequence - Ver 2.5.DDR3 Training Sequence - Registered
> DIMM WL - BootROM: Image checksum verification PASSED
>  ** LOADER **
> 
> 
> U-Boot 2009.08 (Jul 27 2012 - 18:23:11)
> Plat'Home version: 1.1.1 (Base: Marvell BSP  2.2.3 NQ)
> 
> Do you have the same version?

BootROM 1.15
Booting from NOR flash
DDR3 Training Sequence - Ver 2.5.DDR3 Training Sequence - Registered
DIMM WL - SKIP BootROM: Image checksum verification PASSED
 ** LOADER **


U-Boot 2009.08 (Jul 27 2012 - 18:23:11)
Plat'Home version: 1.1.1 (Base: Marvell BSP  2.2.3 NQ)

Seems like we do have the same version.

> I'm tftpbooting:
> 
> setenv bootargs root=/dev/ram console=ttyS0,115200 earlyprintk ;
> tftpboot 0x80000000 openblocks-dev; bootm
> 
> My image contain the kernel and a buildroot rootfs included within the
> kernel image and DT is appended. I load it to address 0x80000000,
> which puts it at the beginning of CS 3:

Image is also with an initramfs + appended DTB. My boot command is:

tftp 1000000 192.168.0.14:uImage.armada-xp-openblocks-ax3-4; bootm

So I'm loading to a different address than you.

Thomas
-- 
Thomas Petazzoni, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
