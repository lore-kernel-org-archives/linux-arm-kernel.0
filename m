From: linus.walleij@linaro.org (Linus Walleij)
Date: Tue, 23 Apr 2013 12:58:52 +0200
Subject: [PATCH] ARM: ux500: Supply a DTS file for the u8540 platform
In-Reply-To: <20130404072907.GB3004@gmail.com>
References: <1364908916-29803-1-git-send-email-lee.jones@linaro.org>
 <1364908916-29803-3-git-send-email-lee.jones@linaro.org>
 <CACRpkdafSvT5Xb=7sqnkRHcc4UKkVzr8jzThMgWn6459RDmKGw@mail.gmail.com>
 <20130404072907.GB3004@gmail.com>
Message-ID: <CACRpkdZWuw9O3-wr=g1AehZqmBR1YJ353w9ANfBTHhr5mRiwiw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Apr 4, 2013 at 9:29 AM, Lee Jones <lee.jones@linaro.org> wrote:

> This is a skeleton DTS file which only enables serial. Just using
> this simple file yields a terminal when booting u8540.
>
> Signed-off-by: Lee Jones <lee.jones@linaro.org>

Now, wait... this doesn't work.

> +/ {
> +  model = "ST-Ericsson U8540 platform with Device Tree";
> +  compatible = "st-ericsson,u8540";
> +
> +       memory {
> +              reg = <0x00000000 0x20000000>;
> +              };

Funny whitespace. Use tabs ...

> +       soc-u9500 {

Please rename this not just "soc"

> +                 uart at 80120000 {
> +                                       status = "okay";
> +                                              };
> +
> +               uart at 80121000 {
> +                               status = "okay";
> +                                      };
> +
> +               uart at 80007000 {
> +                               status = "okay";
> +                                      };
> +                                      };
> +};

The whitespace looks a bit funny compared to the
old patch, what happened here?

It also has the side effect that patch 5/9 does not
apply... By the way, since I already applied 4/9, please
squash 5/9 into this patch to avoid problems.

Finally, please patch arch/arm/boot/dts/Makefile
in the obvious way so that the DTB gets compiled.

Yours,
Linus Walleij
