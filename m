From: paul@pwsan.com (Paul Walmsley)
Date: Thu, 2 Dec 2010 00:23:57 -0700 (MST)
Subject: OMAP2+: PM/serial: hold console semaphore while OMAP UARTs are
	disabled
In-Reply-To: <AANLkTik5cRQPodAYtacTD5EdQYnDbvGgOoNfNfHuW+fq@mail.gmail.com>
References: <alpine.DEB.2.00.1011241646310.20215@utopia.booyaka.com>
	<AANLkTina+O1GgMgS0qDKix=d4HOtT1fFrCotTuCCxACv@mail.gmail.com>
	<alpine.DEB.2.00.1011251017390.20215@utopia.booyaka.com>
	<AANLkTik5cRQPodAYtacTD5EdQYnDbvGgOoNfNfHuW+fq@mail.gmail.com>
Message-ID: <alpine.DEB.2.00.1012020022390.2515@utopia.booyaka.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Jean

On Thu, 25 Nov 2010, Jean Pihet wrote:

> On Thu, Nov 25, 2010 at 6:35 PM, Paul Walmsley <paul@pwsan.com> wrote:
> > On Thu, 25 Nov 2010, Jean Pihet wrote:
> >> On Thu, Nov 25, 2010 at 12:49 AM, Paul Walmsley <paul@pwsan.com> wrote:
> >> >
> >> > The console semaphore must be held while the OMAP UART devices are
> >> > disabled, lest a console write cause an ARM abort (and a kernel crash)
> >> > when the underlying console device is inaccessible. ?These crashes
> >> > only occur when the console is on one of the OMAP internal serial
> >> > ports.
> >> This does not fix the issue for me on Beagle (console on ttyO2).
> >>
> >> Doing:
> >> ? / # echo 5 > /sys/devices/platform/omap/omap-hsuart.0/sleep_timeout
> >> ? / # echo 5 > /sys/devices/platform/omap/omap-hsuart.1/sleep_timeout
> >> ? / # echo 5 > /sys/devices/platform/omap/omap-hsuart.2/sleep_timeout
> >> and waiting 5 seconds hangs the console.
> >
> > By the way, you write that the above situation "hangs the console." ?Is it
> > just the case that the console dies and the rest of the system is still
> > alive, or does the whole system crash?
> The console hangs, the rest of the system still runs.

Just out of curiosity, if you send a few breaks to the OMAP over serial, 
does that cause the console to pay attention again?  CTRL-A F in minicom.


- Paul
