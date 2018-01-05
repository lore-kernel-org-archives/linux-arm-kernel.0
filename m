From: sboyd@codeaurora.org (Stephen Boyd)
Date: Fri, 5 Jan 2018 08:24:38 -0800
Subject: [PATCH -next] clk: meson-axg: fix potential NULL dereference in
 axg_clkc_probe()
In-Reply-To: <1515143370.7439.62.camel@baylibre.com>
References: <1515117059-176004-1-git-send-email-weiyongjun1@huawei.com>
 <1515143370.7439.62.camel@baylibre.com>
Message-ID: <20180105162438.GB21040@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 01/05, Jerome Brunet wrote:
> On Fri, 2018-01-05 at 01:50 +0000, Wei Yongjun wrote:
> > platform_get_resource() may return NULL, add proper
> > check to avoid potential NULL dereferencing.
> > 
> > This is detected by Coccinelle semantic patch.
> > 
> > @@
> > expression pdev, res, n, t, e, e1, e2;
> > @@
> > 
> > res = platform_get_resource(pdev, t, n);
> > + if (!res)
> > +   return -EINVAL;
> > ... when != res == NULL
> > e = devm_ioremap(e1, res->start, e2);
> > 
> > Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>
> > ---
> 
> Looks good. Thank you.
> 
> Stephen, do you prefer to take this directly ?

Yes. Will do today.

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
