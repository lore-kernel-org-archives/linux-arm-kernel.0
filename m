From: andy.shevchenko@gmail.com (Andy Shevchenko)
Date: Mon, 22 Jan 2018 16:49:51 +0200
Subject: [PATCH] pinctrl: pinctrl-single: Fix pcs_request_gpio() when
 bits_per_mux != 0
In-Reply-To: <1516575793-30526-1-git-send-email-david@lechnology.com>
References: <1516575793-30526-1-git-send-email-david@lechnology.com>
Message-ID: <CAHp75VdkShHhxL+3PyaPEC2Dyr8aWoEH8CQk+bEJ2WD4i6ojHg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jan 22, 2018 at 1:03 AM, David Lechner <david@lechnology.com> wrote:
> This fixes pcs_request_gpio() in the pinctrl-single driver when
> bits_per_mux != 0. It appears this was overlooked when the multiple
> pins per register feature was added.
>
> Fixes: 4e7e8017a80e ("pinctrl: pinctrl-single: enhance to configure
> multiple pins of different modules")

One line?

> +                       byte_num = (pcs->bits_per_pin * pin) / BITS_PER_BYTE;
> +                       offset = (byte_num / mux_bytes) * mux_bytes;
> +                       pin_shift = pin % (pcs->width / pcs->bits_per_pin) *
> +                                   pcs->bits_per_pin;

Sounds like playing around pretty well defined macro and functions,
e.g. DIV_ROUND_UP(), round_up().

-- 
With Best Regards,
Andy Shevchenko
