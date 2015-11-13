From: geert@linux-m68k.org (Geert Uytterhoeven)
Date: Fri, 13 Nov 2015 21:15:49 +0100
Subject: [PATCH 2/2] [media] include/media: move platform driver headers
 to a separate dir
In-Reply-To: <20151113171341.0972ef7a@recife.lan>
References: <413d2bb0b813a7e62867de7a94b0ab61e16cb1cb.1447261977.git.mchehab@osg.samsung.com>
 <09e182fa61a7122356b790cd2a4a7f622dabb4ce.1447261977.git.mchehab@osg.samsung.com>
 <4220808.QEkJDXYE1T@wuerfel> <20151113171341.0972ef7a@recife.lan>
Message-ID: <CAMuHMdUBmMOHZ1mo3S5_K0B=0YywA3Xm5VyZ1Kk1UOsLUt_fPQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Nov 13, 2015 at 8:13 PM, Mauro Carvalho Chehab
<mchehab@osg.samsung.com> wrote:
>> I think the latter should go into include/linux/platform_data/media/*.h instead.
>
> Agreed.
>
> Please see the enclosed patch:
>
>
> Subject: [PATCH] [media] include/media: move platform driver headers to a
>  separate dirs
>
> Let's not mix headers used by the core with those headers that
> are needed by some specific platform drivers or by platform data.
>
> This patch was made via this script:
>         mkdir include/media/platform mkdir include/media/platform_data
>         (cd include/media/; git mv $(grep -l platform_data *.h|grep -v v4l2)

I think include/linux/platform_data/media/, like Arnd suggested,
would be better.

Then we can make it a common goal to empty include/linux/platform_data/ ;-)

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
