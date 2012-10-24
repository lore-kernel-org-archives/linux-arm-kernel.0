From: nsekhar@ti.com (Sekhar Nori)
Date: Wed, 24 Oct 2012 16:40:32 +0530
Subject: [PATCH] usb: remove CONFIG_USB_MUSB_HOST etc
In-Reply-To: <20121023123927.GB29281@arwen.pp.htv.fi>
References: <1349702227-24875-1-git-send-email-const@MakeLinux.com>
 <50868EED.7050909@ti.com> <20121023123927.GB29281@arwen.pp.htv.fi>
Message-ID: <5087CCA8.9020906@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/23/2012 6:09 PM, Felipe Balbi wrote:
> Hi,
> 
> On Tue, Oct 23, 2012 at 06:04:53PM +0530, Sekhar Nori wrote:
>> On 10/8/2012 6:47 PM, Constantine Shulyupin wrote:
>>> From: Constantine Shulyupin <const@MakeLinux.com>
>>>
>>> Remove USB configuration in arch/arm/mach-davinci/usb.c accordingly 
>>> CONFIG_USB_MUSB_OTG CONFIG_USB_MUSB_PERIPHERAL CONFIG_USB_MUSB_HOST 
>>> and set MUSB_OTG configuration by default
>>> because this configuration options are removed from Kconfig.
>>>
>>> Signed-off-by: Constantine Shulyupin <const@MakeLinux.com>
>>
>> Queuing this patch for v3.8. Since the config options are removed there
>> is no use having code which refers to them. The patch has been tested on
>> DM644x and DM365 in both host and gadget mode (I will add this
>> information to commit text while committing). Without this patch .mode
>> seems to be defaulting to MUSB_UNDEFINED which I think is definitely wrong.
> 
> sorry for the delay, this looks ok:
> 
> Acked-by: Felipe Balbi <balbi@ti.com>

Thanks Felipe, I added your ack.

Constantine,

Patches touching arch/arm/* should be prefixed with 'ARM:' and those
touching mach-davinci should be prefixed with 'davinci:'. I added these
two while committing the patch this time. Please take care next time on.

Thanks,
Sekhar
