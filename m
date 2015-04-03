From: geert@linux-m68k.org (Geert Uytterhoeven)
Date: Fri, 3 Apr 2015 15:27:40 +0200
Subject: [PATCH/RFC 5/6] staging: board: Add support for devices with
 complex dependencies
In-Reply-To: <20150403125727.GT10964@mwanda>
References: <1428064923-24950-1-git-send-email-geert+renesas@glider.be>
 <1428064923-24950-6-git-send-email-geert+renesas@glider.be>
 <20150403125727.GT10964@mwanda>
Message-ID: <CAMuHMdVhX-MrFxeW5j98NLaQQtJ+DToxkz2Z1+SRSs7YF27RDw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Apr 3, 2015 at 2:57 PM, Dan Carpenter <dan.carpenter@oracle.com> wrote:
>> +     error = clk_register_clkdev(clk, bsc->con_id, bsc->dev_id);
>> +     if (error)
>> +             pr_err("Failed to register clock %s (%d)\n", bsc->clk, error);
>> +             return error;
>
> Missing curly braces.  Also it's weird that don't we need a clk_put()
> on the error patch as well as the success path?

Thanks!

So it worked only by accident: with the new per-user struct clk instances
clk_put() must not be called if clk_register_clkdev() succeeded.

Will call clk_put() only if it failed.

>> +
>> +     clk_put(clk);
>> +     return 0;

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
