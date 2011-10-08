From: jbe@pengutronix.de (Juergen Beisert)
Date: Sat, 8 Oct 2011 20:15:16 +0200
Subject: Serieal console on Samsung S3C6410 ARM11 CPU (Was [ANNOUNCE]
	3.0.6-rt17)
In-Reply-To: <CAJuYYwSEvA+EHwyhgeZkBX+bB_e1cmFnC6YdEx-CdHzk8peyEw@mail.gmail.com>
References: <alpine.LFD.2.02.1110070046270.3240@ionos>
	<201110081326.58731.jbe@pengutronix.de>
	<CAJuYYwSEvA+EHwyhgeZkBX+bB_e1cmFnC6YdEx-CdHzk8peyEw@mail.gmail.com>
Message-ID: <201110082015.17128.jbe@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Thomas,

Thomas Abraham wrote:
> On 8 October 2011 16:56, Juergen Beisert <jbe@pengutronix.de> wrote:
> > Thomas Gleixner wrote:
> >> I'm pleased to announce the 3.0.6-rt17 release.
> >
> > I have no idea where to search, but when I'm using the 3.0.6-rt17 on my
> > Samsung S3C6410 ARM based system, the UART (serial console) does not work
> > as expected. Typing only one char at a time is okay. Typing two chars
> > immediately makes the system using 100 % CPU load and takes about 2
> > seconds to respond. It seems the interrupt handling is broken in the UART
> > driver, but I don't know how to fix it.
> >
> > This with a simple cursor up (one char to get the last command) and a
> > small pause to the next "ENTER" char:
> >
> > root at mini6410:~ cat /proc/interrupts | grep 18:
> > ?18: ? ?5739107 ?s3c-uart ?s3c6400-uart
> >
> > Same again:
> >
> > root at mini6410:~ cat /proc/interrupts | grep 18:
> > ?18: ? ?5739113 ?s3c-uart ?s3c6400-uart
> >
> > 6 interrupts seems reasonable.
> >
> > Now with cursor up and SPACE immediately, then a pause for ENTER:
> >
> > root at mini6410:~ cat /proc/interrupts | grep 18:
> > ?18: ? ?5923815 ?s3c-uart ?s3c6400-uart
> >
> > 184702 interrupts looks strange.
>
> Just curious, do you have the following two commits?
>
> serial: samsung: Add unified interrupt handler for s3c64xx and later SoC's
> ARM: SAMSUNG: Remove uart irq handling from platform code

Are they part of the current 3.0.6 vanilla kernel? I'm only using the vanilla 
3.0.6 with rt17 on my target.

jbe

-- 
Pengutronix e.K.                              | Juergen Beisert             |
Linux Solutions for Science and Industry      | http://www.pengutronix.de/  |
