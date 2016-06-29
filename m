From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 29 Jun 2016 17:32:47 +0200
Subject: [PATCH 0/6] ARM: NUC900: Add NUC970 SoC support
In-Reply-To: <1466851042-22239-1-git-send-email-vw@iommu.org>
References: <1466851042-22239-1-git-send-email-vw@iommu.org>
Message-ID: <6119546.EJZ9lH2GPk@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Saturday, June 25, 2016 6:37:16 PM CEST Wan Zongshun wrote:
> This patch series added Nuvoton new SoC NUC970 development board
> support, this nuc970 belongs to nuc900 series, but many features are
> not compatible with old nuc900 SoCs like nuc910, nuc920.
> 
> Those patches are basing on old w90x900 codes, and are using standard
> linux subsystem interface, such as dts, driver/clk, driver/clocksource
> , driver/irqchip drivers.
> 
> The old w90x900 plat such as nuc910,nuc960 codes will also be changed
> to new style according to nuc970 codes after those patches was accepted.

Looks good overall. I have a number of comments but they should
all be easy to address, and the general approach of adding this
first makes sense to me as well.

The three drivers should be merged through the respective subsystem
maintainer trees. There is one dependency with the clk header, but
we can resolve that if we merge the header along with the dts files
(actually before the dts files) so that it's possible to build the
.dtb without the clk driver being merged.
That driver in turn will not be selectable in Kconfig because it
depends on CONFIG_SOC_NUC970 (or whatever the symbol is called).

	Arnd
