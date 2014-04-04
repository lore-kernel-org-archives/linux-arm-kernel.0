From: davem@davemloft.net (David Miller)
Date: Fri, 04 Apr 2014 11:30:10 -0400 (EDT)
Subject: [PATCH 2/3] net: hisilicon: new hip04 MDIO driver
In-Reply-To: <1396624597-390-3-git-send-email-zhangfei.gao@linaro.org>
References: <1396624597-390-1-git-send-email-zhangfei.gao@linaro.org>
 <1396624597-390-3-git-send-email-zhangfei.gao@linaro.org>
Message-ID: <20140404.113010.1212333214715849484.davem@davemloft.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Zhangfei Gao <zhangfei.gao@linaro.org>
Date: Fri,  4 Apr 2014 23:16:36 +0800

> +config HIP04_ETH
> +	tristate "HISILICON P04 Ethernet support"
> +	select NET_CORE
> +	select PHYLIB
> +	select MARVELL_PHY
> +	select MFD_SYSCON
> +	---help---
> +	  If you wish to compile a kernel for a hardware with hisilicon p04 SoC and
> +	  want to use the internal ethernet then you should answer Y to this.

Selecting NET_CORE makes no sense, if it's not set this driver's
Kconfig file won't even be considered.
