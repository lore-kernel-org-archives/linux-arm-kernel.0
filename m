From: kishon@ti.com (ABRAHAM, KISHON VIJAY)
Date: Mon, 30 Jul 2012 15:16:32 +0530
Subject: [PATCH v6 01/11] drivers: usb: otg: add a new driver for omap
 usb2 phy
In-Reply-To: <501655F2.7070900@ti.com>
References: <1343639400-28725-1-git-send-email-kishon@ti.com>
 <1343639400-28725-2-git-send-email-kishon@ti.com>
 <501655F2.7070900@ti.com>
Message-ID: <CAAe_U6LWEiAE8TVVEQ5LcKy0_+J7Er2vP71MrQVrg=ZteyAeCw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Mon, Jul 30, 2012 at 3:07 PM, Shubhrajyoti <shubhrajyoti@ti.com> wrote:
> On Monday 30 July 2012 02:39 PM, Kishon Vijay Abraham I wrote:
>> +                     writel(~PHY_PD, phy->control_dev);
>> +                     /* XXX: add proper documentation for this delay */
>> +                     mdelay(200);
> Do you need this to be busy?
This might be called from interrupt context. This delay was initially
added in omap_phy_internal.c and I just inherited it.

Thanks
Kishon
