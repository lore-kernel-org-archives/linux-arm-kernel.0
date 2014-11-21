From: geert@linux-m68k.org (Geert Uytterhoeven)
Date: Fri, 21 Nov 2014 10:04:47 +0100
Subject: [PATCH v4 1/2] ARM: keystone: pm: switch to use generic pm domains
In-Reply-To: <546E0970.5090301@ti.com>
References: <1415631557-22897-1-git-send-email-grygorii.strashko@ti.com>
 <1709760.E0jX3Myv0h@wuerfel> <546C7FDD.7030906@ti.com>
 <2900095.WIocOu7ue2@wuerfel>
 <CAPDyKFqeZ3YU2OEN4tCOdcQ0pAho67Q8U_eCEOroG9aS0mp+-Q@mail.gmail.com>
 <546DD87B.3080806@ti.com>
 <CAPDyKFrBhZyqozM98_4pPdW0EMFt5W6VX1X7cz6Z=yNhW4vYTA@mail.gmail.com>
 <CAMuHMdWtHT7QX3Kpa-GCLa49ToGODwjnNVgfxDzJzcM-FU1ffg@mail.gmail.com>
 <546E0970.5090301@ti.com>
Message-ID: <CAMuHMdWLU7seisSE3bgDFi4-0qKpyLHJfZ1GO37ZUMVFwNV9gg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Nov 20, 2014 at 4:32 PM, Grygorii Strashko
<grygorii.strashko@ti.com> wrote:
>> That's indeed the tricky part.
>>
>> On shmobile, we just use the "NULL" clock, i.e. the first clock, for historical
>> reasons.
>>
>> Using clock-names (e.g. "fck" and "pm") will conflict with existing bindings
>> for devices that already mandate specific clock names.
>>
>> As the clock being a "PM" clock is a property of the clock provider
>> (at last on shmobile), I originally came up with not handling it in DT,
>> but advertising it in the clock provider driver:
>>
>>>> - first Geert Uytterhoeven proposed to use CLK_RUNTIME_PM there
>>>>    https://lkml.org/lkml/2014/11/6/319
>
> As I mentioned previously I don't like it, because in many cases one driver is used for
> all/set_of clocks which support gating function. As result, some sort of tables will
> need to be created and maintained in code by these drivers per each SoC
> (or even per each SoC revision) for identification that clock is "PM clock".

That depends. On shmobile, there's a separate hardware module for those
clocks, hence all clocks provided by drivers/clk/shmobile/clk-mstp.c are "PM"
clocks.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
