From: bhumirks@gmail.com (Bhumika Goyal)
Date: Sun, 12 Feb 2017 01:37:12 +0530
Subject: ERROR: Recursive variable `CC_OPTION_CFLAGS' references itself
 (eventually). Stop.
Message-ID: <CAOH+1jEOYjdxsO1uh63iXN+TiaLiSNLNk+VE2kmh+=ZnxD2hcA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

I ran the command "./make.cross ARCH=arm arch/arm/" on my 64 bit x86
machine but got the following error:

scripts/Kbuild.include:113: *** Recursive variable `CC_OPTION_CFLAGS'
references itself (eventually).  Stop.
make: *** [arch/arm/] Error 2

I commented out the line "CC_OPTION_CFLAGS = $(filter-out
$(GCC_PLUGINS_CFLAGS),$(KBUILD_CFLAGS))" in the scripts/Kbuild.include
file and the driver compiled.

Is this the only solution to make the compilation work? What is this
line signifying?

Thanks,
Bhumika
