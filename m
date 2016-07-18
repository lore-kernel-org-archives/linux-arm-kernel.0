From: tj@kernel.org (Tejun Heo)
Date: Mon, 18 Jul 2016 19:50:00 -0400
Subject: [PATCH] [media] s5p-mfc: Remove deprecated
 create_singlethread_workqueue
In-Reply-To: <20160716083025.GA7294@Karyakshetra>
References: <20160716083025.GA7294@Karyakshetra>
Message-ID: <20160718235000.GR3078@mtj.duckdns.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Jul 16, 2016 at 02:00:25PM +0530, Bhaktipriya Shridhar wrote:
> alloc_workqueue replaces deprecated create_singlethread_workqueue().
> 
> The MFC device driver is a v4l2 driver which can encode/decode video
> raw/elementary streams and has support for all popular video codecs.
> 
> The driver's watchdog_workqueue has been replaced with system_wq since
> it queues a single work item, &dev->watchdog_work, which calls for no
> ordering requirement. The work item is involved in running the watchdog
> timer and is not being used on a memory reclaim path.
> 
> Work item has been flushed in s5p_mfc_remove() to ensure
> that there are no pending tasks while disconnecting the driver.
> 
> Signed-off-by: Bhaktipriya Shridhar <bhaktipriya96@gmail.com>

Acked-by: Tejun Heo <tj@kernel.org>

Thanks.

-- 
tejun
