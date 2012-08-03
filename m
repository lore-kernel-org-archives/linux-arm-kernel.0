From: kishon@ti.com (ABRAHAM, KISHON VIJAY)
Date: Fri, 3 Aug 2012 20:03:13 +0530
Subject: [PATCH v6 03/11] drivers: usb: otg: make twl6030_usb as a
 comparator driver to omap_usb2
In-Reply-To: <20120803132852.GE8269@arwen.pp.htv.fi>
References: <1343639400-28725-1-git-send-email-kishon@ti.com>
 <1343639400-28725-4-git-send-email-kishon@ti.com>
 <20120803132852.GE8269@arwen.pp.htv.fi>
Message-ID: <CAAe_U6+HZfotZyf=YGf16hvNgZN5Pdk2zz+ywcFR71D=JxQ=XA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Fri, Aug 3, 2012 at 6:58 PM, Felipe Balbi <balbi@ti.com> wrote:
> Hi,
>
> On Mon, Jul 30, 2012 at 02:39:52PM +0530, Kishon Vijay Abraham I wrote:
>> All the PHY configuration other than VBUS, ID GND and OTG SRP are removed
>> from twl6030. The phy configurations are taken care by the dedicated
>> usb2 phy driver. So twl6030 is made as comparator driver for VBUS and
>> ID detection.
>>
>> Writing to control module which is now handled in omap2430.c should be
>> removed once a driver for control module is in place.
>>
>> Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
>
> This looks good for the time being. Do you think it has any hard
> dependencies on your new phy drivers, or can I apply this without those
> other patches ??

It has a hard dependency on usb2phy driver.

Thanks
Kishon
