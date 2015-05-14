From: aaro.koskinen@iki.fi (Aaro Koskinen)
Date: Fri, 15 May 2015 01:51:42 +0300
Subject: GCC 5.1 bug affecting ARM kernels
Message-ID: <20150514225142.GE609@fuloong-minipc.musicnaut.iki.fi>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

There is a code generation bug in GCC 5.1 that affects some ARM kernels:

	https://gcc.gnu.org/bugzilla/show_bug.cgi?id=65932

The bug report mentions arm926ej-s, and also some OMAP1 and 2 kernels
fail to boot (there is a crash after warnings about some bogus duplicate
sysfs files) unless they are compiled with -fno-ipa-sra.

A.
