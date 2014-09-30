From: geert@linux-m68k.org (Geert Uytterhoeven)
Date: Tue, 30 Sep 2014 15:28:23 +0200
Subject: [PATCH v5 2/3] net: Add Keystone NetCP ethernet driver
In-Reply-To: <063D6719AE5E284EB5DD2968C1650D6D174A1012@AcuExch.aculab.com>
References: <1411667317-1163-1-git-send-email-santosh.shilimkar@ti.com>
 <1411667317-1163-3-git-send-email-santosh.shilimkar@ti.com>
 <20140929.155200.2231132602322345812.davem@davemloft.net>
 <063D6719AE5E284EB5DD2968C1650D6D174A1012@AcuExch.aculab.com>
Message-ID: <CAMuHMdXe2H4qfX4X4GDzJSgoWzu-BrvRL6KoZagepY1GYEA4Ag@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Sep 30, 2014 at 3:09 PM, David Laight <David.Laight@aculab.com> wrote:
>> > +static inline int gbe_phy_link_status(struct gbe_slave *slave)
>> > +{
>> > +   if (!slave->phy)
>> > +           return 1;
>> > +
>> > +   if (slave->phy->link)
>> > +           return 1;
>> > +
>> > +   return 0;
>> > +}
>>
>> Please use 'bool' as the return type and return 'true' or 'false'.
>
> That function body could also be just:
>         return !slave->phy && slave->phy->link;
> which might be more readable if directly coded.

return !slave->phy || slave->phy->link;

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
