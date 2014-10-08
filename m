From: dianders@google.com (Doug Anderson)
Date: Wed, 8 Oct 2014 08:29:16 -0700
Subject: [PATCH] ARM: dts: fix MMC2 regulators for Exynos5420 Arndale Octa
 board
In-Reply-To: <1998495.eXa2FjeVGo@wuerfel>
References: <2750153.I3nVqzmXTP@amdc1032> <3871564.7PhRGhHd6U@wuerfel>
 <CAPDyKFowKK2UbwQ3uUmX7yzgsyFVxQ+sKb=dh+a0_T5K4agYGw@mail.gmail.com>
 <1998495.eXa2FjeVGo@wuerfel>
Message-ID: <CAD=FV=VB_eK9pSmmTBRHoQmkORweHzT-OFaMWA6haFYnQuQaUQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Wed, Oct 8, 2014 at 8:20 AM, Arnd Bergmann <arnd@arndb.de> wrote:
> Why does it cause a regression though? Does this mean you are breaking
> any boot with an old DT file and a new kernel? That would be very
> bad, the driver is supposed to keep working with an existing dtb.

The old dts file specified completely the wrong regulator.  It
happened that the old code didn't really care, but when the code was
fixed to care then things broke.  If we need to keep old dts files
working then the most sensible place to do it would be in a "fixup old
broken device trees" stage somewhere in kernel boot.

-Doug
