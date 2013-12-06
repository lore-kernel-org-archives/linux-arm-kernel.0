From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 6 Dec 2013 02:39:14 +0100
Subject: [PATCH 2/2] mmc: dw_mmc: add dw_mmc-k3 for k3 platform
In-Reply-To: <1383889128-12540-3-git-send-email-zhangfei.gao@linaro.org>
References: <1383889128-12540-1-git-send-email-zhangfei.gao@linaro.org>
 <1383889128-12540-3-git-send-email-zhangfei.gao@linaro.org>
Message-ID: <201312060239.14832.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 08 November 2013, Zhangfei Gao wrote:
> Add dw_mmc-k3.c for k3v2, support sd/emmc
> 
> Signed-off-by: Zhangfei Gao <zhangfei.gao@linaro.org>
> Tested-by: Zhigang Wang <brooke.wangzhigang@huawei.com>

We are currently having the exact same discussion problem on the altera
version of dw_mmc: It seems that all this driver does in addition to the
common code is to have a custom way to set up the card clocks.

In both cases, there is a custom piece of IP logic providing this clock
(here it is in the "hisilicon,pctrl" node). IMHO that should be a proper
clock driver so you can use the existing call to clk_set_rate to set
it up and not need a special platform driver at all.

	Arnd
