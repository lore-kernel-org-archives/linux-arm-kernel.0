From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 19 Apr 2012 11:51:46 +0000
Subject: [PATCH 05/10] MXS: Add platform registration hooks for USB EHCI
In-Reply-To: <1334771194-18688-6-git-send-email-marex@denx.de>
References: <1334714869-19282-1-git-send-email-marex@denx.de>
 <1334771194-18688-1-git-send-email-marex@denx.de>
 <1334771194-18688-6-git-send-email-marex@denx.de>
Message-ID: <201204191151.46590.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 18 April 2012, Marek Vasut wrote:
>  arch/arm/mach-mxs/devices-mx28.h                |    4 ++
>  arch/arm/mach-mxs/devices/Kconfig               |    3 +
>  arch/arm/mach-mxs/devices/Makefile              |    1 +
>  arch/arm/mach-mxs/devices/platform-usb.c        |   78 +++++++++++++++++++++++
>  arch/arm/mach-mxs/include/mach/devices-common.h |    9 +++
>  5 files changed, 95 insertions(+)
>  create mode 100644 arch/arm/mach-mxs/devices/platform-usb.c

What's the state of the device tree support for mach-mxs now? Since we
allow booting at least the mx28evk with device tree now in -next, it
would be really nice if we didn't have to add this registration code
for non-DT platforms any more and just mandate that everyone who
wants to use USB on that board uses DT. Is that possible already
or are we missing too much other stuff?

	Arnd
