From: geert@linux-m68k.org (Geert Uytterhoeven)
Date: Tue, 15 Dec 2015 09:01:45 +0100
Subject: [PATCH/RFC 0/7] ARM: dts: Add compatible property to "partitions"
 node
In-Reply-To: <CAN8TOE9O_egvFevRj3WaUcJd8GMFAAQcWLHMtKe1gwCR14zDPg@mail.gmail.com>
References: <1450120304-2760-1-git-send-email-geert+renesas@glider.be>
 <20151214194613.GA126731@google.com>
 <CAMuHMdW=wJEoi-+EWAKBjRwb+QFvk=iFur1yFqR=q0f4zwzb2Q@mail.gmail.com>
 <20151214214312.GA86857@google.com>
 <CAN8TOE9O_egvFevRj3WaUcJd8GMFAAQcWLHMtKe1gwCR14zDPg@mail.gmail.com>
Message-ID: <CAMuHMdWPL_c_YVjuTH+bsh_DgaquYSTcZu01nZO74ue9VyBeFw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Brian,

On Mon, Dec 14, 2015 at 10:45 PM, Brian Norris
<computersforpeace@gmail.com> wrote:
> + real linux-mtd mailing list
>
> On Mon, Dec 14, 2015 at 1:43 PM, Brian Norris
> <computersforpeace@gmail.com> wrote:
>> On Mon, Dec 14, 2015 at 10:20:19PM +0100, Geert Uytterhoeven wrote:
>>> On Mon, Dec 14, 2015 at 8:46 PM, Brian Norris
>>> <computersforpeace@gmail.com> wrote:
>>> > On Mon, Dec 14, 2015 at 08:11:37PM +0100, Geert Uytterhoeven wrote:
>>> >> As of commit e488ca9f8d4f62c2 ("doc: dt: mtd: partitions: add compatible
>>> >> property to "partitions" node"), the "partitions" subnode of an SPI
>>> >> FLASH device node must have a compatible property. The partitions are no
>>> >> longer detected if it is not present.
>>> >
>>> > For all patches:
>>> >
>>> > Acked-by: Brian Norris <computersforpeace@gmail.com>
>>> >
>>> >> I marked this series as "RFC", as the abovementioned commit is not yet
>>> >> upstream. Ideally, the users should be fixed first, to avoid breakage.
>>>
>>> It breaks bisectability in mainline.
>>
>> The files you are fixing are not converted in mainline yet, are they?

Sorry, too long after my morning coffee...
Yes, you're right, they won't be in mainline before v4.5-rc1.

When I noticed the problem, I didn't see the cause immediately, so I did a
bisect. Which didn't help much, as the problem only occurs when merging
l2-mtd/master...

>>> > I'd differ on the last sentence. It's more important to straighten out
>>> > the release features for 4.4 than to make sure that linux-next has
>>> > perfect DTS files. So I'll submit whenever ready :)
>>>
>>> If the DTS changes go in first, bisectability is preserved.

Scrap, they can't go in first...

>> Are you asking me to delay fixing the DT binding until 4.5, just because
>> your for-next branches can't be fixed? IOW, you want me to release the
>> bad DT binding for a whole cycle?

No, please don't delay it to 4.5.

But I'm afraid the for-next branches can't be fixed, as the DTS updates been in
arm-soc/for-next for a while. I don't think the arm-soc maintainers can be
bothered redoing all their merges, so we'll have to live with it...

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
