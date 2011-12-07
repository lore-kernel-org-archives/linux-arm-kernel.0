From: davem@davemloft.net (David Miller)
Date: Wed, 07 Dec 2011 13:38:33 -0500 (EST)
Subject: [PATCH] net/fec: fix the use of pdev->id
In-Reply-To: <1323097275-7846-1-git-send-email-shawn.guo@linaro.org>
References: <1323097275-7846-1-git-send-email-shawn.guo@linaro.org>
Message-ID: <20111207.133833.1526414845107847968.davem@davemloft.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Shawn Guo <shawn.guo@linaro.org>
Date: Mon,  5 Dec 2011 23:01:15 +0800

> The pdev->id is used in several places for different purpose.  All
> these uses assume it's always the id of fec device which is >= 0.
> However this is only true for non-DT case.  When DT plays, pdev->id
> is always -1, which will break these pdev->id users.
> 
> Instead of fixing all these users one by one, this patch introduces
> a new member 'dev_id' to 'struct fec_enet_private' for holding the
> correct fec device id, and replaces all the existing uses of pdev->id
> with this dev_id.
> 
> Signed-off-by: Shawn Guo <shawn.guo@linaro.org>

Applied.
