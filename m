From: cjb@laptop.org (Chris Ball)
Date: Tue, 21 Sep 2010 02:17:11 +0100
Subject: [PATCH] sdhci-s3c: fix incorrect spinlock usage after merge
In-Reply-To: <1284987822-17955-1-git-send-email-m.szyprowski@samsung.com>
References: <1284987822-17955-1-git-send-email-m.szyprowski@samsung.com>
Message-ID: <20100921011711.GB5873@void.printf.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Sep 20, 2010 at 03:03:42PM +0200, Marek Szyprowski wrote:
> In the commit f522886e202a34a2191dd5d471b3c4d46410a9a0 a merge conflict
> in the sdhci-s3c driver been fixed. However the fix used incorrect
> spinlock operation - it cause a race with sdhci interrupt service. The
> correct way to solve it is to use spin_lock_irqsave/irqrestore() calls.

Thanks, applied to mmc-next with:
Signed-off-by: Chris Ball <cjb@laptop.org>

Andrew, not sure how best to get this upstream -- do you want to send
this up to Linus (for -rc5) via your queue in -mm?

-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
