From: kishon@ti.com (Kishon Vijay Abraham I)
Date: Fri, 16 Jun 2017 13:23:56 +0530
Subject: [PATCH V2 0/5] phy: bcm-ns-usb3: add MDIO driver
In-Reply-To: <20170608200428.9187-1-zajec5@gmail.com>
References: <20170511132925.14564-1-zajec5@gmail.com>
 <20170608200428.9187-1-zajec5@gmail.com>
Message-ID: <dab533dc-a21c-807d-6688-f8aae4a03f61@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On Friday 09 June 2017 01:34 AM, Rafa? Mi?ecki wrote:
> From: Rafa? Mi?ecki <rafal@milecki.pl>
> 
> As explained in the commit 9200c6f177638 ("Revert "phy: Add USB3 PHY support
> for Broadcom NSP SoC"") this module should be modified to use MDIO bus as
> this is how PHY is really attached.
> 
> This should allow reusing this driver on NSP and any other platform with
> MDIO bus and this particular PHY.
> 
> V2: Rebase and update 4/5 and 5/5.

merged, thanks!

-Kishon
> 
> Rafa? Mi?ecki (5):
>   phy: bcm-ns-usb3: always wait for idle after writing to the PHY reg
>   phy: bcm-ns-usb3: use pointer for PHY writing function
>   phy: bcm-ns-usb3: enable MDIO in the platform specific code
>   dt-bindings: phy: Modify Broadcom NS USB 3.0 PHY binding to use MDIO
>   phy: bcm-ns-usb3: add MDIO driver using proper bus layer
> 
>  .../devicetree/bindings/phy/bcm-ns-usb3-phy.txt    |  27 ++-
>  drivers/phy/broadcom/Kconfig                       |   1 +
>  drivers/phy/broadcom/phy-bcm-ns-usb3.c             | 230 +++++++++++++++------
>  3 files changed, 186 insertions(+), 72 deletions(-)
> 
