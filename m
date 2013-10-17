From: dan.carpenter@oracle.com (Dan Carpenter)
Date: Thu, 17 Oct 2013 19:47:59 +0300
Subject: [Patch v2][ 14/37] staging: imx-drm: parallel display: add
 regulator support.
In-Reply-To: <1382022155-21954-15-git-send-email-denis@eukrea.com>
References: <1382022155-21954-1-git-send-email-denis@eukrea.com>
 <1382022155-21954-15-git-send-email-denis@eukrea.com>
Message-ID: <20131017164759.GI11731@mwanda>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Oct 17, 2013 at 05:02:12PM +0200, Denis Carikli wrote:
> +	if (imxpd->lcd_reg)
> +		if (regulator_enable(imxpd->lcd_reg))
> +			dev_err(imxpd->dev, "Failed to enable lcd regulator.\n");
> +

In staging the style is to use braces around multi-line indents for
readability.  Or you could do:

	if (imxpd->lcd_reg && regulator_enable(imxpd->lcd_reg))
		dev_err(imxpd->dev, "Failed to enable lcd regulator.\n");

These kind of tiny things aren't worth resending, but for next time.

regards,
dan carpenter
