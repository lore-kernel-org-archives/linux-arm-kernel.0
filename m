From: alexandre.belloni@bootlin.com (Alexandre Belloni)
Date: Mon, 27 Aug 2018 17:11:49 +0200
Subject: [PATCH] arm: pm: call put_device instead of of_node_put in
 at91_pm_config_ws
In-Reply-To: <1534415182-34970-1-git-send-email-zhongjiang@huawei.com>
References: <1534415182-34970-1-git-send-email-zhongjiang@huawei.com>
Message-ID: <20180827151149.GE23428@piout.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 16/08/2018 18:26:22+0800, zhong jiang wrote:
> of_find_device_by_node takes a reference to the struct device when it
> finds a match via get_device. but it fails to put_device in
> at91_pm_config_ws, for_each_matching_node_and_match will get and put
> the node properly, there is no need to call the of_put_node. Therefore,
> just call put_device instead of of_node_put in at91_pm_config_ws.
> 
> Fixes: d7484f5c6b3b ("ARM: at91: pm: configure wakeup sources for ULP1 mode")
> Suggested-by: Claudiu Beznea <Claudiu.Beznea@microchip.com>
> Signed-off-by: zhong jiang <zhongjiang@huawei.com>
> ---
>  arch/arm/mach-at91/pm.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 

Applied, thanks.

-- 
Alexandre Belloni, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
