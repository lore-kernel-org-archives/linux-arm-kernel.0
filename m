From: kishon@ti.com (Kishon Vijay Abraham I)
Date: Tue, 7 Jan 2014 15:23:35 +0530
Subject: [PATCH v2] phy: kconfig: add depends on "USB_PHY" to OMAP_USB2
 and TWL4030_USB
In-Reply-To: <20131226130504.GA19462@blackmetal.musicnaut.iki.fi>
References: <1386079732-19657-1-git-send-email-kishon@ti.com>
 <20131226130504.GA19462@blackmetal.musicnaut.iki.fi>
Message-ID: <52CBCE9F.7040908@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 26 December 2013 06:35 PM, Aaro Koskinen wrote:
> Hi,
> 
> On Tue, Dec 03, 2013 at 07:38:52PM +0530, Kishon Vijay Abraham I wrote:
>> Fixes
>> warning: (OMAP_USB2 && TWL4030_USB) selects USB_PHY which has unmet
>> direct dependencies (USB_SUPPORT)
>> that shows up while disabling USB_SUPPORT from menuconfig.
> [...]
>>  config TWL4030_USB
>>  	tristate "TWL4030 USB Transceiver Driver"
>>  	depends on TWL4030_CORE && REGULATOR_TWL4030 && USB_MUSB_OMAP2PLUS
>> +	depends on USB_PHY
>>  	select GENERIC_PHY
>> -	select USB_PHY
>>  	help
>>  	  Enable this to support the USB OTG transceiver on TWL4030
>>  	  family chips (including the TWL5030 and TPS659x0 devices).
> 
> This introduced a minor problem in 3.13-rc5: User is no longer able to
> select TWL4030_USB with menuconfig, since there is no menu entry for
> enabling USB_PHY. The only way to enable TWL4030_USB is to enable some
> other option first that happens to select USB_PHY...

huh.. I think we should go back to my v1 [1] or make USB_PHY selectable. I'm
not sure if there is any other way to handle this.

Thanks
Kishon

[1] -> https://groups.google.com/forum/#!topic/linux.kernel/Omf83s4rkwY
> 
> A.
> 
