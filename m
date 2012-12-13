From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 13 Dec 2012 10:08:12 +0000
Subject: FW: [PATCH] mmc: mmci: Gate the clock in runtime suspend to
 save power
In-Reply-To: <CADz5_gJ70KrHL5NoSPQbFdeHnQxWLh87zq6N+-V7J7Yq7t+aPQ@mail.gmail.com>
References: <25B60CDC2F704E4E9D88FFD52780CB4C08B00BD3B1@SC-VEXCH1.marvell.com>
 <CADz5_gJ70KrHL5NoSPQbFdeHnQxWLh87zq6N+-V7J7Yq7t+aPQ@mail.gmail.com>
Message-ID: <20121213100812.GE14363@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Dec 13, 2012 at 09:51:38AM +0800, Kevin Liu wrote:
> > Russell's concern is valid if suspend() will not wait for runtime_suspend()
> > to complete the last cycle before suspending.
> 
> pm_runtime_get_noresume is called before suspend and there are
> sdhci_runtime_pm_get/sdhci_runtime_pm_put within sdhci suspend/resume
> function.

What has the sdhci host driver code got to do with the MMCI host driver?
