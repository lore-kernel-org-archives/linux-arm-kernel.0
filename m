From: tglx@linutronix.de (Thomas Gleixner)
Date: Thu, 28 Mar 2013 10:31:22 +0100 (CET)
Subject: [PATCH 1/2] clk: abstract locking out into helper functions
In-Reply-To: <1364445958-2999-2-git-send-email-mturquette@linaro.org>
References: <1364368183-24420-1-git-send-email-mturquette@linaro.org>
 <1364445958-2999-1-git-send-email-mturquette@linaro.org>
 <1364445958-2999-2-git-send-email-mturquette@linaro.org>
Message-ID: <alpine.LFD.2.02.1303281027170.22263@ionos>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 27 Mar 2013, Mike Turquette wrote:

> Create locking helpers for the global mutex and global spinlock.  The
> definitions of these helpers will be expanded upon in the next patch
> which introduces reentrancy into the locking scheme.

This looks way better. Nitpick below.
 
> +static void clk_enable_lock(unsigned long *flags)
> +{
> +	spin_lock_irqsave(&enable_lock, *flags);
> +}

> +static void clk_enable_unlock(unsigned long *flags)

Please just hand in the flags, no need for indirection.

> +{
> +	spin_unlock_irqrestore(&enable_lock, *flags);
> +}
> +

Reviewed-by: Thomas Gleixner <tglx@linutronix.de>
