From: geert@linux-m68k.org (Geert Uytterhoeven)
Date: Wed, 8 Jan 2014 11:23:16 +0100
Subject: [PATCH 3/4] thermal: rcar: Add missing clock handling
In-Reply-To: <87ha9fxoua.wl%kuninori.morimoto.gx@gmail.com>
References: <1389121036-3555-1-git-send-email-geert@linux-m68k.org>
 <1389121036-3555-4-git-send-email-geert@linux-m68k.org>
 <87ha9fxoua.wl%kuninori.morimoto.gx@gmail.com>
Message-ID: <CAMuHMdW+1yP2PqvLTc0tjyrnhGssvn_iK8mCO6u-++pjGYR9KQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jan 8, 2014 at 2:08 AM, Kuninori Morimoto
<kuninori.morimoto.gx@gmail.com> wrote:
>> +     common->clk = devm_clk_get(&pdev->dev, NULL);
>> +     if (IS_ERR(common->clk)) {
>> +             dev_err(&pdev->dev, "cannot get clock\n");
>> +             return PTR_ERR(common->clk);
>> +     }
>> +
>> +     ret = clk_prepare(common->clk);
>> +     if (ret < 0) {
>> +             dev_err(&pdev->dev, "unable to prepare clock\n");
>> +             return ret;
>> +     }
>> +
>> +     clk_enable(common->clk);
>> +
>>       pm_runtime_enable(dev);
>>       pm_runtime_get_sync(dev);
>
> And this patch seems strange for me.
> pm_runtime_xxx() is doing same things.
> If it didn't work, wrong place is not driver, clock side ?

That's an interesting observation...

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
