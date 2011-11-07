From: robert.jarzmik@free.fr (Robert Jarzmik)
Date: Mon, 07 Nov 2011 19:00:40 +0100
Subject: Arm bootloader choice
Message-ID: <87zkg7ak3b.fsf@free.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Hello everyone,

I have to choose a bootloader to flash on my board.
I'd like to have :
 - the bootloader able to read the kernel and initrd from the flash (a linux
 kernel driver is available)
 - the bootloader able to bootstrap the linux kernel (obviously)
 - optionnaly the bootloader able to output data on USB port
 - optionnaly and even better the bootloader to accept input on USB port to boot
 a "USB provided kernel"

The board is based on a PXA27x, the flash is a MSystems docg3.
The boot sequence would be :
 - PXA27x starts up
 - at memory 0 is the IPL from the docg3
 - IPL sets up RAM (refresh, etc ...), if comming out of suspend jump
 - IPL load SPL from docg3
 - SPL starts

The SPL we're talking about is where I want to fit the bootloader.

My questions are :
 - is there a bootloader capable of integrating kernel drivers ?
 - if there are many (RedBoot ? U-Boot ?), which one would you choose if you
 were me and why ?
 - as I might to have to adapt the booloader (add flash driver, ...), is there a
 simple way to test it, before I flash it to replace the former SPL, assuming I
 have a linux kernel booted and functionnal by another way (kexec ? other ?)

Thanks in advance for your advices.

Cheers.

-- 
Robert
