From: mikpe@it.uu.se (Mikael Pettersson)
Date: Thu, 14 Jan 2010 00:30:20 +0100
Subject: Question: __ARM_EABI__
In-Reply-To: <BD79186B4FD85F4B8E60E381CAEE190902089CA8@mi8nycmail19.Mi8.com>
References: <BD79186B4FD85F4B8E60E381CAEE190902089C63@mi8nycmail19.Mi8.com>
	<19278.11469.95923.629825@pilspetsen.it.uu.se>
	<BD79186B4FD85F4B8E60E381CAEE190902089C95@mi8nycmail19.Mi8.com>
	<20100113210503.GG28292@n2100.arm.linux.org.uk>
	<BD79186B4FD85F4B8E60E381CAEE190902089C9B@mi8nycmail19.Mi8.com>
	<20100113211725.GH28292@n2100.arm.linux.org.uk>
	<BD79186B4FD85F4B8E60E381CAEE190902089CA8@mi8nycmail19.Mi8.com>
Message-ID: <19278.22412.764361.337948@pilspetsen.it.uu.se>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

H Hartley Sweeten writes:
 > But, I'm actually getting the wrong message.
 > 
 > Alessandro Rubini pointed out that I could use "-dM" in the preprocessor
 > to dump the defines.  My toolchain has these particular defines:
 > 
 > #define __GNUC__ 4
 > #define __GNUC_MINOR__ 3
 > #define __ARM_EABI__ 1
 > 
 > 4.3.2 might not support unwinding correctly but I still should not get
 > any of the warning messages.
 > 
 > Confused...

Indeed, I dug out my old gcc-4.3 eabi cross-gcc and it produced no such
warnings, with or without CONFIG_ARM_UNWIND.

make ARCH=arm mrproper, reinstate your .config, make V=1 and show us
the complete command-line and messages for the compilation of unwind.c.

Do you have CONFIG_AEABI=y in your .config?
