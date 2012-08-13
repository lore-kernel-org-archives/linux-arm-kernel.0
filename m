From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 13 Aug 2012 16:35:54 +0100
Subject: [PATCH v2 1/9] ARM/ASoC: omap-mcbsp: Move OMAP2+ clock
 parenting code to ASoC driver
In-Reply-To: <1344867768-26335-2-git-send-email-peter.ujfalusi@ti.com>
References: <1344867768-26335-1-git-send-email-peter.ujfalusi@ti.com>
 <1344867768-26335-2-git-send-email-peter.ujfalusi@ti.com>
Message-ID: <20120813153554.GA31662@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Aug 13, 2012 at 05:22:40PM +0300, Peter Ujfalusi wrote:
> +	fck_src = clk_get(mcbsp->dev, src);
> +	if (IS_ERR_OR_NULL(fck_src)) {

I know the same error is in the original code, but let's stop propagating
it.  IS_ERR() only here please.
