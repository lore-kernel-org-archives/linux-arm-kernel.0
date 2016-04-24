From: wsa@the-dreams.de (Wolfram Sang)
Date: Sun, 24 Apr 2016 22:37:06 +0200
Subject: [PATCH] i2c/omap: drop the lock hard irq context
In-Reply-To: <1459778123-16267-1-git-send-email-grygorii.strashko@ti.com>
References: <1459778123-16267-1-git-send-email-grygorii.strashko@ti.com>
Message-ID: <20160424203706.GB4317@katana>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Apr 04, 2016 at 04:55:23PM +0300, Grygorii Strashko wrote:
> From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> 
> The lock is taken while reading two registers. On RT the first lock is
> taken in hard irq where it might sleep and in the threaded irq.
> The threaded irq runs in oneshot mode so the hard irq does not run until
> the thread the completes so there is no reason to grab the lock.
> 
> Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> [grygorii.strashko at ti.com: drop locking from isr completely and remove
> lock field from struct omap_i2c_dev]
> Signed-off-by: Grygorii Strashko <grygorii.strashko@ti.com>

Applied to for-next, thanks!

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160424/e7ea5251/attachment.sig>
