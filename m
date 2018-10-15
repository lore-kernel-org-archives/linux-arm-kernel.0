From: linus.walleij@linaro.org (Linus Walleij)
Date: Mon, 15 Oct 2018 16:27:10 +0200
Subject: [RFT PATCH] mmc: pwrseq_simple: Fix incorrect handling of GPIO
 bitmap
In-Reply-To: <20181012190901.1243-1-jmkrzyszt@gmail.com>
References: <20180925192433.1377-1-jmkrzyszt@gmail.com>
 <20181012190901.1243-1-jmkrzyszt@gmail.com>
Message-ID: <CACRpkdYB1Wz8VC3aDpB_4KQcdbE-_Fy48zF_idKDM0pqiOEnXg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Oct 12, 2018 at 9:07 PM Janusz Krzysztofik <jmkrzyszt@gmail.com> wrote:

> Commit b9762bebc633 ("gpiolib: Pass bitmaps, not integer arrays, to
> get/set array") changed the way GPIO values are passed to
> gpiod_get/set_array_value() and friends.  The new code introduced into
> mmc_pwrseq_simple_set_gpios_value() incorrectly interpretes the 'value'
> argument as a bitmap of GPIO values and assigns it directly to the
> 'values' bitmap variable passed to gpiod_set_array_value_cansleep()
> instead of filling that bitmap with bits equal to the 'value' argument.
> As a result, only member 0 of the array is handled correctly.
>
> Moreover, wrong assumption is taken about the 'values' bitmap size not
> exceding the number of bits of the 'value' argument type.
>
> Fix it.
>
> Signed-off-by: Janusz Krzysztofik <jmkrzyszt@gmail.com>

Patch applied with Ulf's and Marek's tags!

Yours,
Linus Walleij
