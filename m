From: vinod.koul@intel.com (Vinod Koul)
Date: Wed, 7 May 2014 11:52:15 +0530
Subject: [PATCH 1/4] dma: ste_dma40: Maintain spinlock order while
 handling pause
In-Reply-To: <1398282724-2607-1-git-send-email-ulf.hansson@linaro.org>
References: <1398282724-2607-1-git-send-email-ulf.hansson@linaro.org>
Message-ID: <20140507062215.GH28638@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Apr 23, 2014 at 09:52:01PM +0200, Ulf Hansson wrote:
> The runtime PM resume callback needs to be executed while holding the
> spinlock, make sure to maintain this for the pause operation as well.

Applied, all thanks.

Though we need to change the driver to use SET_LATE_SYSTEM_SLEEP_PM_OPS as
all dmaengine drivers should suspend late as clients can be active while
suspending

-- 
~Vinod
