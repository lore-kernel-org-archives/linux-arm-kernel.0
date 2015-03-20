From: f.fainelli@gmail.com (Florian Fainelli)
Date: Fri, 20 Mar 2015 16:02:16 -0700
Subject: [PATCH 4/5] phy: add Broadcom SATA3 PHY driver for Broadcom STB
 SoCs
In-Reply-To: <1426728222-8197-4-git-send-email-computersforpeace@gmail.com>
References: <1426728222-8197-1-git-send-email-computersforpeace@gmail.com>
 <1426728222-8197-4-git-send-email-computersforpeace@gmail.com>
Message-ID: <550CA6F8.7080504@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 18/03/15 18:23, Brian Norris wrote:
> Supports up to two ports which can each be powered on/off and configured
> independently.
> 
> Signed-off-by: Brian Norris <computersforpeace@gmail.com>
> ---

[snip]

> +
> +static const struct of_device_id brcmstb_sata_phy_of_match[] = {
> +	{ .compatible	= "brcm,bcm7445-sata-phy" },

The binding document specifies "brcm,phy-sata3" as a fallback compatible
string, so we want to match it here.

[snip]

> +
> +	dev_info(dev, "registered %d ports\n", count);

"registered %d port(s)" ;)
-- 
Florian
