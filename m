From: kishon@ti.com (Kishon Vijay Abraham I)
Date: Mon, 7 Jul 2014 19:39:29 +0530
Subject: [RFC PATCH 2/2] phy: core: the node pointer of PHY need not be
 the same as that of PHY provider
In-Reply-To: <20140707131232.GI6407@lee--X1>
References: <1404486474-28312-1-git-send-email-kishon@ti.com>
 <1404486474-28312-3-git-send-email-kishon@ti.com>
 <20140707131232.GI6407@lee--X1>
Message-ID: <53BAAA19.9050106@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Monday 07 July 2014 06:42 PM, Lee Jones wrote:
> On Fri, 04 Jul 2014, Kishon Vijay Abraham I wrote:
> 
>> In case of multi-phy PHY providers, each PHY should be modeled as a sub
>> node of the PHY provider. Then each PHY will have a different node pointer
>> (node pointer of sub node) than that of PHY provider. Added this provision
>> in the PHY core.
>> Also fixed all drivers to use the updated API.
>>
>> Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
>> ---
>>  Documentation/phy.txt               |   10 ++++++----
>>  drivers/phy/phy-bcm-kona-usb2.c     |    2 +-
>>  drivers/phy/phy-core.c              |   25 ++++++++++++++++++-------
>>  drivers/phy/phy-exynos-dp-video.c   |    2 +-
>>  drivers/phy/phy-exynos-mipi-video.c |    2 +-
>>  drivers/phy/phy-exynos5-usbdrd.c    |    3 ++-
>>  drivers/phy/phy-exynos5250-sata.c   |    2 +-
>>  drivers/phy/phy-mvebu-sata.c        |    2 +-
>>  drivers/phy/phy-omap-usb2.c         |    2 +-
>>  drivers/phy/phy-samsung-usb2.c      |    3 ++-
>>  drivers/phy/phy-sun4i-usb.c         |    2 +-
>>  drivers/phy/phy-ti-pipe3.c          |    2 +-
>>  drivers/phy/phy-twl4030-usb.c       |    2 +-
>>  drivers/phy/phy-xgene.c             |    2 +-
>>  include/linux/phy/phy.h             |   15 ++++++++++-----
>>  15 files changed, 48 insertions(+), 28 deletions(-)
> 
> I wrote a very similar patch already.  I knew I should have sent it on
> Friday. :(

No problem! you can send your patch along with the MiPHY series.

Cheers
Kishon
> 
> Patch looks good, just a real minor point.
> 
>>  	phy->dev.class = phy_class;
>>  	phy->dev.parent = dev;
>> -	phy->dev.of_node = dev->of_node;
>> +	phy->dev.of_node = node?node:dev->of_node;
> 
> There should be spaces either side of the '?' and ':', or you can do
> this more succinctly by:
> 
> phy->dev.of_node = node ?: dev->of_node;
> 
> Once fixed, feel free to add my:
> 
> Acked-by: Lee Jones <lee.jones@linaro.org>
> 
