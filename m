From: geert@linux-m68k.org (Geert Uytterhoeven)
Date: Sun, 15 Nov 2015 10:06:07 +0100
Subject: [PATCH 1/3] mtd: create a partition type device tree binding
In-Reply-To: <CAL_JsqL2F3p7qBPbOiGytVyzF_aNLWbrCT0mAX1WZo6SxE3JoA@mail.gmail.com>
References: <1446123152-22666-1-git-send-email-linus.walleij@linaro.org>
 <20151029162908.GA13275@localhost>
 <CACRpkdYS5Jf8UC2K0bNdEQZDjTeZZx44Uu-kkof+9E=4Ny0oDg@mail.gmail.com>
 <20151030175145.GF13239@google.com>
 <CAL_JsqL2F3p7qBPbOiGytVyzF_aNLWbrCT0mAX1WZo6SxE3JoA@mail.gmail.com>
Message-ID: <CAMuHMdVBdnjH0xQoMY7yT6Q-Z4bnukWgjBcWNYzhhNpO6263Rg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Nov 6, 2015 at 3:13 PM, Rob Herring <robh@kernel.org> wrote:
> On Fri, Oct 30, 2015 at 12:51 PM, Brian Norris
> <computersforpeace@gmail.com> wrote:
>> On Fri, Oct 30, 2015 at 03:00:57PM +0100, Linus Walleij wrote:
>>> On Thu, Oct 29, 2015 at 5:29 PM, Brian Norris
>>> <computersforpeace@gmail.com> wrote:
>>>
>>> >> +Required properties:
>>> >> +- partition-type : the type of partition. Only one type can be specified.
>>> >
>>> > You're supporting this as a list property (for future expansion,
>>> > presumably), so I can only assume the "only one type" is referring to
>>> > the number of different parsers available currently, not the behavior of
>>> > the property itself?
>>>
>>> I was thinking that it would not be a list actually.

Why not? It is (was) not uncommon to have multiple partition table types on
hard disks (e.g. bsd disklabel and msdos and/or amiga rdb).

>>> The reason being that if you're anyways going to the trouble of
>>> specifying exactly what partition type is going to be used, you're
>>> not really interested in specifying a few different ones, you know
>>> exactly what type it is going to be.
>>
>> OK, that makes sense. I think it's still *possible* that a board might
>> have the option of more than one partition parser, and so they might
>> just include both in the DTS, but that seems unlikely and so it makes
>> sense not to (over)engineer for it before it's needed. Anyway, your
>> binding can easily be expanded in the future if needed.
>
> Since we now have partitions contained in a sub node, how about using
> compatible for that sub node instead.

And "compatible" supports a list of multiple values.

BTW, this means it also (can) becomes more generic. Will it be applicable
to other block devices (e.g. hard disks), too?
Integration with block/partitions?

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
