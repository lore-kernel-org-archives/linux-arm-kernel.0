From: kishon@ti.com (kishon)
Date: Fri, 18 Jan 2013 17:24:59 +0530
Subject: [RFC PATCH 0/6] USB: Add multiple PHYs of same type
In-Reply-To: <20130118114859.GC4379@arwen.pp.htv.fi>
References: <1358348462-27693-1-git-send-email-kishon@ti.com>
 <20130118114859.GC4379@arwen.pp.htv.fi>
Message-ID: <50F93813.4010107@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 18 January 2013 05:18 PM, Felipe Balbi wrote:
> On Wed, Jan 16, 2013 at 08:30:56PM +0530, Kishon Vijay Abraham I wrote:
>> New platforms are being added which has multiple PHY's (of same type) and
>> which has multiple USB controllers. The binding information has to be
>> present in the PHY library (otg.c) in order for it to return the
>> appropriate PHY whenever the USB controller request for the PHY. So
>> added a new API to pass the binding information. This API should be
>> called by platform specific initialization code.
>>
>> So the binding should be done something like
>> usb_bind_phy("musb-hdrc.0.auto", 0, "omap-usb2.1.auto"); specifying the USB
>> controller device name, index, and the PHY device name.
>> I have done this binding for OMAP platforms, but it should be done for
>> all the platforms.
>>
>> After this design, the phy can be got by passing the USB controller device
>> pointer and the index.
>>
>> Developed this patch series on
>> git://git.kernel.org/pub/scm/linux/kernel/git/balbi/usb.git xceiv
>> after applying "usb: musb: add driver for control module" patch series.
>>
>> Did basic enumeration testing in omap4 panda, omap4 sdp and omap3 beagle.
>
> please resend without RFC so I can apply.

I'll resend after addressing Roger's comments in a while.

Thanks
Kishon
