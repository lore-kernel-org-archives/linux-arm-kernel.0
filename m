From: linus.walleij@linaro.org (Linus Walleij)
Date: Wed, 12 Nov 2014 11:27:20 +0100
Subject: [arm-soc:next/soc 1/1] WARNING: vmlinux.o(.text+0x730e38):
 Section mismatch in reference from the function brcmstb_gisb_arb_probe() to
 the function .init.text:hook_fault_code()
In-Reply-To: <22844091.DkblDJL9Ph@wuerfel>
References: <22844091.DkblDJL9Ph@wuerfel>
Message-ID: <CACRpkdZ6AovXUVvvdyeUczVpGfkexLHMOaA+F3eiBG=W8gtBGg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Nov 11, 2014 at 11:52 PM, Arnd Bergmann <arnd@arndb.de> wrote:

> The problem was introduced by f1bee783dd37 "bus: brcmstb_gisb: register the
> fault code hook", as hook_fault_code is an __init function and is now
> called from a probe function.

I hope it's not my fault, it doesn't seem to have my name on it :)

Linus
