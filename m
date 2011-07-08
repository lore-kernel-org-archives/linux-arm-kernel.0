From: troy.kisky@boundarydevices.com (Troy Kisky)
Date: Fri, 08 Jul 2011 11:38:09 -0700
Subject: [PATCH] net/fec: gasket needs to be enabled for some i.mx
In-Reply-To: <20110708101810.GE6069@pengutronix.de>
References: <20110630161935.GA7977@S2100-06.ap.freescale.net>
	<1309515082-7386-1-git-send-email-shawn.guo@linaro.org>
	<20110708101810.GE6069@pengutronix.de>
Message-ID: <4E174E91.2090609@boundarydevices.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 7/8/2011 3:18 AM, Sascha Hauer wrote:
> On Fri, Jul 01, 2011 at 06:11:22PM +0800, Shawn Guo wrote:
>> On the recent i.mx (mx25/50/53), there is a gasket inside fec
>> controller which needs to be enabled no matter phy works in MII
>> or RMII mode.
>>
>> The current code enables the gasket only when phy interface is RMII.
>> It's broken when the driver works with a MII phy.  The patch uses
>> platform_device_id to distinguish the SoCs that have the gasket and
>> enables it on these SoCs for both MII and RMII mode.
>>
>> Signed-off-by: Troy Kisky <troy.kisky@boundarydevices.com>

While you're making changes, you can change this to
Reported-by: Troy Kisky

Thanks

>> Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
>> Cc: David S. Miller <davem@davemloft.net>
>> Cc: Sascha Hauer <s.hauer@pengutronix.de>
>> ---
>>  arch/arm/mach-imx/clock-imx25.c                 |    2 +-
>>  arch/arm/mach-imx/clock-imx27.c                 |    2 +-
>>  arch/arm/mach-imx/clock-imx35.c                 |    2 +-
>>  arch/arm/mach-mx5/clock-mx51-mx53.c             |    4 +-
>>  arch/arm/plat-mxc/devices/platform-fec.c        |   17 ++++++++-------
>>  arch/arm/plat-mxc/include/mach/devices-common.h |    1 +
>>  drivers/net/fec.c                               |   26 ++++++++++++++++++++--
>>  7 files changed, 38 insertions(+), 16 deletions(-)
> 
> Just realized that this change breaks m68k support. You shouldn't remove
> DRIVER_NAME from fec_devtype[]
> 
> 
> Sascha
> 
