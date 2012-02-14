From: kamezawa.hiroyu@jp.fujitsu.com (KAMEZAWA Hiroyuki)
Date: Tue, 14 Feb 2012 17:38:21 +0900
Subject: [PATCHv21 10/16] mm: Serialize access to min_free_kbytes
In-Reply-To: <1328895151-5196-11-git-send-email-m.szyprowski@samsung.com>
References: <1328895151-5196-1-git-send-email-m.szyprowski@samsung.com>
 <1328895151-5196-11-git-send-email-m.szyprowski@samsung.com>
Message-ID: <20120214173821.8a214716.kamezawa.hiroyu@jp.fujitsu.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 10 Feb 2012 18:32:25 +0100
Marek Szyprowski <m.szyprowski@samsung.com> wrote:

> From: Mel Gorman <mgorman@suse.de>
> 
> There is a race between the min_free_kbytes sysctl, memory hotplug
> and transparent hugepage support enablement.  Memory hotplug uses a
> zonelists_mutex to avoid a race when building zonelists. Reuse it to
> serialise watermark updates.
> 
> [a.p.zijlstra at chello.nl: Older patch fixed the race with spinlock]
> Signed-off-by: Mel Gorman <mgorman@suse.de>
> Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>

At linux-next, conflicted with "mm: add extra free kbytes tunable"

To the logic,
Reviewed-by: KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>
