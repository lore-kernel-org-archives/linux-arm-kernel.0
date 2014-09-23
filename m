From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 23 Sep 2014 10:07:31 +0200
Subject: [PATCH] tty/serial: fix config dependencies for samsung serial
In-Reply-To: <CAM4voaky-zin8ikdkLBwpTKy13hz3iON8tmNsd55-kr8po8Qaw@mail.gmail.com>
References: <1409671320-7604-1-git-send-email-ch.naveen@samsung.com>
 <10202237.9vbtDF9MIQ@wuerfel>
 <CAM4voaky-zin8ikdkLBwpTKy13hz3iON8tmNsd55-kr8po8Qaw@mail.gmail.com>
Message-ID: <5903767.VzDJhUfQDI@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 23 September 2014 12:34:26 Abhilash Kesavan wrote:
> >>
> >> The SERIAL_SAMSUNG_UARTS_4 and SERIAL_SAMSUNG_UARTS config options are
> >> meaningful only if SERIAL_SAMSUNG is enabled. Hence the dependency
> >> rules were changed. I will repost this patch with better description.
> >
> > My point is that the options are used by both the uart driver and
> > the platform code, e.g. for the purpose of PM debugging which can
> > be enabled even when the serial-samsung driver is turned off.
> 
> I looked through the code and could find two references to these
> symbols in the platform-specific code: arch/arm/plat-samsung/init.c
> and arch/arm/mach-s3c64xx/irq-pm.c. The first one is being used to
> initialize the uart platform device in non-dt way while the second one
> saves and restores the uart irq masks for all channels across a
> suspend/resume cycle. Also, the save/restore will get bypassed in case
> CONFIG_SERIAL_SAMSUNG_UARTS is not defined. It does not look like
> either of these cases would cause any issue with the current patch,
> can you please help me understand the problem ?

It's possible that it works fine now, I just pointed out that we
had bugs in this area in the past, so it would be good if you can
add to the changelog a statement that you have checked that the
new patch does not cause problems here.

	Arnd
