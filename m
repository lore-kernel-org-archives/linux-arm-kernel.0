From: santosh.shilimkar@oracle.com (santosh.shilimkar at oracle.com)
Date: Sun, 20 Aug 2017 22:44:51 -0700
Subject: [PATCH v2] soc: ti: knav: Add a NULL pointer check for kdev in
 knav_pool_create
In-Reply-To: <1501475496-10267-1-git-send-email-j-keerthy@ti.com>
References: <1501475496-10267-1-git-send-email-j-keerthy@ti.com>
Message-ID: <2f826631-68d2-6a7e-a656-9c8e67ee8337@oracle.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd,

On 7/30/17 9:31 PM, Keerthy wrote:
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
FWIW, Acked-by: Santosh Shilimkar <santosh.shilimkar@oracle.com>

Can you please also apply this fix in your fixes branch ?
