From: gilles.chanteperdrix@xenomai.org (Gilles Chanteperdrix)
Date: Wed, 30 Sep 2009 22:50:50 +0200
Subject: Build failure of atmel_serial in 2.6.32-rc1.
Message-ID: <4AC3C4AA.7090404@xenomai.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Hi,

I have just tried to build 2.6.32-rc1 for AT91 with CodeSourcery 2009q1,
and the build fails at:

BUILD_BUG_ON(!is_power_of_2(ATMEL_SERIAL_RINGSIZE));

file drivers/serial/atmel_serial.c in atmel_serial_probe(). The error
message being:
drivers/serial/atmel_serial.c: In function 'atmel_serial_probe':
drivers/serial/atmel_serial.c:1534: error: bit-field '<anonymous>' width
not an integer constant

Replacing the BUILD_BUG_ON with a BUG_ON results in a runnable kernel,
so ATMEL_SERIAL_RINGSIZE really is a power of 2.

Regards.

-- 
					    Gilles.
