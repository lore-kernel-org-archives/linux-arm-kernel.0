From: geert@linux-m68k.org (Geert Uytterhoeven)
Date: Wed, 6 Apr 2016 08:51:50 +0200
Subject: [RFC6 PATCH v6 00/21] ILP32 for ARM64
In-Reply-To: <1459894127-17698-1-git-send-email-ynorov@caviumnetworks.com>
References: <1459894127-17698-1-git-send-email-ynorov@caviumnetworks.com>
Message-ID: <CAMuHMdUUkaYVZ3-Jh6o1b++R=yFBg7siQt+A+TqqXRSa953CAw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Yuri,

On Wed, Apr 6, 2016 at 12:08 AM, Yury Norov <ynorov@caviumnetworks.com> wrote:
> This version is rebased on kernel v4.6-rc2, and has fixes in signal subsystem.
> It works with updated glibc [1] (though very draft), and tested with LTP.
>
> It was tested on QEMU and ThunderX machines. No major difference found.
> This is RFC because ILP32 is not tested in big-endian mode.
>
>  v3: https://lkml.org/lkml/2014/9/3/704
>  v4: https://lkml.org/lkml/2015/4/13/691
>  v5: https://lkml.org/lkml/2015/9/29/911
>
>  v6:
>  - time_t, __kenel_off_t and other types turned to be 32-bit
>    for compatibility reasons (after v5 discussion);

Reading this sparked my interest, so I went to the links above...

What makes you think these "applications that can?t readily be migrated to LP64
because they were written assuming an ILP32 data model, and that will never
become suitable for a LP64 data model and will remain locked into ILP32
operating environments" are more likely to be fixed for y2038 later, than for
LP64 now?

We're already closer to the (future) y2038 than to the (past) introduction of
LP64...

These unfixable legacy applications have been spreading through x32 to
the shiny new arm64 server architecture (does ppc64el also have an ILP32 mode,
or is it planned)? Lots of resources are spent on maintaining the status quo,
instead of on fixing the real problems.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
