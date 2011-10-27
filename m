From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 27 Oct 2011 16:54:34 +0100
Subject: [PATCH] AMBA: Use suspend_noriq to force devices into runtime
	suspend
In-Reply-To: <1319730524-29483-1-git-send-email-ulf.hansson@stericsson.com>
References: <1319730524-29483-1-git-send-email-ulf.hansson@stericsson.com>
Message-ID: <20111027155434.GN19187@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Oct 27, 2011 at 05:48:44PM +0200, Ulf Hansson wrote:
> To be able to make sure devices are put into runtime suspend
> after a suspend sequence, the suspend_noirq callback is used.
> 
> Previously it was was possible for drivers doing pm_runtime_suspend
> and pm_runtime_put_sync directly from it's suspend callbacks.
> This is now not possible due to the following commit, which solve a
> race issue:
> 
> PM: Limit race conditions between runtime PM and system sleep (v2)

There's a patch which has been queued for the last 2 months adding
runtime PM support to the AMBA bus layer which is now merged into
mainline.  Please check whether this works for you.
