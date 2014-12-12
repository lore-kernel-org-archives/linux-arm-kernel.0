From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 12 Dec 2014 23:05:43 +0000
Subject: [PATCH] clk: Really fix deadlock with mmap_sem
In-Reply-To: <1418425456-19364-1-git-send-email-sboyd@codeaurora.org>
References: <1418425456-19364-1-git-send-email-sboyd@codeaurora.org>
Message-ID: <20141212230543.GX11285@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Dec 12, 2014 at 03:04:16PM -0800, Stephen Boyd wrote:
> Commit 6314b6796e3c (clk: Don't hold prepare_lock across debugfs
> creation, 2014-09-04) forgot to update one place where we hold
> the prepare_lock while creating debugfs directories. This means
> we still have the chance of a deadlock that the commit was trying
> to fix. Actually fix it by moving the debugfs creation outside
> the prepare_lock.
> 
> Reported-by: Russell King - ARM Linux <linux@arm.linux.org.uk>

Please use "Russell King <rmk+kernel@arm.linux.org.uk>" rather than this
address, thanks.

-- 
FTTC broadband for 0.8mile line: currently at 9.5Mbps down 400kbps up
according to speedtest.net.
