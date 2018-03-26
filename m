From: andrew@lunn.ch (Andrew Lunn)
Date: Mon, 26 Mar 2018 22:48:02 +0200
Subject: [net-next PATCH 2/5] soc: ti: K2G: provide APIs to support
 driver probe deferral
In-Reply-To: <1522095312-23249-3-git-send-email-m-karicheri2@ti.com>
References: <1522095312-23249-1-git-send-email-m-karicheri2@ti.com>
 <1522095312-23249-3-git-send-email-m-karicheri2@ti.com>
Message-ID: <20180326204802.GC5862@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Mar 26, 2018 at 04:15:09PM -0400, Murali Karicheri wrote:
> This patch provide APIs to allow client drivers to support
> probe deferral. On K2G SoC, devices can be probed only
> after the ti_sci_pm_domains driver is probed and ready.
> As drivers may get probed at different order, any driver
> that depends on knav dma and qmss drivers, for example
> netcp network driver, needs to defer probe until
> knav devices are probed and ready to service. To do this,
> add an API to query the device ready status from the knav
> dma and qmss devices.

Hi Murali 

Shouldn't you really re-write this to be a dma driver?  You would then
do something like of_dma_request_slave_channel() in the ethernet
driver probe function. That probably correctly returns EPROBE_DEFER.

       Andrew
