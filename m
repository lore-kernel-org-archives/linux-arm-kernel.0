From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Mon, 12 Jan 2015 17:17:06 +0100
Subject: [PATCH RESEND] reset: sunxi: fix spinlock initialization
In-Reply-To: <1421078086-27946-1-git-send-email-tyler.baker@linaro.org>
References: <1421078086-27946-1-git-send-email-tyler.baker@linaro.org>
Message-ID: <20150112161706.GO4891@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jan 12, 2015 at 07:54:46AM -0800, Tyler Baker wrote:
> Call spin_lock_init() before the spinlocks are used, both in early init 
> and probe functions preventing a lockdep splat.
> 
> I have been observing lockdep complaining [1] during boot on my a80 optimus [2]
> when CONFIG_PROVE_LOCKING has been enabled. This patch resolves the splat,
> and has been tested on a few other sunxi platforms without issue.
> 
> [1] http://storage.kernelci.org/next/next-20150107/arm-multi_v7_defconfig+CONFIG_PROVE_LOCKING=y/lab-tbaker/boot-sun9i-a80-optimus.html
> [2] http://kernelci.org/boot/?a80-optimus
> 
> Signed-off-by: Tyler Baker <tyler.baker@linaro.org>
> Cc: <stable@vger.kernel.org>

Acked-by: Maxime Ripard <maxime.ripard@free-electrons.com>

Thanks!
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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150112/47c3ad47/attachment.sig>
