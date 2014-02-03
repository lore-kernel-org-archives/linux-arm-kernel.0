From: jenny.tc@intel.com (Jenny Tc)
Date: Mon, 3 Feb 2014 17:00:32 +0530
Subject: [PATCH 16/18] charger: max14577: Add support for MAX77836 charger
In-Reply-To: <1390911522-28209-17-git-send-email-k.kozlowski@samsung.com>
References: <1390911522-28209-1-git-send-email-k.kozlowski@samsung.com>
 <1390911522-28209-17-git-send-email-k.kozlowski@samsung.com>
Message-ID: <20140203113031.GA8848@jenny-desktop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jan 28, 2014 at 01:18:40PM +0100, Krzysztof Kozlowski wrote:
> -	/* Battery-Charger Constant Voltage (CV) Mode, from SM-V700: 4.35V */
> +	/* Battery-Charger Constant Voltage (CV) Mode, set to: 4.35V */

Does this charger chip support only 4.35V batteries? If the CV is hard coded
to 4.35V, it's not safe for 4.2V batteries.

> +	/* End-of-Charge Current, set to 50mA (max14577) / 7.5mA (max77836) */
The End of charge current basically depend on battery and not on charger chip.

> -	/* Overvoltage-Protection Threshold, from SM-V700: 6.5V */
> +	/* Overvoltage-Protection Threshold, set to 6.5V */
6.5V as over voltage for battery? A 4.35V battery would have exploded by
that time!
