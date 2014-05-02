From: geert@linux-m68k.org (Geert Uytterhoeven)
Date: Fri, 2 May 2014 16:35:44 +0200
Subject: [PATCH/RFC 3/4] of/clk: Register clocks suitable for Runtime PM
 with the PM core
In-Reply-To: <CAPDyKFpTwPDu9afhOjhhQ2PKGFB+hWsp=mcaYTq8OvuGF7yT3Q@mail.gmail.com>
References: <1398334403-26181-1-git-send-email-geert+renesas@glider.be>
 <1398334403-26181-4-git-send-email-geert+renesas@glider.be>
 <CAPDyKFpTwPDu9afhOjhhQ2PKGFB+hWsp=mcaYTq8OvuGF7yT3Q@mail.gmail.com>
Message-ID: <CAMuHMdUGdfF8x58dz46VWNsC4X0cmFng39Z2xSO_pXYqn9u=HA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Ulf,

On Fri, May 2, 2014 at 10:56 AM, Ulf Hansson <ulf.hansson@linaro.org> wrote:
>> +static int of_clk_pm_runtime_suspend(struct device *dev)
>> +{
>> +       int ret;
>> +
>> +       ret = pm_generic_runtime_suspend(dev);
>> +       if (ret)
>> +               return ret;
>> +
>> +       ret = pm_clk_suspend(dev);
>
> What about slow clocks? Those aren't handled with pm_clk_suspend().

How are slow clocks handled?

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
