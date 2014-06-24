From: lee.jones@linaro.org (Lee Jones)
Date: Tue, 24 Jun 2014 13:39:33 +0100
Subject: [PATCH v6 1/7] phy: add a driver for the Berlin SATA PHY
In-Reply-To: <53A96D68.8070303@gmail.com>
References: <1402914392-6028-1-git-send-email-antoine.tenart@free-electrons.com>
 <1402914392-6028-2-git-send-email-antoine.tenart@free-electrons.com>
 <53A9685E.9090501@ti.com> <53A96A1C.5030800@gmail.com>
 <20140624121525.GM13803@lee--X1> <53A96D68.8070303@gmail.com>
Message-ID: <20140624123933.GN13803@lee--X1>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 24 Jun 2014, Varka Bhadram wrote:

> On 06/24/2014 05:45 PM, Lee Jones wrote:
> >On Tue, 24 Jun 2014, Varka Bhadram wrote:
> >>On 06/24/2014 05:30 PM, Kishon Vijay Abraham I wrote:
> >>>On Monday 16 June 2014 03:56 PM, Antoine T?nart wrote:
> >>>>The Berlin SoC has a two SATA ports. Add a PHY driver to handle them.
> >>>>
> >>>>The mode selection can let us think this PHY can be configured to fit
> >>>>other purposes. But there are reasons to think the SATA mode will be
> >>>>the only one usable: the PHY registers are only accessible indirectly
> >>>>through two registers in the SATA range, the PHY seems to be integrated
> >>>>and no information tells us the contrary. For these reasons, make the
> >>>>driver a SATA PHY driver.
> >>>>
> >>>>Signed-off-by: Antoine T?nart <antoine.tenart@free-electrons.com>
> >>>>---
> >>>>  drivers/phy/Kconfig           |   7 ++
> >>>>  drivers/phy/Makefile          |   1 +
> >>>>  drivers/phy/phy-berlin-sata.c | 232 ++++++++++++++++++++++++++++++++++++++++++
> >>>>  3 files changed, 240 insertions(+)
> >>>>  create mode 100644 drivers/phy/phy-berlin-sata.c
> 
> [...]
> 
> >>>>+static struct platform_driver phy_berlin_sata_driver = {
> >>>>+	.probe	= phy_berlin_sata_probe,
> >>>>+	.driver	= {
> >>>>+		.name		= "phy-berlin-sata",
> >>>>+		.owner		= THIS_MODULE,
> >>>>+		.of_match_table	= phy_berlin_sata_of_match,
> >>use of_match_ptr for of_match_table
> >What use is this?
> >
> >[...]
> >
> of_match_table is NULL for Non-DT based. Better to use the of_match_ptr().
> If driver is DT based 'of_match_table	= phy_berlin_sata_of_match'
> else 'of_match_table	= NULL'
> 
> This is take care by of_match_ptr() macro.

This driver 'depends on OF', so it's okay to always populate
.of_match_table.

-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
