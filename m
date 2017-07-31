From: santosh.shilimkar@oracle.com (Santosh Shilimkar)
Date: Mon, 31 Jul 2017 13:09:42 -0700
Subject: [PATCH v2] soc: ti: knav: Add a NULL pointer check for kdev in
 knav_pool_create
In-Reply-To: <1501475496-10267-1-git-send-email-j-keerthy@ti.com>
References: <1501475496-10267-1-git-send-email-j-keerthy@ti.com>
Message-ID: <4f248ff1-9972-a519-f7ff-c540a7e9f71e@oracle.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 7/30/2017 9:31 PM, Keerthy wrote:
> knav_pool_create is an exported function. In the event of a call
> before knav_queue_probe, we encounter a NULL pointer dereference
> in the following line. Hence return -EPROBE_DEFER to the caller till
> the kdev pointer is non-NULL.
> 
> Signed-off-by: Keerthy <j-keerthy@ti.com>
> ---
> 
> Changes in v2:
> 
>    * Fixed returning an int to returning pointer.

Thanks. Will add it to the queue.
