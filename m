From: shawn.guo@linaro.org (Shawn Guo)
Date: Mon, 23 Dec 2013 20:23:17 +0800
Subject: [PATCH 1/1] mmc: sdhci: fix lockdep error on tunning routine
In-Reply-To: <1387797184-18958-1-git-send-email-b29396@freescale.com>
References: <1387797184-18958-1-git-send-email-b29396@freescale.com>
Message-ID: <20131223122315.GJ26070@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Dec 23, 2013 at 07:13:04PM +0800, Dong Aisheng wrote:
> It's strange that this issue did not happen on kernel 3.10.17 with the same
> code.

Probably just because you did not turn on CONFIG_PROVE_LOCKING on your
3.10.17 kennel.

Shawn

> And looking at the code, before call spin_lock we already disable the mmc
> controller irq, per on my understanding, the deadlock given by lockdep may not
> be able to happen(pls fix me if wrong).
> May the lockdep not track the specific irq disable?
> Copy lockdep guy to comment.
> ---
