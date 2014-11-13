From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Thu, 13 Nov 2014 14:06:36 +0100
Subject: [PATCH v4 4/7] phy: add support for USB cluster on the Armada
 375 SoC
In-Reply-To: <1415879269-29711-5-git-send-email-gregory.clement@free-electrons.com>
References: <1415879269-29711-1-git-send-email-gregory.clement@free-electrons.com>
 <1415879269-29711-5-git-send-email-gregory.clement@free-electrons.com>
Message-ID: <20141113140636.21226234@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Gregory CLEMENT,

On Thu, 13 Nov 2014 12:47:46 +0100, Gregory CLEMENT wrote:
> The Armada 375 SoC comes with an USB2 host and device controller and
> an USB3 controller. The USB cluster control register allows to manage
> common features of both USB controllers.
> 
> This commit adds a driver integrated in the generic PHY framework to
> control this USB cluster feature.
> 
> Signed-off-by: Gregory CLEMENT <gregory.clement@free-electrons.com>
> Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
> ---
>  drivers/phy/Kconfig              |   6 ++
>  drivers/phy/Makefile             |   1 +
>  drivers/phy/phy-armada375-usb2.c | 158 +++++++++++++++++++++++++++++++++++++++
>  include/dt-bindings/phy/phy.h    |   1 +
>  4 files changed, 166 insertions(+)
>  create mode 100644 drivers/phy/phy-armada375-usb2.c
> 
> diff --git a/drivers/phy/Kconfig b/drivers/phy/Kconfig
> index 2a436e607f99..625adb0abd43 100644
> --- a/drivers/phy/Kconfig
> +++ b/drivers/phy/Kconfig
> @@ -21,6 +21,12 @@ config PHY_BERLIN_SATA
>  	select GENERIC_PHY
>  	help
>  	  Enable this to support the SATA PHY on Marvell Berlin SoCs.
> +config ARMADA375_USBCLUSTER_PHY

Missing new line here.

> +	def_bool y
> +	depends on MACH_ARMADA_375 || COMPILE_TEST
> +	depends on OF
> +	select GENERIC_PHY
> +
>  

One too many new line.


> +	cluster_phy = dev_get_drvdata(phy->dev.parent);
> +	if (!cluster_phy)
> +		return -ENOMEM;

Is ENOMEM really the appropriate error code here?

Thomas
-- 
Thomas Petazzoni, CTO, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
