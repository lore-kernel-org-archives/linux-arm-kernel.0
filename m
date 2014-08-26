From: davem@davemloft.net (David Miller)
Date: Mon, 25 Aug 2014 17:26:15 -0700 (PDT)
Subject: [PATCH v6 4/4] net: moxa: continue loop on skb allocation failure
In-Reply-To: <1408976560-15694-1-git-send-email-jonas.jensen@gmail.com>
References: <1408976560-15694-1-git-send-email-jonas.jensen@gmail.com>
Message-ID: <20140825.172615.1598002278628891621.davem@davemloft.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Jonas Jensen <jonas.jensen@gmail.com>
Date: Mon, 25 Aug 2014 16:22:40 +0200

> If netdev_alloc_skb_ip_align() fails, subsequent code will
> try to dereference an invalid pointer.
> 
> Continue to next descriptor on error.
> 
> While we're at it,
> 
> 1. eliminate the chance of an endless loop, replace the main
>    loop with while(rx < budget)
> 
> 2. use napi_complete() and remove the explicit napi_gro_flush()
> 
> Signed-off-by: Jonas Jensen <jonas.jensen@gmail.com>

Applied.
