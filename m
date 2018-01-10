From: sboyd@codeaurora.org (Stephen Boyd)
Date: Wed, 10 Jan 2018 13:24:56 -0800
Subject: [PATCH -next] clk: meson-axg: fix potential NULL dereference in
 axg_clkc_probe()
In-Reply-To: <1515117059-176004-1-git-send-email-weiyongjun1@huawei.com>
References: <1515117059-176004-1-git-send-email-weiyongjun1@huawei.com>
Message-ID: <20180110212456.GB28313@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 01/05, Wei Yongjun wrote:
> platform_get_resource() may return NULL, add proper
> check to avoid potential NULL dereferencing.
> 
> This is detected by Coccinelle semantic patch.
> 
> @@
> expression pdev, res, n, t, e, e1, e2;
> @@
> 
> res = platform_get_resource(pdev, t, n);
> + if (!res)
> +   return -EINVAL;
> ... when != res == NULL
> e = devm_ioremap(e1, res->start, e2);
> 
> Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>
> ---

Applied to clk-next

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
