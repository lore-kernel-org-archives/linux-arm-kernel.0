From: varkabhadram@gmail.com (Varka Bhadram)
Date: Fri, 18 Jul 2014 18:24:22 +0530
Subject: [PATCH v10 1/8] phy: add a driver for the Berlin SATA PHY
In-Reply-To: <1405686607-8126-2-git-send-email-antoine.tenart@free-electrons.com>
References: <1405686607-8126-1-git-send-email-antoine.tenart@free-electrons.com>
 <1405686607-8126-2-git-send-email-antoine.tenart@free-electrons.com>
Message-ID: <53C918FE.8040303@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/18/2014 06:00 PM, Antoine T?nart wrote:
> The Berlin SoC has a two SATA ports. Add a PHY driver to handle them.
>
> The mode selection can let us think this PHY can be configured to fit
> other purposes. But there are reasons to think the SATA mode will be
> the only one usable: the PHY registers are only accessible indirectly
> through two registers in the SATA range, the PHY seems to be integrated
> and no information tells us the contrary. For these reasons, make the
> driver a SATA PHY driver.
>
(...)

> +
> +static const struct of_device_id phy_berlin_sata_of_match[] = {
> +	{ .compatible = "marvell,berlin2q-sata-phy" },
> +	{ },
> +};
> +
> +static struct platform_driver phy_berlin_sata_driver = {
> +	.probe	= phy_berlin_sata_probe,
> +	.driver	= {
> +		.name		= "phy-berlin-sata",
> +		.owner		= THIS_MODULE,

owner filed automatically update with module_platform_driver().

see:http://lxr.free-electrons.com/source/include/linux/platform_device.h#L190
  

-- 
Regards,
Varka Bhadram.
