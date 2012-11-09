From: p.paneri@samsung.com (Praveen Paneri)
Date: Fri, 9 Nov 2012 18:50:44 +0530
Subject: [PATCH v7 0/5] usb: phy: samsung: Introducing usb phy driver for
 samsung SoCs
In-Reply-To: <CAH9JG2X1a8MqBpnk8uHRjsGnaD7uob5GBhUh_aS5iCprEvi2XQ@mail.gmail.com>
References: <1351573057-22249-1-git-send-email-p.paneri@samsung.com>
 <20121109115440.GC8078@arwen.pp.htv.fi>
 <CAH9JG2X1a8MqBpnk8uHRjsGnaD7uob5GBhUh_aS5iCprEvi2XQ@mail.gmail.com>
Message-ID: <CAD6zSYN6xpHt54d-w=6veb6AErTq6ERQcneo7ewC-qsBoMuThQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Fri, Nov 9, 2012 at 6:06 PM, Kyungmin Park <kmpark@infradead.org> wrote:
> On Fri, Nov 9, 2012 at 8:54 PM, Felipe Balbi <balbi@ti.com> wrote:
>> Hi,
>>
>> On Tue, Oct 30, 2012 at 10:27:32AM +0530, Praveen Paneri wrote:
>>> Changes from v6:
>>> Modified register definitions according to the existing ones.
>>> Changed default PHY clk selection for SoCs.
>>> Improved binding text and rebased to the latest usb-next.
>>>
>>> Changes from v5:
>>> Moved clk_get() to driver's probe function. Now reference clock frequency
>>> selection value is stored in samsung_usbphy structure for later use. Used
>>> IS_ENABLED() instead of #ifdef in samsung_usbphy_get_driver_data().
>>>
>>> Changes from v4:
>>> Moved header file contents to driver's source file
>>> Removed unnecessary print message from driver's probe function
>>> Dropped the Free Software Foundation address from the header
>>> Changed the platform data code to use __initdata
>>>
>>> Changes from v3:
>>> Replaced susbsys_initcall()/module_exit() by module_platform_driver().
>>> Accordingly in the hsotg driver returned -EPROBE_DEFER until phy driver
>>> is registered
>>> Removed unnecessary devm_usb_put_phy() call from the hsotg driver remove.
>>>
>>> Changes from v2:
>>> Changed the driver filenames to samsung-usbphy
>>> Changed 's3c' to 'samsung' for platform device as well as platform data
>>> Moved platform data structure to a separate file
>>> Rectified coding style related errors
>>>
>>> Changes from v1:
>>> Rebased patches to latest usb-next branch
>>> Changed the name 'sec_usbphy' to 'samsung_usbphy'
>>>
>>> This patch set introduces a phy driver for samsung SoCs. It uses the existing
>>> transceiver infrastructure to provide phy control functions. Use of this driver
>>> can be extended for usb host phy as well. Over the period of time all the phy
>>> related code for most of the samsung SoCs can be integrated here.
>>> Removing the existing phy code from mach-s3c64xx. Same can be done for other SoCs
>>> when they start supporting this phy driver.
>>> This driver is tested with smdk6410 and Exynos4210(with DT).
>>>
>>> Praveen Paneri (5):
>>>   usb: phy: samsung: Introducing usb phy driver for hsotg
>>>   usb: s3c-hsotg: Adding phy driver support
> For usb parts:
> Acked-by: Kyungmin Park <kyungmin.park@samsung.com>
Thanks for the ack.
>
>>>   ARM: S3C64XX: Removing old phy setup code
>>>   ARM: S3C64XX: Enabling samsung-usbphy driver
>>>   ARM: Exynos4210: Enabling samsung-usbphy driver
>>
>> guys I can't wait any longer. If I don't get proper Acks today, I will
>> go ahead without all the PHY changes from Samsung :-s
>
> To Praveen,
>
> To remove these dependency and merge issue, please send patches for
> each subsystem. In this case, usb patches for usb tree and others are
> for arm arch.
I will surely take care of this from now onwards. Hope these can be
taken as it is for now.

Thanks,
Praveen
>
> Thank you,
> Kyungmin Park
>>
>> --
>> balbi
>>
>> _______________________________________________
>> linux-arm-kernel mailing list
>> linux-arm-kernel at lists.infradead.org
>> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
>>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-usb" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
