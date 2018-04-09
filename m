From: robh@kernel.org (Rob Herring)
Date: Mon, 9 Apr 2018 16:12:44 -0500
Subject: [net-next PATCH v3 01/11] soc: ti: K2G: enhancement to support
 QMSS in K2G NAVSS
In-Reply-To: <1522679881-25643-2-git-send-email-m-karicheri2@ti.com>
References: <1522679881-25643-1-git-send-email-m-karicheri2@ti.com>
 <1522679881-25643-2-git-send-email-m-karicheri2@ti.com>
Message-ID: <20180409211244.cq45hzntyuppnkjc@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Apr 02, 2018 at 10:37:51AM -0400, Murali Karicheri wrote:
> Navigator Subsystem (NAVSS) available on K2G SoC has a cut down
> version of QMSS with less number of queues, internal linking ram
> with lesser number of buffers etc.  It doesn't have status and
> explicit push register space as in QMSS available on other K2 SoCs.
> So define reg indices specific to QMSS on K2G. This patch introduces
> "ti,66ak2g-navss-qm" compatibility to identify QMSS on K2G NAVSS
> and to customize the dts handling code. Per Device manual,
> descriptors with index less than or equal to regions0_size is in region 0
> in the case of K2 QMSS where as for QMSS on K2G, descriptors with index
> less than regions0_size is in region 0. So update the size accordingly in
> the regions0_size bits of the linking ram size 0 register.
> 
> Signed-off-by: Murali Karicheri <m-karicheri2@ti.com>
> Signed-off-by: WingMan Kwok <w-kwok2@ti.com>
> ---
>  .../bindings/soc/ti/keystone-navigator-qmss.txt    |  9 ++-

Reviewed-by: Rob Herring <robh@kernel.org>

>  drivers/soc/ti/knav_qmss.h                         |  6 ++
>  drivers/soc/ti/knav_qmss_queue.c                   | 90 ++++++++++++++++------
>  3 files changed, 82 insertions(+), 23 deletions(-)
