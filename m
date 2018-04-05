From: keescook@chromium.org (Kees Cook)
Date: Wed, 4 Apr 2018 23:26:04 -0700
Subject: [PATCH 1/2] coresight: Use %px to print pcsr instead of %p
In-Reply-To: <1520961871-11196-2-git-send-email-mathieu.poirier@linaro.org>
References: <1520961871-11196-1-git-send-email-mathieu.poirier@linaro.org>
 <1520961871-11196-2-git-send-email-mathieu.poirier@linaro.org>
Message-ID: <CAGXu5jJKG1Qo4r537uER3_i-kkZvq2BKfXM0pGTb+jZ1JfZT_w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Mar 13, 2018 at 10:24 AM, Mathieu Poirier
<mathieu.poirier@linaro.org> wrote:
> From: Leo Yan <leo.yan@linaro.org>
>
> Commit ad67b74d2469 ("printk: hash addresses printed with %p") lets
> printk specifier %p to hash all addresses before printing, this was
> resulting in the high 32 bits of pcsr can only output zeros.  So
> module cannot completely print pc value and it's pointless for debugging
> purpose.
>
> This patch fixes this by using %px to print pcsr instead.

Why is %p (and now %px) needed here at all? %pS is already used, which
should give useful debugging details, yes?

-Kees

-- 
Kees Cook
Pixel Security
