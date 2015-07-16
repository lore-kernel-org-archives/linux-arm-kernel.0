From: notasas@gmail.com (Grazvydas Ignotas)
Date: Thu, 16 Jul 2015 17:13:49 +0300
Subject: [PATCH 2/2] ARM: OMAP2+: Remove legacy booting support for Pandora
In-Reply-To: <1437047951-22300-3-git-send-email-tony@atomide.com>
References: <1437047951-22300-1-git-send-email-tony@atomide.com>
 <1437047951-22300-3-git-send-email-tony@atomide.com>
Message-ID: <CANOLnOPQHOY5Up8+uKQn-JTK4zN=iK+owSN2KjhJGNFLVzN9yQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Thu, Jul 16, 2015 at 2:59 PM, Tony Lindgren <tony@atomide.com> wrote:
> We've been moving all omap2+ based systems to boot in device tree only
> mode for a few years now. Only omap3 has legacy booting support
> remaining. Most omap3 boards already have related arch/arm/boot/*.dts*
> files for booting with device tree.
>
> This board has support for device tree based booting, and we've been
> printing warnings about the legacy booting being deprecated for a
> few merge cycles now. Let's attempt to remove the legacy booting
> for it.
>
> The reason for removing the legacy booting support now rather than
> later is we can simply revert this patch if necessary if we run
> into some unexpected issues that are not trivial to fix for the
> device tree based booting.

It seems we lose wifi, backlight, audio and usb host mainline support
with this as pandora's .dts currently lacks all that stuff.
That said I'm not aware of any mainline users (everyone seems to be on
our "vendor" kernel), so maybe we can add those later.

>
> Cc: Signed-off-by: Grazvydas Ignotas <notasas@gmail.com>

I have not signed this off...

> Signed-off-by: Tony Lindgren <tony@atomide.com>
> ---
>  arch/arm/mach-omap2/Makefile             |   1 -
>  arch/arm/mach-omap2/board-omap3pandora.c | 633 -------------------------------
>  2 files changed, 634 deletions(-)
>  delete mode 100644 arch/arm/mach-omap2/board-omap3pandora.c
>


Gra?vydas
