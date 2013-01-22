From: linus.walleij@linaro.org (Linus Walleij)
Date: Tue, 22 Jan 2013 10:42:11 +0100
Subject: [PATCH v7 09/15] gpio: pl061: set initcall level to module init
In-Reply-To: <1358785488.6590.33.camel@hornet>
References: <1358494279-16503-1-git-send-email-haojian.zhuang@linaro.org>
 <1358494279-16503-10-git-send-email-haojian.zhuang@linaro.org>
 <CACRpkdb=vf5s-XmfYYn5W-BjeNaf9vw6-sDSH6VDC41PBX0rdQ@mail.gmail.com>
 <1358785488.6590.33.camel@hornet>
Message-ID: <CACRpkdY4MHLjs1Lnj+8Ts6oZOjG14pDssCQ09PX-a_5nGRs1sg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jan 21, 2013 at 5:24 PM, Pawel Moll <pawel.moll@arm.com> wrote:

> Hm. Doesn't this make the MMCI probing depending on the module_init
> order? As in: wouldn't it make the mmci probe completely fail (not even
> defer it) if it was called before the pl061? In that case even your,
> Linus, hack with inverting the CD status wouldn't work...

According to Haojian it works, but for sure the MMCI driver *should*
(on the eternal list of SHOULDDO) bail out and return any
-EPROBE_DEFER up to the AMBA bus core properly so it
will be tried again later if this happens.

AFAICT gpio_request() will return -EPROBE_DEFER if the GPIO
cannot be located.

Yours,
Linus Walleij
