From: linus.walleij@linaro.org (Linus Walleij)
Date: Sun, 16 Oct 2011 12:56:22 +0200
Subject: [PATCH] ARM: ep93xx: bring back missing <mach/gpio.h>
In-Reply-To: <1318752486-970-1-git-send-email-mika.westerberg@iki.fi>
References: <1318752486-970-1-git-send-email-mika.westerberg@iki.fi>
Message-ID: <CAKnu2Mr74c9G79Dopq62agv5F2OUD7zT+1TgeEyjn=AjJv5bpg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2011/10/16 Mika Westerberg <mika.westerberg@iki.fi>:

> Change bd5f12a2476 (ARM: 7042/3: mach-ep93xx: break out GPIO driver specifics)
> accidentally removed the ep93xx <mach/gpio.h> instead of making it an empty
> file. This causes compilation to fail:

OMG git is too smart on me I suspect :-/

The original patch here:
http://www.arm.linux.org.uk/developer/patches/viewpatch.php?id=7042/3

Does not delete it AFAICT:
diff --git a/arch/arm/mach-ep93xx/include/mach/gpio.h
b/arch/arm/mach-ep93xx/include/mach/gpio.h
index 76c68fa..e69de29 100644
--- a/arch/arm/mach-ep93xx/include/mach/gpio.h
+++ b/arch/arm/mach-ep93xx/include/mach/gpio.h

If it was deleting it, second line should say /dev/null should it not?

Is this because git won't create files with zero content during checkout
or so :-/

Or because git am takes zero length as deletion?

Help, I need to figure out how not to do the same stupid mistake again...

Acked-by.

Yours,
Linus Walleij
