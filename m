From: oliver@neukum.org (Oliver Neukum)
Date: Mon, 24 Jun 2013 12:24:27 +0200
Subject: [PATCH v2 4/4] USB: EHCI: support running URB giveback in tasklet
 context
In-Reply-To: <1372066925-23579-5-git-send-email-ming.lei@canonical.com>
References: <1372066925-23579-1-git-send-email-ming.lei@canonical.com>
 <1372066925-23579-5-git-send-email-ming.lei@canonical.com>
Message-ID: <2282821.gNu4BgBT5E@linux-5eaq.site>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 24 June 2013 17:42:05 Ming Lei wrote:
> All 4 transfer types can work well on EHCI HCD after switching to run
> URB giveback in tasklet context, so mark all HCD drivers to support
> it.
> 
> At the same time, don't release ehci->lock during URB giveback,
> and remove the check on HCD_BH in ehci_disable_event().
> 
> From below test results on 3 machines(2 ARM and one x86), time
> consumed by EHCI interrupt handler droped much without performance
> loss.
> 
> 1 test description
> 1.1 mass storage performance test:
> - run below command 10 times and compute the average performance
> 
>     dd if=/dev/sdN iflag=direct of=/dev/null bs=200M count=1

It would be nice to get worst case numbers. How bad does it get
if you reduce the sg size in usb-storage from 120K to 4K?

	Regards
		Oliver
