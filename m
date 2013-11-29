From: javier@dowhile0.org (Javier Martinez Canillas)
Date: Fri, 29 Nov 2013 10:00:38 +0100
Subject: [PATCH 01/12 diet] ARM: OMAP2+: Remove legacy omap3 board-*.c
 files and make mach-omap2 DT only for booting
In-Reply-To: <CANOLnONmmRgDSfdObUii-FxwVOTo45WGX81Lend7QGWuqXWaZA@mail.gmail.com>
References: <1385424867-27243-1-git-send-email-tony@atomide.com>
 <20131126011744.GA26766@atomide.com>
 <CANOLnONmmRgDSfdObUii-FxwVOTo45WGX81Lend7QGWuqXWaZA@mail.gmail.com>
Message-ID: <CABxcv==5X91DTnUCOjZTpjKCVQzHquvL7o4+q0DsJ=LM80DORQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Grazvydas,

On Fri, Nov 29, 2013 at 12:57 AM, Grazvydas Ignotas <notasas@gmail.com> wrote:
> On Tue, Nov 26, 2013 at 3:17 AM, Tony Lindgren <tony@atomide.com> wrote:
>> We can now boot all mach-omap2 related boards using appended device
>> tree by creating a related .dts file with pretty much the same
>> functionality as booted in the legacy platform data mode.
>
> Not really the same, quite some drivers are still missing, and it
> makes pandora unusable :( . For example, SDIO variation of wl1251,
> that one is non-probeable and used to be "detected" by using
> MMC_QUIRK_NONSTD_SDIO quirk (see pandora_wl1251_init_card() in
> board-omap3pandora.c). Also there are at least pandora-backlight,
> twl4030_keypad and panel drivers that are not converted yet.
>
> Can pdata-quirks.c be used for SDIO wl1251 at least, as I have no idea
> how to express it using device tree?
>

Yes, pdata-quirks.c can be used to initialize any platform device that
does not have DT support yet and still needs platform data. Until we
add the proper bindings and get rid of it.

> --
> Gra?vydas
> --

Best regards,
Javier
