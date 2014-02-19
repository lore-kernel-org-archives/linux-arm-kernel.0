From: tj@kernel.org (Tejun Heo)
Date: Wed, 19 Feb 2014 09:53:56 -0500
Subject: [PATCH v6 05/18] ahci-platform: Add support for an optional
 regulator for sata-target power
In-Reply-To: <1392811320-3132-6-git-send-email-hdegoede@redhat.com>
References: <1392811320-3132-1-git-send-email-hdegoede@redhat.com>
 <1392811320-3132-6-git-send-email-hdegoede@redhat.com>
Message-ID: <20140219145356.GD10134@htj.dyndns.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Feb 19, 2014 at 01:01:47PM +0100, Hans de Goede wrote:
> @@ -268,6 +281,9 @@ pdata_exit:
>  		pdata->exit(dev);
>  disable_unprepare_clk:
>  	ahci_disable_clks(hpriv);
> +disable_regulator:
> +	if (hpriv->target_pwr)
> +		regulator_disable(hpriv->target_pwr);

The same thing with clks, I'd much prefer to see ahci_platform doing
devres wrapping so that its consumers wouldn't have to worry about
tearing stuff down.

Thanks.

-- 
tejun
