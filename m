From: p.paneri@samsung.com (Praveen Paneri)
Date: Thu, 9 Aug 2012 15:26:48 +0530
Subject: [PATCH v3 1/5] usb: phy: samsung: Introducing usb phy driver for
 hsotg
In-Reply-To: <20120809092853.GJ12174@arwen.pp.htv.fi>
References: <1344411661-17821-1-git-send-email-p.paneri@samsung.com>
 <1344411661-17821-2-git-send-email-p.paneri@samsung.com>
 <20120809092853.GJ12174@arwen.pp.htv.fi>
Message-ID: <CAD6zSYO4b6FXAdAKBnz1xU1TW3=rtqLdnD+X7-K8jxFVTaPtuA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Aug 9, 2012 at 2:58 PM, Felipe Balbi <balbi@ti.com> wrote:
> On Wed, Aug 08, 2012 at 01:10:57PM +0530, Praveen Paneri wrote:
>> +static int __init samsung_usbphy_driver_init(void)
>> +{
>> +     return platform_driver_register(&samsung_usbphy_driver);
>> +}
>> +subsys_initcall(samsung_usbphy_driver_init);
>
> let's make use of the module_platform_driver() and have dependent
> drivers return -EPROBE_DEFER until this has registered.
Thanks! I will modify accordingly and resend.

Praveen
>
> --
> balbi
