From: geert@linux-m68k.org (Geert Uytterhoeven)
Date: Tue, 11 Mar 2014 20:15:04 +0100
Subject: [PATCH] ARM: shmobile: compile drivers/sh for
 CONFIG_ARCH_SHMOBILE_MULTI
In-Reply-To: <1566590.zu3Q3sqakp@avalon>
References: <1389707776-23306-1-git-send-email-ben.dooks@codethink.co.uk>
 <1482392.XFeYNLvUZH@avalon> <20140120155643.GQ17314@sirena.org.uk>
 <1566590.zu3Q3sqakp@avalon>
Message-ID: <CAMuHMdU4v9=BxTKk-=z4GE55KCuxuPry93OtGrTOzJ5ke8WT=g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Laurent,

On Mon, Jan 20, 2014 at 11:52 PM, Laurent Pinchart
<laurent.pinchart@ideasonboard.com> wrote:
> On Monday 20 January 2014 15:56:43 Mark Brown wrote:
>> On Mon, Jan 20, 2014 at 04:48:10PM +0100, Laurent Pinchart wrote:
>> > The problem isn't as simple as it seems, and more advanced implementations
>> > that would allow listing clocks that should be managed automatically (or
>> > the other way around) would also add another level of complexity. The
>> > required information is platform-dependent, but we currently don't
>> > express it as such in DT.
>>
>> Well, the set of clocks an IP requires will tend to be the same - it's
>> normally just that integrators may have done things like tie them together
>> or decide to spread confusion by renaming them.
>
> That's the problem :-) How should the runtime PM core be given the list of
> clocks it needs to manage ? That information needs to come from somewhere.

Stirring the pot again...

Which clocks a device needs is expressed in DT with CCF.
In the simple case, the runtime PM core can just control them based on
device use.
In the complex case, the driver can regain control using its own pm
callbacks, right?

Probably I'm still missing something, as I haven't had enough exposure to
runtime PM and CCF ;-)

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
