From: linus.walleij@linaro.org (Linus Walleij)
Date: Fri, 26 Apr 2013 10:52:06 +0200
Subject: Adding a void * to pinctrl_pin_desc
In-Reply-To: <051069C10411E24D9749790C498526FA1BCF4FC6@SJEXCHMB12.corp.ad.broadcom.com>
References: <051069C10411E24D9749790C498526FA1BCF4FC6@SJEXCHMB12.corp.ad.broadcom.com>
Message-ID: <CACRpkdYxJOWYMfwmrEGhqgjushVjWyc=FyKMaZNLnn=0jrTs9A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Apr 26, 2013 at 2:42 AM, Sherman Yin <syin@broadcom.com> wrote:

>  What do you think about expanding the struct to something like this:
>
> struct pinctrl_pin_desc {
>         unsigned number;
>         const char *name;
>         void * pin_data;
> };
>
> so that drivers can optionally use pin_data to hold other pin-specific information?

No don't do this.

Instead:

struct foo_pin_desc {
      struct pinctrl_pin_desc desc;
      ....
      /* Insert my pindata here */
};

Then use container_of() to dereference a struct foo_pin_desc pointer from the
pointer at &foodesc->desc;

Yours,
Linus Walleij
