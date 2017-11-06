From: robh@kernel.org (Rob Herring)
Date: Mon, 6 Nov 2017 16:15:43 -0600
Subject: [PATCH 2/3] clk: hisilicon: Add support for Hi3660 stub clocks
In-Reply-To: <1509693907-90682-3-git-send-email-zhongkaihua@huawei.com>
References: <1509693907-90682-1-git-send-email-zhongkaihua@huawei.com>
 <1509693907-90682-3-git-send-email-zhongkaihua@huawei.com>
Message-ID: <20171106221543.5sejgabzvgcxy6sx@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Nov 03, 2017 at 03:25:06PM +0800, Kaihua Zhong wrote:
> Hi3660 has four stub clocks, which are big and LITTLE cluster clocks,
> GPU clock and DDR clock.  These clocks ask MCU for frequency scaling
> by sending message through mailbox.
> 
> This commit adds support for stub clocks, it requests the dedicated
> mailbox channel at initialization; then later uses this channel to send
> message to MCU to execute frequency scaling. The four stub clocks share
> the same mailbox channel, but every stub clock has its own command id so
> MCU can distinguish the requirement coming for which clock.
> 
> A shared memory is used to present effective frequency value, so the
> clock driver uses I/O mapping for the memory and reads back rate value.
> 
> Reviewed-by: Leo Yan <leo.yan@linaro.org>
> Signed-off-by: Kai Zhao <zhaokai1@hisilicon.com>
> Signed-off-by: Kevin Wang <kevin.wangtao@hisilicon.com>
> Signed-off-by: Ruyi Wang <wangruyi@huawei.com>
> Signed-off-by: Kaihua Zhong <zhongkaihua@huawei.com>
> ---
>  drivers/clk/hisilicon/Kconfig            |   6 +
>  drivers/clk/hisilicon/Makefile           |   1 +
>  drivers/clk/hisilicon/clk-hi3660-stub.c  | 195 +++++++++++++++++++++++++++++++

>  include/dt-bindings/clock/hi3660-clock.h |   7 ++

This belongs in the binding doc patch. But no need to respin just for 
that. 

>  4 files changed, 209 insertions(+)
>  create mode 100644 drivers/clk/hisilicon/clk-hi3660-stub.c
