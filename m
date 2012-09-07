From: khilman@deeprootsystems.com (Kevin Hilman)
Date: Fri, 07 Sep 2012 15:06:52 -0700
Subject: [PATCH v2] gpio/omap: fix possible memory leak in
 omap2_gpio_dev_init()
In-Reply-To: <CAPgLHd-XS_AtLr+8R6yNkSXdNxO3i-NapK7o5zBUado-7R99=w@mail.gmail.com>
 (Wei Yongjun's message of "Mon, 3 Sep 2012 20:42:27 +0800")
References: <CAPgLHd-XS_AtLr+8R6yNkSXdNxO3i-NapK7o5zBUado-7R99=w@mail.gmail.com>
Message-ID: <871uidjxmr.fsf@deeprootsystems.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Wei Yongjun <weiyj.lk@gmail.com> writes:

> From: Wei Yongjun <yongjun_wei@trendmicro.com.cn>
>
> pdata and pdata->regs have been allocated in this function and 
> should be freed before leaving it, and in the other error handling
> cases too.
>
> spatch with a semantic match is used to found this problem.
> (http://coccinelle.lip6.fr/)
>
> Signed-off-by: Wei Yongjun <yongjun_wei@trendmicro.com.cn>

Acked-by: Kevin Hilman <khilman@ti.com>

Tony, can you pick this one up for fixes?

Thanks,

Kevin
