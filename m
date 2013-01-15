From: kishon@ti.com (kishon)
Date: Tue, 15 Jan 2013 20:09:22 +0530
Subject: [RFC PATCH 0/7] usb: musb: add driver for control module
In-Reply-To: <201301151341.08297.arnd@arndb.de>
References: <1358239378-10030-1-git-send-email-kishon@ti.com>
 <201301151341.08297.arnd@arndb.de>
Message-ID: <50F56A1A.3040504@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd,

On Tuesday 15 January 2013 07:11 PM, Arnd Bergmann wrote:
> On Tuesday 15 January 2013, Kishon Vijay Abraham I wrote:
>> Added a new driver for the usb part of control module. This has an API
>> to power on the USB2 phy and an API to write to the mailbox depending on
>> whether MUSB has to act in host mode or in device mode.
>>
>> Writing to control module registers for doing the above task which was
>> previously done in omap glue and in omap-usb2 phy is removed.
>>
>> Also added the dt data to get MUSB working in OMAP platforms.
>> This series has patches for both drivers and ARCH folders, so If it has to
>> be split I'll do it.
>>
>
> The series looks good to me, I just had a minor comment on one patch.
>
> One a somewhat related topic, I wonder whether there are any plans
> on your side to change this driver to support multiple bus glues
> to be built for one kernel image. With a multiplatform kernel, we
> may need all of TUSB6010/OMAP2PLUS/DSPS/UX500 for instance.

We don't have plans as of now. I actually don't expect any changes in 
the driver other than the Kconfig changes. Anyways the probe of glue's 
other than the platform it's running won't get called. right Felipe?

Thanks
Kishon
