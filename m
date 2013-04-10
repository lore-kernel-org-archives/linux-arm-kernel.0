From: linus.walleij@linaro.org (Linus Walleij)
Date: Wed, 10 Apr 2013 23:10:56 +0200
Subject: [PATCH] PM / Runtime: Idle devices asynchronously after
 probe|release
In-Reply-To: <1365605125-27538-1-git-send-email-ulf.hansson@stericsson.com>
References: <1365605125-27538-1-git-send-email-ulf.hansson@stericsson.com>
Message-ID: <CACRpkdYwuUJLRQPbd=nRfSONRxHuZNLuGt_fpp3jd4YWkgtMTA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Apr 10, 2013 at 4:45 PM, Ulf Hansson <ulf.hansson@stericsson.com> wrote:

> From: Ulf Hansson <ulf.hansson@linaro.org>
>
> Putting devices into idle|suspend in a synchronous manner means we are
> waiting for each device to become idle|suspended before the probe|release
> is fully done.
>
> This patch switch to use the asynchronous runtime PM API:s instead and
> thus improves the parallelism since we can move on and handle the next
> device in queue in an earlier phase.
>
> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
> Cc: Kevin Hilman <khilman@linaro.org>
> Cc: Alan Stern <stern@rowland.harvard.edu>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

Looks correct to me.
Acked-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
