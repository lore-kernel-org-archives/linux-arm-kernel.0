From: mattia.jona@gmail.com (Mattia Jona-Lasinio)
Date: Sat, 24 Jul 2010 12:31:53 +0200
Subject: Introducing the LCD-Linux project
In-Reply-To: <AANLkTilKJx18oyc815DhKfPv-Yjdv8UmfJ4WTDxZxaab@mail.gmail.com>
References: <AANLkTikitTGpiE5Oe_P5a4f2OCOnlB9j_LVm5CQhQIno@mail.gmail.com>
	<20100722122111.4cf4ca2f@lxorguk.ukuu.org.uk>
	<AANLkTilKJx18oyc815DhKfPv-Yjdv8UmfJ4WTDxZxaab@mail.gmail.com>
Message-ID: <AANLkTimnxkn5eLRHOAs6v_TJE0hM5=dQ3OWaiQP6tPJd@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jul 22, 2010 at 1:38 PM, Geert Uytterhoeven
<geert@linux-m68k.org> wrote:
> On Thu, Jul 22, 2010 at 13:21, Alan Cox <alan@lxorguk.ukuu.org.uk> wrote:
>> Why do we need a VT102 as well ?
>>
>> If you use the existing kernel console interfaces then you don't need to
>> worry about vt102 v console or having two terminal emulations running.
>
> Indeed, the kernel already has the console abstraction.

I agree on that and at the beginning I was thinking about writing a
framebuffer driver as well.
But on the way I realized that the standard Linux console was not
exactly what I needed.
I wanted to implement some escape sequences typical of the world of
small displays, like
the generation of custom characters, backward writing or backlighting.
This would have required
a change in the standard console, and I personally wouldn't dare to do
it. I thought it would have been
better to have a separate console emulation dedicated to these small devices.
Moreover I wanted something that COULD be used as a console but not
necessarily, that is
something that could run happily in the presence of a normal monitor
as well. It seems to me, but I may be
wrong, that through the standard console system only the current
visible console is actually updated
while other consoles are just "software" updated. An external LCD
would therefore be updated
only when you "switch" to it, so it would not be possible to use it to
display diagnostics.

> I wrote a LCD console driver (for a HD44780 connected to the parallel
> port) using
> the standard console abstraction several years ago. As it used the standard
> console abstraction, it supported multiple virtual consoles and co-operated with
> the VGA text console out-of-the-box. Just use ALT-Fx to switch between different
> VCs on the LCD or on VGA.

I also wrote a very simple (and experimental) LCD console driver
using the standard Linux console and LCD-Linux. More or less it works, though
the "update" problem that I mentioned is still an issue.

> Having a bigger virtual console where the LCD follows the region
> surrounding the cursor
> is indeed a nice extension to have.

That's another point which would have required a modification at the
console level
and, as I said, I didn't want to touch at the standard console. But we
can think about
it! ;)

Regards,

Mattia
