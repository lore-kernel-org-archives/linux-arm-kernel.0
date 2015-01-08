From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Thu, 8 Jan 2015 10:30:44 +0100
Subject: [PATCH] reset: sunxi: fix spinlock initialization
In-Reply-To: <1420678479-630-1-git-send-email-tyler.baker@linaro.org>
References: <1420678479-630-1-git-send-email-tyler.baker@linaro.org>
Message-ID: <20150108093044.GL7853@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Tyler,

On Wed, Jan 07, 2015 at 04:54:39PM -0800, Tyler Baker wrote:
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

Thanks for this patch.

Can you send this to stable too please?

Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150108/f5474105/attachment.sig>
