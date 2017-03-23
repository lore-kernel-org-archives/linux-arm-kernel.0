From: linus.walleij@linaro.org (Linus Walleij)
Date: Thu, 23 Mar 2017 14:41:53 +0100
Subject: [PATCH 4/4] tty/serial: sh-sci: remove uneeded IS_ERR_OR_NULL
 calls
In-Reply-To: <20170323123437.uqdwhfmmsjke3f7s@pengutronix.de>
References: <CAMuHMdWv-xs12UqutEtXJGR8qqgx6DeDhkKvvYhhyW+XTVsUNQ@mail.gmail.com>
 <CAMuHMdXGn35bEsJKnUi5o3AytL4AJN2fBfoB79v5W-jOVFQx6g@mail.gmail.com>
 <20170320103113.tpveoq2onzrwmkdt@pengutronix.de>
 <CAMuHMdWbwA+3UGVnHYJOs26vTj13Yn+s4B8tE9kyy25JcjyZGg@mail.gmail.com>
 <20170320110718.e44s2gip36m75bqj@pengutronix.de>
 <CACRpkdZy_uguiKfSH-0gdanjr-xkwxoANTx6Fb2VwsvzRwcPRA@mail.gmail.com>
 <20170323101045.u3uigdu5xfwjmjc7@pengutronix.de>
 <CAMuHMdWDUzwUqrchbhh-TkE3J9Xg4TrwTF6HreikUcNNTf_ozQ@mail.gmail.com>
 <20170323111106.7ogh6g2oa3m4cqc6@pengutronix.de>
 <CAMuHMdUWybAZXc2RbGMGyp4DYQZU9BS8MxXKE5Kfd+aH8+w9sA@mail.gmail.com>
 <20170323123437.uqdwhfmmsjke3f7s@pengutronix.de>
Message-ID: <CACRpkdZRfLh9RXRycW_cAxuTYE6tPd7LR32EkAW8y2fh=AxhXA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Mar 23, 2017 at 1:34 PM, Uwe Kleine-K?nig
<u.kleine-koenig@pengutronix.de> wrote:

> Maybe we can make gpiod_get_optional look like this:
>
>         if (!dev->of_node && isnt_a_acpi_device(dev) && !IS_ENABLED(GPIOLIB))
>                 return NULL;
>         else
>                 return -ENOSYS;
>
> I don't know how isnt_a_acpi_device looks like, probably it involves
> CONFIG_ACPI and/or dev->acpi_node.
>
> This should be safe and still comfortable for legacy platforms, isn't it?

I like the looks of this.

Can we revert Dmitry's patch and apply something like this instead?

Dmitry, how do you feel about this?

Yours,
Linus Walleij
