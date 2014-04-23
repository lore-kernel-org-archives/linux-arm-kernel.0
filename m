From: linus.walleij@linaro.org (Linus Walleij)
Date: Wed, 23 Apr 2014 22:17:16 +0200
Subject: [PATCH 4/4] pinctrl: sirf: move to use irq_get_handler_data
In-Reply-To: <1397544229-20545-5-git-send-email-21cnbao@gmail.com>
References: <1397544229-20545-1-git-send-email-21cnbao@gmail.com>
 <1397544229-20545-5-git-send-email-21cnbao@gmail.com>
Message-ID: <CACRpkdbDeF5gBVv=hQSdX1i9fw=7Or+=qN=g4OXHvHkZKr7vcQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Apr 15, 2014 at 8:43 AM, Barry Song <21cnbao@gmail.com> wrote:

> From: Barry Song <Baohua.Song@csr.com>
>
> we set bank as handler_data, now we can get bank in ISR directly
> instead of looking-up.
>
> Signed-off-by: Barry Song <Baohua.Song@csr.com>

If you want to use some other handler data than the gpiochip,
you should just use irq_set_chained_handler() and
irq_set_handler_data() directly.

Yours,
Linus Walleij
