From: santosh.shilimkar@ti.com (Shilimkar, Santosh)
Date: Mon, 28 May 2012 14:55:07 +0530
Subject: [RFC PATCH 02/11] ARM: OMAP: expose control.h to mach area
In-Reply-To: <1337934361-1606-3-git-send-email-eduardo.valentin@ti.com>
References: <1337934361-1606-1-git-send-email-eduardo.valentin@ti.com>
 <1337934361-1606-3-git-send-email-eduardo.valentin@ti.com>
Message-ID: <CAMQu2gxbkFCtkK+NCVksC82-R4SAKKtK2w=zNbrNi9a10s1t1Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, May 25, 2012 at 1:55 PM, Eduardo Valentin
<eduardo.valentin@ti.com> wrote:
> This patch exposes the definitions under control.h to
> drivers outside the machine code.
>
> Signed-off-by: Eduardo Valentin <eduardo.valentin@ti.com>
> ---
After second thought, this complete header movement needs to avoided.
Drivers should not anyway include something like <mach/control.h>

May be split the control.h header file data into ..
- defines used by mach-omap2/* files which can remain in "control.h"
in existing location.
- common functions/defines used across drivers/*, mach-omap2/*,
plat-omap/*, should
go to include/linux/omap_control.h
- Driver specific defines like thermal, usb etc, should go to
respective drivers file.

What do you think ?

Regards
santosh
