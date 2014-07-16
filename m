From: antoine.tenart@free-electrons.com (Antoine =?iso-8859-1?Q?T=E9nart?=)
Date: Wed, 16 Jul 2014 11:47:47 +0200
Subject: [PATCH v3 05/12] phy: add the Berlin USB PHY driver
In-Reply-To: <53C646DA.3020002@gmail.com>
References: <1405499166-6726-1-git-send-email-antoine.tenart@free-electrons.com>
 <1405499166-6726-6-git-send-email-antoine.tenart@free-electrons.com>
 <53C64389.3050705@gmail.com> <20140716092541.GC28151@kwain>
 <53C646DA.3020002@gmail.com>
Message-ID: <20140716094747.GD28151@kwain>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jul 16, 2014 at 03:03:14PM +0530, Varka Bhadram wrote:
> On 07/16/2014 02:55 PM, Antoine T?nart wrote:
> >Hi Varka,
> >
> >On Wed, Jul 16, 2014 at 02:49:05PM +0530, Varka Bhadram wrote:
> >>On 07/16/2014 01:55 PM, Antoine T?nart wrote:
> >>>+static const struct of_device_id phy_berlin_sata_of_match[] = {
> >>>+	{
> >>>+		.compatible = "marvell,berlin2-usb-phy",
> >>>+		.data = &phy_berlin_pll_dividers[0],
> >>>+	},
> >>>+	{
> >>>+		.compatible = "marvell,berlin2cd-usb-phy",
> >>>+		.data = &phy_berlin_pll_dividers[1],
> >>>+	},
> >>>+	{ },
> >>>+};
> >>>+MODULE_DEVICE_TABLE(of, phy_berlin_sata_of_match);
> >>>+
> >>It looks good if we move this after probe().. So that we can see of_match_table directly...
> >We use the of match table in the probe, when calling of_match_device().
> >
> >>>+static int phy_berlin_usb_probe(struct platform_device *pdev)
> >>>+{
> >>>+	const struct of_device_id *match =
> >>>+		of_match_device(phy_berlin_sata_of_match, &pdev->dev);
> 
> We are updating of_match_table in platform_driver struct.

Yes. This is not the same thing. of_match_device() allows to get a
pointer to the of_device_id that matched, to retrieve its data.

> 
> Every driver follows the concept of giving the of_device_ids
> above the platform_driver declaration...

Lots of drivers using of_match_device() declare their of_device_id
structure before the probe.

Antoine

-- 
Antoine T?nart, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
