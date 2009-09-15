From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Tue, 15 Sep 2009 11:13:55 +0100
Subject: [PATCH 5/7] S3C64XX DMA: TC-IRQ implemented.
In-Reply-To: <1253008883-7624-1-git-send-email-jassi.brar@samsung.com>
References: <1253008883-7624-1-git-send-email-jassi.brar@samsung.com>
Message-ID: <20090915101355.GD22878@rakim.wolfsonmicro.main>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Sep 15, 2009 at 07:01:23PM +0900, Jassi wrote:

> +		if (errstat & bit)
> +			writel(bit, dmac->regs + PL080_ERR_CLEAR);

The old code would complain in the logs on error, which seems like a
reasonable approach if we've no better idea what to do - it at least
tells people something about what might be going on if things break.

> +		chan = dmac->channels + offs;
> +		if(chan->curr == NULL)
> +			continue;

It's probably a good idea to run your patches through
scripts/checkpatch.pl before submitting them.
