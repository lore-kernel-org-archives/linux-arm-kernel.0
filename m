From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Tue, 3 Jul 2012 14:07:47 +0100
Subject: [PATCH] can: flexcan: add a regulator for transceiver
In-Reply-To: <1341319571-27763-1-git-send-email-shawn.guo@linaro.org>
References: <1341319571-27763-1-git-send-email-shawn.guo@linaro.org>
Message-ID: <20120703130747.GD25995@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jul 03, 2012 at 08:46:11PM +0800, Shawn Guo wrote:

> +	if (priv->reg_xcvr) {
> +		if (on)
> +			regulator_enable(priv->reg_xcvr);
> +		else
> +			regulator_disable(priv->reg_xcvr);
> +	}

No, the regulator API will stub itself out if not enabled, and if the
supply is fixed then a fixed voltage regulator will do the job.  We
shouldn't be open coding this stuff in individual users.
