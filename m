From: loeliger@gmail.com (Jon Loeliger)
Date: Fri, 20 Jun 2014 10:18:58 -0500
Subject: A clockevent IRQ delivery question
In-Reply-To: <53A446C0.10200@linaro.org>
References: <CAJgR-BjUpaR0cxew+-fz5YcDu0VKzim-rhLF4j1hEnR_4O+Jsg@mail.gmail.com>
 <53A446C0.10200@linaro.org>
Message-ID: <CAJgR-Bj+tgCpKTT7FxM-1JMvN7CKUgpaikfbXPQx5ep6+7W2mA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

>
> Hi Jon,

Hi Daniel,

> you can have a look at the exynos_mct driver which has similar design.

OK, I'll give that a once-over!

So yeah, it is pretty clearly doing what I was (slowly) deducing: PPIs are
getting percpu stuff, and SPI are all getting just this
smp_processor_id() stuff.

> There was a notifier for cpu bootup but Thomas added a force affinity api,
> so even if the cpu is not in the online mask, the irq is correctly set
> (commit 30ccf03b).

Ah, I see.  I'll track that commit down.  Thanks.

> By the way, did you try to use the A9 local timers (twd) ?

Not yet.  I hit the global timer just to get my port going.  I needed to
implement and verify our timer block.  But I can give the TWD a
run as well!

Thanks!
jdl
