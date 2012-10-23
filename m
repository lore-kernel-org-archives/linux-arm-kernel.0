From: David.Laight@ACULAB.COM (David Laight)
Date: Tue, 23 Oct 2012 09:21:11 +0100
Subject: [PATCH v3 1/4] net/macb: fix truncate warnings
In-Reply-To: <1350931534-8416-2-git-send-email-manabian@gmail.com>
References: <1350931534-8416-1-git-send-email-manabian@gmail.com>
 <1350931534-8416-2-git-send-email-manabian@gmail.com>
Message-ID: <AE90C24D6B3A694183C094C60CF0A2F6026B705B@saturn3.aculab.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> When building macb on x86_64 the following warnings show up:
>   drivers/net/ethernet/cadence/macb.c: In function macb_interrupt:
>   drivers/net/ethernet/cadence/macb.c:556:4: warning: large integer implicitly truncated to unsigned type [-Woverflow]
...
> -			macb_writel(bp, IDR, ~0UL);
> +			macb_writel(bp, IDR, -1);

Seems wrong to fix an error with an unsigned value
by using -1.

	David
