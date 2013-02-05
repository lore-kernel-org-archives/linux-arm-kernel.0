From: linus.walleij@linaro.org (Linus Walleij)
Date: Tue, 5 Feb 2013 18:14:32 +0100
Subject: [PATCH v8 03/12] gpio: find gpio base by ascend order
In-Reply-To: <1359825953-15663-4-git-send-email-haojian.zhuang@linaro.org>
References: <1359825953-15663-1-git-send-email-haojian.zhuang@linaro.org>
 <1359825953-15663-4-git-send-email-haojian.zhuang@linaro.org>
Message-ID: <CACRpkdZbC8nrDnQEZes9XJTJ6uSfpx-DjuSs3Q6GA0=eauhdYg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Feb 2, 2013 at 6:25 PM, Haojian Zhuang
<haojian.zhuang@linaro.org> wrote:

> gpiochip_find_base() always tries to find valid gpio with descend order.
> It's inconvient if gpio information is passing from DTS. Now try to find
> valid gpio with ascend order.
>
> Signed-off-by: Haojian Zhuang <haojian.zhuang@linaro.org>

This is more scary stuff.

As you know GPIO numbers are exposed to userspace.

Systems with this change risk having their dynamically added
GPIO controller enumerated in a different fashion. And
userspace clients may be relying on these numbers.

And we do not break userspace.

I know this is not elegant but I'm afraid the descending search
needs to be kept for compatibibility reasons.

BTW: please CC Grant likely on all patches.

Yours,
Linus Walleij
