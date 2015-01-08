From: p.zabel@pengutronix.de (Philipp Zabel)
Date: Thu, 08 Jan 2015 10:09:06 +0100
Subject: [PATCH] reset: sunxi: fix spinlock initialization
In-Reply-To: <1420678479-630-1-git-send-email-tyler.baker@linaro.org>
References: <1420678479-630-1-git-send-email-tyler.baker@linaro.org>
Message-ID: <1420708146.3190.1.camel@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Tyler,

Am Mittwoch, den 07.01.2015, 16:54 -0800 schrieb Tyler Baker:
> Call spin_lock_init() before the spinlocks are used, preventing a lockdep
> splat.
>
> I have been observing lockdep complaining [1] during boot on my a80 optimus [2]
> when CONFIG_PROVE_LOCKING has been enabled. This patch resolves the splat,
> and has been tested on a few other sunxi platforms without issue.
> 
> [1] http://storage.kernelci.org/next/next-20150107/arm-multi_v7_defconfig+CONFIG_PROVE_LOCKING=y/lab-tbaker/boot-sun9i-a80-optimus.html
> [2] http://kernelci.org/boot/?a80-optimus
> 
> Signed-off-by: Tyler Baker <tyler.baker@linaro.org>
> ---
> This patch was tested on 3.19.0-rc3 

Applied, thanks!

regards
Philipp
