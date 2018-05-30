From: geert@linux-m68k.org (Geert Uytterhoeven)
Date: Wed, 30 May 2018 10:42:48 +0200
Subject: [PATCH v3 2/3] arm: shmobile: Add the R9A06G032 SMP enabler driver
In-Reply-To: <OSBPR01MB20546AE06422C9AD896F8F60D26C0@OSBPR01MB2054.jpnprd01.prod.outlook.com>
References: <1527157834-7747-1-git-send-email-michel.pollet@bp.renesas.com>
 <1527157834-7747-3-git-send-email-michel.pollet@bp.renesas.com>
 <CAMuHMdWv2ZRbX=k5+H_WfAeoQ4QsyQLU9iQ9TJ9OQ0fmwg0GOQ@mail.gmail.com>
 <OSBPR01MB20546AE06422C9AD896F8F60D26C0@OSBPR01MB2054.jpnprd01.prod.outlook.com>
Message-ID: <CAMuHMdUZ-sVE3z5nW30m3O5g4gB=TcQATDQ-Q5mdDsYX7c4ttQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Michel,

On Wed, May 30, 2018 at 10:19 AM, Michel Pollet
<michel.pollet@bp.renesas.com> wrote:
> On 25 May 2018 10:49, Geert wrote:
>> On Thu, May 24, 2018 at 12:30 PM, Michel Pollet
>> <michel.pollet@bp.renesas.com> wrote:
>> > The Renesas R9A06G032 second CA7 is parked in a ROM pen at boot time,
>> > it requires a special enable method to get it started.
>> >
>> > Signed-off-by: Michel Pollet <michel.pollet@bp.renesas.com>
>>
>> Thanks for your patch!
>>
>> >  arch/arm/mach-shmobile/smp-r9a06g032.c | 85
>> > ++++++++++++++++++++++++++++++++++
>>
>> I think you can safely call this driver smp-rzn1d.c, or smp-rzn1.c.
>> Source files are not covered by the stable DT ABI, and can be reordered later
>> at will.
>>
>> I expect you will just add more CPU_METHOD_OF_DECLARE() lines later
>> (perhaps with a little bit of extra code to handle deviations).
>
> Now I am completely confused -- you had me remove the mention of rzn1
> from everywhere it mattered to handle 'family' cases, and now you are
> telling me that in *this* case where there is not a single chance of that file
> covering another part and there's a clear cut case for it to be part specific
> .... I should call it rzn1?!?

Sorry for confusing you.
There's a difference between stable DT ABI and (non-existing) kernel stable ABI.
A driver that handles multiple SoCs can be named after the SoC family.

I agree this one is a bit special, as only RZ/N1D has the dual Cortex A7
(RZ/N1S has a single A7, RZ/N1L has no A7), so for now[*] there's no need
to use it on anything but r9a06g032 aka RZ/N1D.

> I'd like consistency -- I *thought* I had a consistent naming scheme before,
> now I've moved to your part specific one (under duress), I'd rather stick to
> something that is consistent and keep everything as r9a06g032 now.

OK for me. Driver names can be changed any time.

[*] Until e.g. a quad A7 arrives :-)
    Perhaps this can also be used to enable the A7s on both RZ/N1D and
    RZ/N1S when running Linux on the Cortex M3?

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
