From: mohun106@gmail.com (Radha Mohan)
Date: Tue, 13 Oct 2015 23:12:18 -0700
Subject: arm64 memcpy_{from|to}io and memset_io
Message-ID: <CAC8NTUUgQk0CNaBj2p=38U+yyFWE6ZQkSgs1KA=MviQg3g_X=Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,
I see that the memcpy_{from|to}io and memset_io are not in an
optimized manner. I guess these are just a copy from
arch/arm/include/asm/io.h where there could be problem with different
implementations.
Do we still need these to be byte write ?
Can we convert them to use a more optimized memcpy ?

We have some drivers, like framebuffer driver using these functions
and end up writing byte-by-byte. This causes a very poor VGA
performance.

Let me know if there are any concerns to convert these to use memcpy.
I can send a patch.

regards,
Radha Mohan
