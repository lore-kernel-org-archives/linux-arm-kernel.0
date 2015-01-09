From: tyler.baker@linaro.org (Tyler Baker)
Date: Thu, 8 Jan 2015 22:38:57 -0800
Subject: [PATCH] reset: sunxi: fix spinlock initialization
In-Reply-To: <20150108093044.GL7853@lukather>
References: <1420678479-630-1-git-send-email-tyler.baker@linaro.org>
 <20150108093044.GL7853@lukather>
Message-ID: <CANMBJr6MLTqvC5OJbq=+viodU=TR0WxuDc8iUrRyh4nV=6PeZg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Maxime,

On 8 January 2015 at 01:30, Maxime Ripard
<maxime.ripard@free-electrons.com> wrote:
> Hi Tyler,
>
> On Wed, Jan 07, 2015 at 04:54:39PM -0800, Tyler Baker wrote:
>> Call spin_lock_init() before the spinlocks are used, preventing a lockdep
>> splat.
>>
>> I have been observing lockdep complaining [1] during boot on my a80 optimus [2]
>> when CONFIG_PROVE_LOCKING has been enabled. This patch resolves the splat,
>> and has been tested on a few other sunxi platforms without issue.
>>
>> [1] http://storage.kernelci.org/next/next-20150107/arm-multi_v7_defconfig+CONFIG_PROVE_LOCKING=y/lab-tbaker/boot-sun9i-a80-optimus.html
>> [2] http://kernelci.org/boot/?a80-optimus
>>
>> Signed-off-by: Tyler Baker <tyler.baker@linaro.org>
>
> Thanks for this patch.

You're welcome.

>
> Can you send this to stable too please?

Sure. Once it has been merged in Linus' tree I'll send it for -stable review.

>
> Maxime
>
> --
> Maxime Ripard, Free Electrons
> Embedded Linux, Kernel and Android engineering
> http://free-electrons.com

Cheers,

-- 
Tyler Baker
Tech Lead, LAVA
Linaro.org | Open source software for ARM SoCs
Follow Linaro: http://www.facebook.com/pages/Linaro
http://twitter.com/#!/linaroorg - http://www.linaro.org/linaro-blog
