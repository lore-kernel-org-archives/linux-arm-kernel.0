From: kishon@ti.com (ABRAHAM, KISHON VIJAY)
Date: Tue, 10 Jul 2012 13:46:21 +0530
Subject: [PATCH v1 11/11] arm: omap: phy: remove unused functions from
 omap-phy-internal.c
In-Reply-To: <4FFBCBC0.5020603@ti.com>
References: <1340884267-28908-1-git-send-email-kishon@ti.com>
 <1340884267-28908-12-git-send-email-kishon@ti.com>
 <4FFBCBC0.5020603@ti.com>
Message-ID: <CAAe_U6Ly3J90VMz5dP=p4wDauOf1v_K1JRB0Qp8nBYaQhcx==w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Tue, Jul 10, 2012 at 11:59 AM, Rajendra Nayak <rnayak@ti.com> wrote:
> On Thursday 28 June 2012 05:21 PM, Kishon Vijay Abraham I wrote:
>>
>> All the unnessary functions in omap-phy-internal is removed.
>> These functionality are now handled by omap-usb2 phy driver.
>>
>> Cc: Felipe Balbi<balbi@ti.com>
>> Signed-off-by: Kishon Vijay Abraham I<kishon@ti.com>
>> Acked-by: Tony Lindgren<tony@atomide.com>
>> ---
>>   arch/arm/mach-omap2/omap_phy_internal.c |  138
>> -------------------------------
>>   arch/arm/mach-omap2/twl-common.c        |    5 -
>>   arch/arm/mach-omap2/usb-musb.c          |    3 -
>>   3 files changed, 0 insertions(+), 146 deletions(-)
>>
>> diff --git a/arch/arm/mach-omap2/omap_phy_internal.c
>> b/arch/arm/mach-omap2/omap_phy_internal.c
>> index 4c90477..0c610b4 100644
>> --- a/arch/arm/mach-omap2/omap_phy_internal.c
>> +++ b/arch/arm/mach-omap2/omap_phy_internal.c
>> @@ -31,144 +31,6 @@
>>   #include<plat/usb.h>
>>   #include "control.h"
>>
>> -/* OMAP control module register for UTMI PHY */
>> -#define CONTROL_DEV_CONF               0x300
>> -#define PHY_PD                         0x1
>> -
>> -#define USBOTGHS_CONTROL               0x33c
>> -#define        AVALID                          BIT(0)
>> -#define        BVALID                          BIT(1)
>> -#define        VBUSVALID                       BIT(2)
>> -#define        SESSEND                         BIT(3)
>> -#define        IDDIG                           BIT(4)
>> -
>> -static struct clk *phyclk, *clk48m, *clk32k;
>> -static void __iomem *ctrl_base;
>> -static int usbotghs_control;
>> -
>> -int omap4430_phy_init(struct device *dev)
>> -{
>> -       ctrl_base = ioremap(OMAP443X_SCM_BASE, SZ_1K);
>> -       if (!ctrl_base) {
>> -               pr_err("control module ioremap failed\n");
>> -               return -ENOMEM;
>> -       }
>> -       /* Power down the phy */
>> -       __raw_writel(PHY_PD, ctrl_base + CONTROL_DEV_CONF);
>
>
> Just checking, but I hope your new driver handles this too.
> You might not see any issues with it now, but not doing this could
> gate OMAP hitting low power in idle.

I power down the phy during probe in omap-usb2 phy driver.

Thanks
Kishon
