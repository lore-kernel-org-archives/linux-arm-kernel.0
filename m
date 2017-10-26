From: shawnguo@kernel.org (Shawn Guo)
Date: Thu, 26 Oct 2017 22:31:14 +0800
Subject: [PATCH v3 2/2] phy: add combo phy driver for HiSilicon STB SoCs
In-Reply-To: <1508921049-16208-3-git-send-email-shawnguo@kernel.org>
References: <1508921049-16208-1-git-send-email-shawnguo@kernel.org>
 <1508921049-16208-3-git-send-email-shawnguo@kernel.org>
Message-ID: <20171026143112.GA13744@dragon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Oct 25, 2017 at 04:44:09PM +0800, Shawn Guo wrote:
> +static int histb_combphy_init(struct phy *phy)
> +{
> +	struct histb_combphy_priv *priv = phy_get_drvdata(phy);
> +	u32 val;
> +	int ret;
> +
> +	/* PHY0 doesn't support mode setting */
> +	if (priv->phy_id != 0) {

With a bit more think on this, I admit it might not scale for future
SoCs which could reasonably support mode select for combphy0.  So
instead of hard checking device id, I will repost with a new property
added for this. 

Shawn

> +		ret = histb_combphy_set_mode(priv);
> +		if (ret)
> +			return ret;
> +	}
