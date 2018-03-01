From: geert@linux-m68k.org (Geert Uytterhoeven)
Date: Thu, 1 Mar 2018 12:54:46 +0100
Subject: [PATCH] soc: rockchip: power-domain: remove PM clocks
In-Reply-To: <CAPDyKFrN0t6Jr-gAuU4_OHEvYap2fRiaUbZC5E7sAGAQOUQjjw@mail.gmail.com>
References: <20180228111113.13639-1-jeffy.chen@rock-chips.com>
 <CAMuHMdWLL9CxmxSLsqs1QX0dDHVhp4NrW4Me2EZaZE_bJ330bA@mail.gmail.com>
 <CAAFQd5CLXUwH6jTq9ZOpbYt9-Xx-+Kgj-Nk+KujS=Y=qLByc9Q@mail.gmail.com>
 <CAMuHMdWdVdregCRh17Jfa92csBruZvLzAK+M8uajif0BSJTcaw@mail.gmail.com>
 <CAAFQd5CpA_M821cMDtiEiWxw_rL--hQy6T6imz_c+fSi3gH9zw@mail.gmail.com>
 <CAMuHMdVVDiuv7bpdC0X95Xy9dSK_TfjW5RvSekVym9Q02798Fg@mail.gmail.com>
 <CAAFQd5C0GZ9C-pAqAdpuyxaF2xthLPY62a921nmABTbbmYtBmQ@mail.gmail.com>
 <5A977638.8010506@rock-chips.com>
 <CAMuHMdU9PFAXwo+1Z7Baw1fanst9yFKZ3ohoSTiQiMKTaYMVVw@mail.gmail.com>
 <CAPDyKFq_hwao0hZCYmO-VrsW3vDJJboa1RG-TMLRQRgbt+YhpQ@mail.gmail.com>
 <CAMuHMdWg1y3Ragb9nYY12whZhUn8w0a4aOOR31LSNXa37NbfXg@mail.gmail.com>
 <CAPDyKFrN0t6Jr-gAuU4_OHEvYap2fRiaUbZC5E7sAGAQOUQjjw@mail.gmail.com>
Message-ID: <CAMuHMdVXWj8GCAFy66usSj-z_zeWgY3SyxvpenUKf9cc-ZWK5w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Ulf,

On Thu, Mar 1, 2018 at 12:22 PM, Ulf Hansson <ulf.hansson@linaro.org> wrote:
> On 1 March 2018 at 11:37, Geert Uytterhoeven <geert@linux-m68k.org> wrote:
>> On Thu, Mar 1, 2018 at 11:18 AM, Ulf Hansson <ulf.hansson@linaro.org> wrote:
>>> Another problem with the PM clk is, more exactly with
>>> pm_clk_suspend|resume(), that those invokes only clk_enable|disable().
>>> pm_clk_suspend|resume() can't call clk_prepare|unprepare(), because we
>>> don't know if we running in atomic context when those are executed.
>>> Potentially this means leaving the clocks ungated - all the time.
>>>
>>> I have though about how to fix the above, several times, but I always
>>> ends up with thinking that's it more easy, to let the driver deal with
>>> the clocks, as then the problem goes away.
>>
>> There's a similar issue with powering on/off power areas.
>
> I don't follow. Can you elaborate?

I intended to comment on the atomic context (or not).
But I think I was wrong, and PM domain drivers do busy loops instead
of sleeps.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
