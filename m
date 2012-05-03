From: santosh.shilimkar@ti.com (Santosh Shilimkar)
Date: Thu, 03 May 2012 16:46:02 +0530
Subject: [PATCH 8/8] gpio/omap: fix missing check in *_runtime_suspend()
In-Reply-To: <1335536018-16004-9-git-send-email-tarun.kanti@ti.com>
References: <1335536018-16004-1-git-send-email-tarun.kanti@ti.com>
 <1335536018-16004-9-git-send-email-tarun.kanti@ti.com>
Message-ID: <4FA268F2.5090301@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 27 April 2012 07:43 PM, Tarun Kanti DebBarma wrote:
> We do checking for bank->enabled_non_wakeup_gpios in order
> to skip redundant operations. Somehow, the check got missed
> while doing the cleanup series.
> 
> Just to make sure that we do context restore correctly in
> *_runtime_resume(), the bank->workaround_enabled check is
> moved after context restore. Otherwise, it would prevent
> context restore when bank->enabled_non_wakeup_gpios is 0.
> 
> Cc: Kevin Hilman <khilman@ti.com>
> Cc: Tony Lindgren <tony@atomide.com>
> Cc: Santosh Shilimkar <santosh.shilimkar@ti.com>
> Cc: Cousson, Benoit <b-cousson@ti.com>
> Cc: Grant Likely <grant.likely@secretlab.ca>
> Signed-off-by: Tarun Kanti DebBarma <tarun.kanti@ti.com>
> ---
Looks good.
Reviewed-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
