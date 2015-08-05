From: leo.yan@linaro.org (Leo Yan)
Date: Thu, 6 Aug 2015 07:17:43 +0800
Subject: [RFC PATCH 0/3] mailbox: hisilicon: add mailbox driver
In-Reply-To: <CABb+yY0-RQ80q92EBsuBoYpjxW5zR=nXr+j3zCXw3wKkCf33OQ@mail.gmail.com>
References: <1438564390-28111-1-git-send-email-leo.yan@linaro.org>
 <CABb+yY0-RQ80q92EBsuBoYpjxW5zR=nXr+j3zCXw3wKkCf33OQ@mail.gmail.com>
Message-ID: <20150805231743.GB6880@leoy-linaro>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Jassi,

Thanks for review.

On Wed, Aug 05, 2015 at 04:22:01PM +0530, Jassi Brar wrote:
> On Mon, Aug 3, 2015 at 6:43 AM, Leo Yan <leo.yan@linaro.org> wrote:

[...]

> > For easily extending for Hisilicon series SoCs (SoCs may have difference
> > for register's definition with each other), so firstly implement common
> > mailbox driver; this common mailbox driver provides three mainly
> > functionality:
> >
> >  - help register channels into framework;
> >  - hook low level callback functions for register's operations;
> >  - Enhance rx channel's message queue, which is based on the code in
> >    drivers/mailbox/omap-mailbox.c.
> >
> Not cool.
>  Please don't reinvent the wheel by having platform specific
> implementation of the mailbox api. Which vendor doesn't plan to roll
> out new SoCs, and hence variations of mailbox controllers?  The OMAP
> stack predates the common api, and was actually supposed to be
> converted over eventually. Please implement just the
> drivers/mailbox/hi6220-mailbox.c (preferably by the name of the
> mailbox controller, if any)

Understood. Here i have one question, the rx channel's message queue is
looks like a common mechanism and can be added into framework file
mailbox.c, then Soc driver file can _ONLY_ focus on register level's
operations. If so, the common driver in this patch also is unnecessary.

Do you suggest to use upper method to rework patches? Or just think
it's okay to implement rx channel's message queue in hi6220-mailbox.c?

Thanks,
Leo Yan
