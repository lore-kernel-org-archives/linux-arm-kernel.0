From: tglx@linutronix.de (Thomas Gleixner)
Date: Sat, 13 Dec 2014 01:13:36 +0100 (CET)
Subject: [PATCH] clk: Really fix deadlock with mmap_sem
In-Reply-To: <1418425456-19364-1-git-send-email-sboyd@codeaurora.org>
References: <1418425456-19364-1-git-send-email-sboyd@codeaurora.org>
Message-ID: <alpine.DEB.2.11.1412130053480.16494@nanos>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 12 Dec 2014, Stephen Boyd wrote:

> Commit 6314b6796e3c (clk: Don't hold prepare_lock across debugfs
> creation, 2014-09-04) forgot to update one place where we hold
> the prepare_lock while creating debugfs directories. This means
> we still have the chance of a deadlock that the commit was trying
> to fix. Actually fix it by moving the debugfs creation outside
> the prepare_lock.
> 
> Reported-by: Russell King - ARM Linux <linux@arm.linux.org.uk>
> Fixes: 6314b6796e3c "clk: Don't hold prepare_lock across debugfs creation"
> Signed-off-by: Stephen Boyd <sboyd@codeaurora.org>

> +	lockdep_assert_held(clk_debug_lock);

That change is not mentioned in the changelog and seems to be
unrelated to the issue at hand.

Other than that:

Reviewed-by: Thomas Gleixner <tglx@linutronix.de>
