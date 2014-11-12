From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 12 Nov 2014 11:33:04 +0100
Subject: [arm-soc:next/soc 1/1] WARNING: vmlinux.o(.text+0x730e38):
 Section mismatch in reference from the function brcmstb_gisb_arb_probe() to
 the function .init.text:hook_fault_code()
In-Reply-To: <CACRpkdZ6AovXUVvvdyeUczVpGfkexLHMOaA+F3eiBG=W8gtBGg@mail.gmail.com>
References: <22844091.DkblDJL9Ph@wuerfel>
 <CACRpkdZ6AovXUVvvdyeUczVpGfkexLHMOaA+F3eiBG=W8gtBGg@mail.gmail.com>
Message-ID: <70798892.n4gYya0yuK@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 12 November 2014 11:27:20 Linus Walleij wrote:
> On Tue, Nov 11, 2014 at 11:52 PM, Arnd Bergmann <arnd@arndb.de> wrote:
> 
> > The problem was introduced by f1bee783dd37 "bus: brcmstb_gisb: register the
> > fault code hook", as hook_fault_code is an __init function and is now
> > called from a probe function.
> 
> I hope it's not my fault, it doesn't seem to have my name on it 

No, it's not. The reason that the build bot sent it to you is that you
fixed another problem that prevented the kernel from getting built, so
now it builds again and we see the new warning that was introduced while
the kernel didn't build.

	Arnd
