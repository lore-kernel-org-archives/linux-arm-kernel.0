From: notasas@gmail.com (Grazvydas Ignotas)
Date: Fri, 29 Nov 2013 01:57:58 +0200
Subject: [PATCH 01/12 diet] ARM: OMAP2+: Remove legacy omap3 board-*.c
 files and make mach-omap2 DT only for booting
In-Reply-To: <20131126011744.GA26766@atomide.com>
References: <1385424867-27243-1-git-send-email-tony@atomide.com>
 <20131126011744.GA26766@atomide.com>
Message-ID: <CANOLnONmmRgDSfdObUii-FxwVOTo45WGX81Lend7QGWuqXWaZA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Nov 26, 2013 at 3:17 AM, Tony Lindgren <tony@atomide.com> wrote:
> We can now boot all mach-omap2 related boards using appended device
> tree by creating a related .dts file with pretty much the same
> functionality as booted in the legacy platform data mode.

Not really the same, quite some drivers are still missing, and it
makes pandora unusable :( . For example, SDIO variation of wl1251,
that one is non-probeable and used to be "detected" by using
MMC_QUIRK_NONSTD_SDIO quirk (see pandora_wl1251_init_card() in
board-omap3pandora.c). Also there are at least pandora-backlight,
twl4030_keypad and panel drivers that are not converted yet.

Can pdata-quirks.c be used for SDIO wl1251 at least, as I have no idea
how to express it using device tree?

--
Gra?vydas
