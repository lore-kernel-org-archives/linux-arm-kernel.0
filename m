From: geert@linux-m68k.org (Geert Uytterhoeven)
Date: Thu, 10 Aug 2017 10:25:32 +0200
Subject: [PATCH] ARM:dts:armadillo800eva: Add console parametters
In-Reply-To: <87o9rnyhhh.wl%kuninori.morimoto.gx@renesas.com>
References: <1502027702-4366-1-git-send-email-phucduc.bui@gmail.com>
 <1502027702-4366-2-git-send-email-phucduc.bui@gmail.com>
 <20170807075920.GD7175@verge.net.au>
 <CAABR9nHUuSw7m6BCBxDs28YtppHxwHNQR5f06H0n8xcXKx7gCw@mail.gmail.com>
 <87o9rnyhhh.wl%kuninori.morimoto.gx@renesas.com>
Message-ID: <CAMuHMdWoCd85ROYjTn5Q023Re+sYW+B4TRRvZBt9bLBAkNHMbQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Morimoto-san, Phuc-san,

On Thu, Aug 10, 2017 at 10:12 AM, Kuninori Morimoto
<kuninori.morimoto.gx@renesas.com> wrote:
>>     >       chosen {
>>     > -             bootargs = "earlyprintk ignore_loglevel root=/dev/nfs ip=dhcp rw";
>>     > +             bootargs = "console=tty0 console=ttySC0,115200 earlyprintk
>>     > +                             ignore_loglevel root=/dev/nfs ip=dhcp rw";
>>     >               stdout-path = "serial0:115200n8";
>>     >       };
>>
>>     Hi,
>>
>>     this feels wrong. My understanding is that stdout-path should be enough
>>     to get the console.
> (snip)
>> Thank you for your comment.
>> Before creating this patch, I have a patch reference of you and Geert.
>> https://patchwork.kernel.org/patch/5184001/
>
> I think he want to say here is that it needs "console=" which
> is indicated by Geert on https://patchwork.kernel.org/patch/5184001/
>
>         "Note that we have to keep the "console=ttySC1" parameter in
>         chosen/bootargs, ..."

        "... else we only get console messages on tty0, and because
        this DTS is shared between legacy and multi-platform."

That was needed at the time of commit 2c32622c3f3f9c7e ("ARM:
shmobile: armadillo800eva dts: Add chosen/stdout-path").

Due to generic DT/console updates later, the "console=" parameters were
no longer needed, cfr. commit 1403e38b829acdad ("ARM: dts: armadillo800eva:
Update console parameters").

> I don't have armadillo800eva anymore, so I can't test this patch.
> But according to Phuc-san, there is not command prompt after boot
> without this patch.

I'm quite sure I do get console output on both ttyS0 and tty0 with the current
kernel (can't test right now due to board farm move/restructuring).

For a userspace prompt, I guess Phuc-san uses /dev/console as the console
device in e.g. /etc/inittab (or an equivalent)? If you want a prompt on tty0,
you better specify /dev/tty0 instead of /dev/console.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
