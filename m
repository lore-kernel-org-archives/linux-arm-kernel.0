From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 06 Jan 2017 12:43:32 +0100
Subject: [PATCH V5 1/3] ARM64 LPC: Indirect ISA port IO introduced
In-Reply-To: <CACVXFVNS9n9_ty8y3CyqfRaLitqDKdk1mMOrQHM-enOgJtUBeQ@mail.gmail.com>
References: <1478576829-112707-1-git-send-email-yuanzhichang@hisilicon.com>
 <1478576829-112707-2-git-send-email-yuanzhichang@hisilicon.com>
 <CACVXFVNS9n9_ty8y3CyqfRaLitqDKdk1mMOrQHM-enOgJtUBeQ@mail.gmail.com>
Message-ID: <4069640.PHLdmY3C6P@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday, December 22, 2016 4:15:57 PM CET Ming Lei wrote:
> ERROR: "inb" [drivers/watchdog/wdt_pci.ko] undefined!
> ERROR: "outb" [drivers/watchdog/wdt_pci.ko] undefined!
> ERROR: "outb" [drivers/watchdog/pcwd_pci.ko] undefined!
> ERROR: "inb" [drivers/watchdog/pcwd_pci.ko] undefined!
> ERROR: "outw" [drivers/video/vgastate.ko] undefined!
> ERROR: "outb" [drivers/video/vgastate.ko] undefined!
> ERROR: "inb" [drivers/video/vgastate.ko] undefined!
> ERROR: "outw" [drivers/video/fbdev/vt8623fb.ko] undefined!
> ERROR: "inb" [drivers/video/fbdev/vt8623fb.ko] undefined!
> ERROR: "outb" [drivers/video/fbdev/vt8623fb.ko] undefined!
> ERROR: "outw" [drivers/video/fbdev/tridentfb.ko] undefined!
> ERROR: "inb" [drivers/video/fbdev/tridentfb.ko] undefined!
> ERROR: "outb" [drivers/video/fbdev/tridentfb.ko] undefined!
> ERROR: "inb" [drivers/video/fbdev/tdfxfb.ko] undefined!
> 

In case you haven't figured it out by now, the new code is simply
missing a few "EXPORT_SYMBOL" lines.

	Arnd
