From: jic23@cam.ac.uk (Jonathan Cameron)
Date: Wed, 06 Apr 2011 15:11:01 +0100
Subject: gpio.h interaction with other headers issue on pxa (maybe arm in
	general?)
Message-ID: <4D9C7475.6080900@cam.ac.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear all,

Doing a quick test build of drivers staging/iio/gyro/adis16080_core.c for pxa27x
gave me:

  CHECK   drivers/staging/iio/gyro/adis16080_core.c
/home/jic23/src/kernel/onwards/arch/arm/include/asm/cputype.h:57:48: error: Expected ; at end of declaration
/home/jic23/src/kernel/onwards/arch/arm/include/asm/cputype.h:57:48: error: got read_cpuid_id
/home/jic23/src/kernel/onwards/arch/arm/include/asm/cputype.h:59:16: error: Expected ; at the end of type declaration
/home/jic23/src/kernel/onwards/arch/arm/include/asm/cputype.h:59:16: error: got }
/home/jic23/src/kernel/onwards/arch/arm/include/asm/cputype.h:60:1: error: Expected ; at the end of type declaration
/home/jic23/src/kernel/onwards/arch/arm/include/asm/cputype.h:60:1: error: got }
/home/jic23/src/kernel/onwards/arch/arm/include/asm/cputype.h:64:16: error: Expected ; at the end of type declaration
/home/jic23/src/kernel/onwards/arch/arm/include/asm/cputype.h:64:16: error: got }
/home/jic23/src/kernel/onwards/arch/arm/include/asm/cputype.h:65:1: error: Expected ; at the end of type declaration
/home/jic23/src/kernel/onwards/arch/arm/include/asm/cputype.h:65:1: error: got }
/home/jic23/src/kernel/onwards/arch/arm/include/asm/cputype.h:69:16: error: Expected ; at the end of type declaration
/home/jic23/src/kernel/onwards/arch/arm/include/asm/cputype.h:69:16: error: got }
/home/jic23/src/kernel/onwards/arch/arm/include/asm/cputype.h:70:1: error: Expected ; at the end of type declaration
/home/jic23/src/kernel/onwards/arch/arm/include/asm/cputype.h:70:1: error: got }
/home/jic23/src/kernel/onwards/arch/arm/include/asm/cputype.h:59:16: error: undefined identifier '__val'

Simply reorder the header includes to have kernel.h before gpio.h fixes this, but is it an indication of
an underlying problem that should have a more general fix?

Give the driver was developed on blackfin, I'm guessing it's fine for them and given
Greg's testing on x86 and friends I guess it is fine there as well.

Jonathan
