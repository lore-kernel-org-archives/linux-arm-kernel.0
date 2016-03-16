From: sboyd@codeaurora.org (Stephen Boyd)
Date: Tue, 15 Mar 2016 18:14:17 -0700
Subject: [PATCH] clk: bcm2835: fix check of error code returned by
 devm_ioremap_resource()
In-Reply-To: <1457227295-3093-1-git-send-email-vz@mleia.com>
References: <1457227295-3093-1-git-send-email-vz@mleia.com>
Message-ID: <20160316011417.GP25972@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 03/06, Vladimir Zapolskiy wrote:
> The change fixes potential oops while accessing iomem on invalid
> address, if devm_ioremap_resource() fails due to some reason.
> 
> The devm_ioremap_resource() function returns ERR_PTR() and never
> returns NULL, which makes useless a following check for NULL.
> 
> Signed-off-by: Vladimir Zapolskiy <vz@mleia.com>
> Fixes: 5e63dcc74b30 ("clk: bcm2835: Add a driver for the auxiliary peripheral clock gates")
> ---

Applied to clk-next

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
