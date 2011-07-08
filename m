From: linus.walleij@linaro.org (Linus Walleij)
Date: Fri, 8 Jul 2011 15:12:06 +0200
Subject: [PATCH 46/52] ARM: mach-u300: convert boot_params to atag_offset
In-Reply-To: <1309920457-21913-46-git-send-email-nicolas.pitre@linaro.org>
References: <1309920457-21913-1-git-send-email-nicolas.pitre@linaro.org>
	<1309920457-21913-46-git-send-email-nicolas.pitre@linaro.org>
Message-ID: <CAKnu2MrM-_sw70se==z8LO-ZO0eUbwqk9MhY3Co1ZErV=hOYUw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2011/7/6 Nicolas Pitre <nicolas.pitre@linaro.org>:

> Someone was smoking good stuff with CONFIG_MACH_U300_2MB_ALIGNMENT_FIX here...

Haha, it is a consequence of the PHYS_OFFSET having to align on a 2MB
boundary, whereas the actual physical memory was at an odd MB address.
We didn't really like the idea of loosing one megabyte of memory just to
please PHYSOFFSET, so hence this fix.

What we do is round memory upwards to closest 2MB boundary, then we
reserve the first MB. That's why we're having so much fun...

The reason why memory can be at an odd address is that we can
dynamically alter (at boot time) how many MB are reserved for the
accompanying modem CPU.

> Signed-off-by: Nicolas Pitre <nicolas.pitre@linaro.org>

Acked-by: Linus Walleij <linus.walleij@linaro.org>

Thanks,
Linus Walleij
