From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 03 Sep 2014 12:56:02 +0200
Subject: [PATCH] tty/serial: fix config dependencies for samsung serial
In-Reply-To: <CAHfPSqAn5gHjDA75Zf1W5=GH9_W+X6+4oc9rDK7CqeSoF3DURw@mail.gmail.com>
References: <1409671320-7604-1-git-send-email-ch.naveen@samsung.com>
 <3749760.naNt3fHoTI@wuerfel>
 <CAHfPSqAn5gHjDA75Zf1W5=GH9_W+X6+4oc9rDK7CqeSoF3DURw@mail.gmail.com>
Message-ID: <10202237.9vbtDF9MIQ@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 03 September 2014 13:51:56 Naveen Krishna Ch wrote:
> On 2 September 2014 21:16, Arnd Bergmann <arnd@arndb.de> wrote:
> > On Tuesday 02 September 2014 20:52:00 Naveen Krishna Chatradhi wrote:
> >> Make the config symbols SERIAL_SAMSUNG_UARTS_4 and
> >> SERIAL_SAMSUNG_UARTS depend on SERIAL_SAMSUNG rather than
> >> PLAT_SAMSUNG.
> >
> > Please always describe why you are doing a change. This patch
> > seems really pointless.
> 
> The SERIAL_SAMSUNG_UARTS_4 and SERIAL_SAMSUNG_UARTS config options are
> meaningful only if SERIAL_SAMSUNG is enabled. Hence the dependency
> rules were changed. I will repost this patch with better description.

My point is that the options are used by both the uart driver and
the platform code, e.g. for the purpose of PM debugging which can
be enabled even when the serial-samsung driver is turned off.

> >>  config SERIAL_SAMSUNG_UARTS_4
> >>         bool
> >> -       depends on PLAT_SAMSUNG
> >> +       depends on SERIAL_SAMSUNG
> >>         default y if !(CPU_S3C2410 || CPU_S3C2412 || CPU_S3C2440 || CPU_S3C2442)
> >>         help
> >>           Internal node for the common case of 4 Samsung compatible UARTs
> >>
> >>  config SERIAL_SAMSUNG_UARTS
> >>         int
> >> -       depends on PLAT_SAMSUNG
> >> +       depends on SERIAL_SAMSUNG
> >>         default 4 if SERIAL_SAMSUNG_UARTS_4 || CPU_S3C2416
> >>         default 3
> >>         help
> >>
> >
> > Have you checked that it still builds on all samsung platforms when
> > SERIAL_SAMSUNG is disabled? We have had build errors in this area
> > in the past.
> 
> Yes, it builds for other Samsung platforms.

Ok.

	Arnd
