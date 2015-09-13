From: geert@linux-m68k.org (Geert Uytterhoeven)
Date: Sun, 13 Sep 2015 22:23:49 +0200
Subject: Build regressions/improvements in v4.3-rc1
In-Reply-To: <20150913151926.GA19850@roeck-us.net>
References: <1442134868-17607-1-git-send-email-geert@linux-m68k.org>
 <CAMuHMdV31w=aDD-=uUPOqW71xLpOnH1jWeQpH=6x=vxNSo94FQ@mail.gmail.com>
 <20150913151926.GA19850@roeck-us.net>
Message-ID: <CAMuHMdVGEDKFxD7wf6ZOAGiOByM5c0Awx-anLsYGLQHV1yJW+w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Sep 13, 2015 at 5:19 PM, Guenter Roeck <linux@roeck-us.net> wrote:
> On Sun, Sep 13, 2015 at 11:03:51AM +0200, Geert Uytterhoeven wrote:
>> On Sun, Sep 13, 2015 at 11:01 AM, Geert Uytterhoeven
>> <geert@linux-m68k.org> wrote:
>> > Below is the list of build error/warning regressions/improvements in
>> > v4.3-rc1[1] compared to v4.2[2].
>> >
> [ ... ]
>
>>
>> >   + /home/kisskb/slave/src/arch/powerpc/kvm/book3s_pr.c: error: 'last_sc' may be used uninitialized in this function [-Werror=uninitialized]:  => 1094:31
>>
>> powerpc-allyesconfig, powerpc-randconfig, powerpc-allmodconfig
>
> I think that only affects powerpc-randconfig.

Right, on powerpc-all{mod,yes}config it's just a build warning, not an error.

> arm64:allmodconfig:
>
> drivers/firmware/qcom_scm-32.c:196:4: error: expected string literal before ?__asmeq?
> drivers/firmware/qcom_scm-32.c:221:2: error: implicit declaration of function ?secure_flush_area?
> drivers/firmware/qcom_scm-32.c:239:2: error: implicit declaration of function ?outer_inv_range?
> drivers/firmware/qcom_scm-32.c:331:4: error: expected string literal before ?__asmeq?
> drivers/firmware/qcom_scm-32.c:361:4: error: expected string literal before ?__asmeq?

Time for kisskb to gain arm64 support?

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
