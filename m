From: jassisinghbrar@gmail.com (Jassi Brar)
Date: Wed, 5 Aug 2015 16:22:01 +0530
Subject: [RFC PATCH 0/3] mailbox: hisilicon: add mailbox driver
In-Reply-To: <1438564390-28111-1-git-send-email-leo.yan@linaro.org>
References: <1438564390-28111-1-git-send-email-leo.yan@linaro.org>
Message-ID: <CABb+yY0-RQ80q92EBsuBoYpjxW5zR=nXr+j3zCXw3wKkCf33OQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Aug 3, 2015 at 6:43 AM, Leo Yan <leo.yan@linaro.org> wrote:
> This patch series is to implement Hisilicon's mailbox driver and enable
> the mailbox controller on Hi6220.
>
Cool.

> The Hisilicon mailbox supports up to 32 channels. Each channel is
> unidirectional with a maximum message size of 8 words. I/O is performed
> using register access (there is no DMA) and the cell raises an interrupt
> when messages are received.
>
FYI, none of other platforms has mailbox with DMA. 8-word deep fifo,
RX interrupt
and optional TX interrupt is pretty common. So cool still.

> For easily extending for Hisilicon series SoCs (SoCs may have difference
> for register's definition with each other), so firstly implement common
> mailbox driver; this common mailbox driver provides three mainly
> functionality:
>
>  - help register channels into framework;
>  - hook low level callback functions for register's operations;
>  - Enhance rx channel's message queue, which is based on the code in
>    drivers/mailbox/omap-mailbox.c.
>
Not cool.
 Please don't reinvent the wheel by having platform specific
implementation of the mailbox api. Which vendor doesn't plan to roll
out new SoCs, and hence variations of mailbox controllers?  The OMAP
stack predates the common api, and was actually supposed to be
converted over eventually. Please implement just the
drivers/mailbox/hi6220-mailbox.c (preferably by the name of the
mailbox controller, if any)

Thanks.
