From: linus.walleij@linaro.org (Linus Walleij)
Date: Mon, 29 Apr 2013 14:21:15 +0200
Subject: Adding a void * to pinctrl_pin_desc
In-Reply-To: <051069C10411E24D9749790C498526FA1BCF54B1@SJEXCHMB12.corp.ad.broadcom.com>
References: <051069C10411E24D9749790C498526FA1BCF4FC6@SJEXCHMB12.corp.ad.broadcom.com>
 <CACRpkdYxJOWYMfwmrEGhqgjushVjWyc=FyKMaZNLnn=0jrTs9A@mail.gmail.com>
 <051069C10411E24D9749790C498526FA1BCF54B1@SJEXCHMB12.corp.ad.broadcom.com>
Message-ID: <CACRpkdY2vWvvE_NToQ5rkxGC32hCJgMjNpkF+KEGJ+-o4My4-Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Apr 27, 2013 at 2:54 AM, Sherman Yin <syin@broadcom.com> wrote:
> [Me]
>> Then use container_of() to dereference a struct foo_pin_desc pointer from
>> the
>> pointer at &foodesc->desc;
>
> Hmm, while it would be easy to create a macro to fill the static foo_pin_desc array
> in the driver, this array would not be suitable for use with pinctrl_register().

Now I start to change opinion. You're right about this.

> I would have to, in the probe function, loop through the foo_pin_desc array and
> create another pinctrl_pin_desc array to use for pinctrl_desc.pins.

Yeah that sucks.

> I think I'll just use a separate struct in the driver to keep track of other pin-specific data.

No I think I have changed opinion. Can you send a patch adding a void * to
struct pinctrl_pin_desc  as patch [1/n] when you send your driver, and
I think I'll be happy with it.

Yours,
Linus Walleij
