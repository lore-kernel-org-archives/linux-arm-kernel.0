From: davem@davemloft.net (David Miller)
Date: Wed, 27 Oct 2010 11:07:32 -0700 (PDT)
Subject: [PATCH 2/4] caif-u5500: CAIF shared memory transport protocol
In-Reply-To: <1287774235-11151-3-git-send-email-sjur.brandeland@stericsson.com>
References: <1287774235-11151-1-git-send-email-sjur.brandeland@stericsson.com>
	<1287774235-11151-2-git-send-email-sjur.brandeland@stericsson.com>
	<1287774235-11151-3-git-send-email-sjur.brandeland@stericsson.com>
Message-ID: <20101027.110732.48492064.davem@davemloft.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Sjur Braendeland <sjur.brandeland@stericsson.com>
Date: Fri, 22 Oct 2010 21:03:53 +0200

> +		if (!in_irq())
> +			spin_lock_bh(&pshm_drv->lock);
> +		else
> +			spin_lock_irqsave(&pshm_drv->lock, flags);

You should never have contextual based locking schemes like this,
it's not just ugly it's also deadlock prone.
