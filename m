From: santosh.shilimkar@oracle.com (santosh.shilimkar at oracle.com)
Date: Thu, 27 Aug 2015 09:39:49 -0700
Subject: [PATCH] soc: ti: reset irq affinity before freeing irq
In-Reply-To: <1440690671-1029-1-git-send-email-m-karicheri2@ti.com>
References: <1440690671-1029-1-git-send-email-m-karicheri2@ti.com>
Message-ID: <55DF3D55.8020705@oracle.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 8/27/15 8:51 AM, Murali Karicheri wrote:
> When using accumulator queue for rx side for network driver, following
> warning is seen when doing a reboot command from Linux console. This
> is because, affinity value is not reset before calling free_irq(). This
> patch fixes this.
>
> Deconfiguring network interfaces...
> [   55.176589] ------------[ cut here ]-----------
> [   55.181232] WARNING: CPU: 0 PID: 2081 at kernel/irq/manage.c:1370
> __free_irq+0x208/0x214
>
> Signed-off-by: Murali Karicheri <m-karicheri2@ti.com>
> ---

Looks good. I will add it my queue. Thanks !!

Regards,
Santosh
