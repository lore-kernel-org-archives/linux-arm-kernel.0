From: linus.walleij@linaro.org (Linus Walleij)
Date: Thu, 23 Mar 2017 13:47:20 +0100
Subject: [PATCH 4/6] gpio: gemini: rename to match Faraday IP
In-Reply-To: <CACmBeS23APp1=+0Cypyx9OujhekUTF7w5QbwE_9zt_go3GdUPw@mail.gmail.com>
References: <20170312232818.26304-1-linus.walleij@linaro.org>
 <20170312232818.26304-4-linus.walleij@linaro.org>
 <CACmBeS2OC6X_Rb5qaVEGMY4mPyHwnib-=pm-g=+73J6ZSRDgLw@mail.gmail.com>
 <CACRpkda0TpcUsEW6wiHzhueSckz_WTfbDgpixdgCNvodHDmpyw@mail.gmail.com>
 <CACmBeS23APp1=+0Cypyx9OujhekUTF7w5QbwE_9zt_go3GdUPw@mail.gmail.com>
Message-ID: <CACRpkdY0Nj19KgYXfs5GZQrbxSJ-6zZkdo+bYo7Ss_Qo7EgP_Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Mar 22, 2017 at 11:21 AM, Jonas Jensen <jonas.jensen@gmail.com> wrote:
> On 22 March 2017 at 09:42, Linus Walleij <linus.walleij@linaro.org> wrote:

>> Nice! Have you tested my new GPIO character device tools from
>> tools/gpio/* in the kernel tree?
>
> I had not and thanks for pointing that out, lsgpio lists all available
> gpios (though most of them are unnamed), and gpio-hammer successfully
> toggled buzzer on/off.

Nice.

> GPIO chip: gpiochip0, "FTGPIO010", 32 GPIO lines
>         line  0: unnamed unused [output]
>         line  1: unnamed unused [output]
>         line  2: unnamed unused [output]
>         line  3: unnamed unused [output]

BTW you can name all the "unnamed" lines by using
gpio-line-names in the gpio node of the device tree, c.f.
commit 3a1689ea752436917c5ce4487527ed6c444630ee

>         line 24: unnamed unused [output]
>         line 25: unnamed unused
>         line 26: unnamed unused
>         line 27: unnamed "ready-led" [kernel output active-low]
(...)
>
> ./gpio-hammer -n gpiochip0 -o 24
> Hammer lines [24] on gpiochip0, initial states: [0]
> [|] [24: 1]
>
> ./gpio-hammer -n gpiochip0 -o 27
> Failed to issue GET LINEHANDLE IOCTL (-16)

So finally when the kernel is using a GPIO line you can't use it
from userspace at the same time. -16 is -EBUSY.

Yours,
Linus Walleij
