From: geert@linux-m68k.org (Geert Uytterhoeven)
Date: Wed, 13 Aug 2014 10:46:54 +0200
Subject: [PATCH 1/4] simplefb: formalize pseudo palette handling
In-Reply-To: <CANq1E4ShhaUMT3MpAei4sgo7Nr-jHfD+TpF8dzAVbn58Feroiw@mail.gmail.com>
References: <1407914239-12054-1-git-send-email-libv@skynet.be>
 <1407914239-12054-2-git-send-email-libv@skynet.be>
 <CANq1E4ShhaUMT3MpAei4sgo7Nr-jHfD+TpF8dzAVbn58Feroiw@mail.gmail.com>
Message-ID: <CAMuHMdVROkKvW1VYWbOtecO9sQAudtgS-mJtZb5ZLUCMaZdGAA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Aug 13, 2014 at 9:25 AM, David Herrmann <dh.herrmann@gmail.com> wrote:
>> @@ -225,7 +234,7 @@ static int simplefb_probe(struct platform_device *pdev)
>>                 framebuffer_release(info);
>>                 return -ENODEV;
>>         }
>> -       info->pseudo_palette = (void *)(info + 1);
>> +       info->pseudo_palette = (void *) par->palette;
>
> I think coding-style is this (i.e., no whitespace):
>     info->pseudo_palette = (void*)par->palette;

<casts-are-evil>
Is this cast even needed?
</casts-are-evil>

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
