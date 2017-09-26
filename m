From: davem@davemloft.net (David Miller)
Date: Tue, 26 Sep 2017 11:33:40 -0700 (PDT)
Subject: [PATCH] net: bcm63xx_enet: Use setup_timer and mod_timer
In-Reply-To: <1506255084-10943-1-git-send-email-himanshujha199640@gmail.com>
References: <1506255084-10943-1-git-send-email-himanshujha199640@gmail.com>
Message-ID: <20170926.113340.239908321617902101.davem@davemloft.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Himanshu Jha <himanshujha199640@gmail.com>
Date: Sun, 24 Sep 2017 17:41:24 +0530

> Use setup_timer and mod_timer API instead of structure assignments.
> 
> This is done using Coccinelle and semantic patch used
> for this as follows:
> 
> @@
> expression x,y,z,a,b;
> @@
> 
> -init_timer (&x);
> +setup_timer (&x, y, z);
> +mod_timer (&a, b);
> -x.function = y;
> -x.data = z;
> -x.expires = b;
> -add_timer(&a);
> 
> Signed-off-by: Himanshu Jha <himanshujha199640@gmail.com>

Applied to net-next, thanks.
