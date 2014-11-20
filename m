From: geert@linux-m68k.org (Geert Uytterhoeven)
Date: Thu, 20 Nov 2014 10:19:15 +0100
Subject: [GIT PULL] Third Round of Renesas ARM Based Soc Updates for v3.19
In-Reply-To: <3299155.X2xrgWZ6OL@wuerfel>
References: <cover.1415841454.git.horms+renesas@verge.net.au>
 <201411192216.27740.arnd@arndb.de>
 <CAMuHMdWGnx9D4BJR3C0b=iuEKP_AN+JORiOHX+c-MkqcURAjtg@mail.gmail.com>
 <3299155.X2xrgWZ6OL@wuerfel>
Message-ID: <CAMuHMdXr7QgaGFg8tiDNTLnsTero2_RGZ-Vv4czALmN82aBzRA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd,

On Thu, Nov 20, 2014 at 10:04 AM, Arnd Bergmann <arnd@arndb.de> wrote:
> On Thursday 20 November 2014 08:56:10 Geert Uytterhoeven wrote:
>> > Please have a look at drivers/power/restart for how other platforms do
>> > this. You probably need to add a device node for whatever IP block
>> > holds the reset register and then have a driver. What exactly this
>> > driver should look like depends of course on what other registers are
>> > part of this block.
>>
>> I agree. Thanks for reminding us.
>>
>> The IP block is the system-controller, which is also used for PM domain
>> control. So I'll take care of it.
>
> Is it just the pm-domain driver and the system reset that needs to
> access this block? If yes, then the best option would be to register
> the reset handler from the pm-domain driver, otherwise I think you
> should have a syscon device node that gets shared between all drivers
> using this device.

Just PM domains, reset, and wake-up factors.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
