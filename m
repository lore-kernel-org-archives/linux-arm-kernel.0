From: thierry.reding@gmail.com (Thierry Reding)
Date: Mon, 10 Jun 2013 22:37:49 +0200
Subject: [PATCH 2/2] memory: tegra30-mc: Fix IRQ handler bugs.
In-Reply-To: <1370855624-30564-3-git-send-email-ttynkkynen@nvidia.com>
References: <1370855624-30564-1-git-send-email-ttynkkynen@nvidia.com>
 <1370855624-30564-3-git-send-email-ttynkkynen@nvidia.com>
Message-ID: <20130610203748.GB26036@mithrandir>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jun 10, 2013 at 12:13:44PM +0300, Tuomas Tynkkynen wrote:
[...]
> diff --git a/drivers/memory/tegra30-mc.c b/drivers/memory/tegra30-mc.c
[...]
> @@ -313,8 +313,11 @@ static irqreturn_t tegra30_mc_isr(int irq, void *data)
>  	mask &= stat;
>  	if (!mask)
>  		return IRQ_NONE;
> -	while ((bit = ffs(mask)) != 0)
> +	while ((bit = ffs(mask)) != 0) {
>  		tegra30_mc_decode(mc, bit - 1);
> +		mask &= BIT(bit);

Same comment as for patch 1/2.

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 836 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130610/b233b82b/attachment.sig>
