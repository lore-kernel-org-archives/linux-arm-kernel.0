From: valentinrothberg@gmail.com (Valentin Rothberg)
Date: Mon, 18 May 2015 11:30:39 +0200
Subject: ARM: STM32: undefined ARMV7M_SYSTICK
Message-ID: <CAD3Xx4+0mgWskGcdJPv7wL9QctTwz1Hz4paoHjpgWKjGpeOA8g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Maxime,

your commit 9b799b78372c ("ARM: Add STM32 family machine") is in
today's linux-next tree (i.e., next-20150518) adding the following
Kconfig select:

+config ARCH_STM32
[...]
+       select ARMV7M_SYSTICK

ARMV7M_SYSTICK is not defined in Kconfig, so that the select turns out
to be a NOP.  Is there a patch queued somewhere that adds this Kconfig
option?

I detected this issue with scripts/checkkconfigsymbols.py by diffing
yesterday's and today's linux-next tree.  You can also use the script
to check specific commits for Kconfig related issues.

Kind regards,
 Valentin
