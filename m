From: aisheng.dong@freescale.com (Dong Aisheng)
Date: Fri, 15 Jun 2012 17:26:48 +0800
Subject: [PATCH 04/16] gpio/mxc: move irq_domain_add_legacy call into
 gpio driver
In-Reply-To: <1339653587-4832-5-git-send-email-shawn.guo@linaro.org>
References: <1339653587-4832-1-git-send-email-shawn.guo@linaro.org>
 <1339653587-4832-5-git-send-email-shawn.guo@linaro.org>
Message-ID: <20120615092647.GB8383@shlinux2.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jun 14, 2012 at 01:59:35PM +0800, Shawn Guo wrote:
> Move irq_domain_add_legacy call from imx*-dt.c into gpio driver and
> have the gpio driver adopt irqdomain support for both DT and non-DT
> boot.
> 
> With all imx platform code converted from static gpio irq number
> computation to use run-time gpio_to_irq call, we can now use
> irq_alloc_descs and irqdomain support to dynamically get irq_base
> and have the mapping between gpio and irq number available without
> using virtual_irq_start and MXC_GPIO_IRQ_START.
> 
> Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
> Cc: Grant Likely <grant.likely@secretlab.ca>

Nice move.

Acked-by: Dong Aisheng <dong.aisheng@linaro.org>

Regards
Dong Aisheng
