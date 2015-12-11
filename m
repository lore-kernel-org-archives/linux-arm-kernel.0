From: geert@linux-m68k.org (Geert Uytterhoeven)
Date: Fri, 11 Dec 2015 10:40:16 +0100
Subject: [PATCH/RFC 04/19] ARM: shmobile: r8a7793: add iic(b) to device
 tree
In-Reply-To: <1449802376-11301-5-git-send-email-horms+renesas@verge.net.au>
References: <1449802376-11301-1-git-send-email-horms+renesas@verge.net.au>
 <1449802376-11301-5-git-send-email-horms+renesas@verge.net.au>
Message-ID: <CAMuHMdWyHHV-QOXc-7g0XjWvWbhb8RcKkX+NTvA1HMngpM1sPQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Simon,

On Fri, Dec 11, 2015 at 3:52 AM, Simon Horman
<horms+renesas@verge.net.au> wrote:
> Instantiate iic(b) controllers in r8a7793 device tree.
>
> Based on similar work for the r8a7791 and r8a7791 by Wolfram Sang.
>
> Cc: Wolfram Sang <wsa@sang-engineering.com>
> Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
>
> ---
> The out-of order aliasing of iic to i2c is as per the documentation.
> This differs from the scheme in use in the dtsi files for
> other R-Car SoCs.
>
> It would be nice to harmonise this somehow but I'm unsure of the backwards
> compatibility issues.
>
> For reference those aliases are:

> * r8a7791:
>   - i2c0 = &i2c0;
>   - i2c1 = &i2c1;
>   - i2c2 = &i2c2;
>   - i2c3 = &i2c3;
>   - i2c4 = &i2c4;
>   - i2c5 = &i2c5;
>   - i2c6 = &i2c6;
>   - i2c7 = &i2c7;
>   - i2c8 = &i2c8;
>
>   Notes:
>   - i2c is used in place of iic and it is my understanding that
>     i2c6 is iic0, i2c7 is iic1 and i2c8 is iic3.
>   - iic3 is not present on this SoC

ii2c is not present

>   - Documentation makes note of (v1.02, table 12.2.1).

Which document is this exactly?

>     They are the same as those used in this patch for the r8a7793

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
