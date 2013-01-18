From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 18 Jan 2013 08:47:50 +0000
Subject: [PATCH v2 2/2] ARM: uncompress debug support for multiplatform
 build
In-Reply-To: <1358477120-19673-1-git-send-email-shawn.guo@linaro.org>
References: <1358436119-30808-3-git-send-email-shawn.guo@linaro.org>
 <1358477120-19673-1-git-send-email-shawn.guo@linaro.org>
Message-ID: <201301180847.50913.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 18 January 2013, Shawn Guo wrote:
> +ENTRY(putc)
> +       addruart r1, r2, r3
> +       waituart r3, r1
> +       senduart r0, r1
> +       busyuart r3, r1
> +       mov      pc, lr
> +ENDPROC(putc)

Ah, so it actually worked? I was expecting at least some part of
my code to be wrong ;-) My assembler skills are very much
lacking and I had not tried it.

Upon closer inspection, it seems that the CR/LF logic from
the printascii function is not here, and it probably should be.

I also saw that some similar code is already present in
arch/arm/boot/compressed/head.S as a local version of putc,
maybe that can be combined with this rather than adding a new
file.

	Arnd
