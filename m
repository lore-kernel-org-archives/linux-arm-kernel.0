From: tj@kernel.org (Tejun Heo)
Date: Thu, 30 Jun 2016 04:51:03 -0500
Subject: [PATCH] PM / suspend: show workqueue state in suspend flow
In-Reply-To: <1467256666-27808-1-git-send-email-roger.lu@mediatek.com>
References: <1467256666-27808-1-git-send-email-roger.lu@mediatek.com>
Message-ID: <20160630095103.GB28719@htj.duckdns.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

On Thu, Jun 30, 2016 at 11:17:46AM +0800, Roger Lu wrote:
> +		if (wq->flags & WQ_FREEZABLE)
> +			pr_info("freezable ");

The flag is already printed below and doing this will make the output
more difficult to read.

>  		pr_info("workqueue %s: flags=0x%x\n", wq->name, wq->flags);

Thanks.

-- 
tejun
