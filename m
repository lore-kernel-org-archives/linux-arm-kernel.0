From: ricardo.crudo@gmail.com (Ricardo Crudo)
Date: Fri, 14 Mar 2014 12:57:28 -0300
Subject: Enable neon float hardware support
In-Reply-To: <CAPjqk-JL+GSHc08dz=Fi7eLSX_W9hpj9JwWHO1AQxLuBTCrqmw@mail.gmail.com>
References: <CAPjqk-JL+GSHc08dz=Fi7eLSX_W9hpj9JwWHO1AQxLuBTCrqmw@mail.gmail.com>
Message-ID: <CAPjqk-Jf9qXbzWynuUU+qV4-EMd7GFvDNAQFsoQoUP6KNa=Ahg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

I'm working on an embedded linux audio device with Allwinner A10/A20
cpu. For this device is very important use the neon cpu resource.
I've some questions about kernel and toolchains.

1. To use the neon I need to build the kernel using any particular
option or apply any patch?
2. I need to build the linux kernel using arm-linux-gnueabi-xxx or
arm-linux-gnueabihf-xxx toolchain? What's the difference?
3. the gcc option -mfloat-abi=hard is applicable to my situation?
4. There is any difference use -mfpu='neon' with arm-linux-gnueabi-xxx
or arm-linux-gnueabihf-xxx?

Currently, to build my application, I'm using the following gcc flags:
-O3 -ffast-math -march=armv7 -mtune=cortex-a8 -mfpu='neon'
-funsafe-math-optimizations

I'd like to hear some opinions about this, Is this a good setup?
What's the risk using -funsafe-math-optimizations?

Remarks:
* application here is a program that process audio algorithm
* currently I'm using a cubieboard 1/2 running a arch linux distro
from archlinuxarm.org

Regards,
Ricardo
