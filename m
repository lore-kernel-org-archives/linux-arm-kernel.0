From: sergei.shtylyov@cogentembedded.com (Sergei Shtylyov)
Date: Wed, 16 Mar 2016 14:34:41 +0300
Subject: [PATCH 3/5] ARM: davinci: da8xx: add cfgchip2 to resources
In-Reply-To: <56E8D720.7000508@lechnology.com>
References: <1458081473-8223-1-git-send-email-david@lechnology.com>
 <1458081473-8223-3-git-send-email-david@lechnology.com>
 <56E8906E.7070800@cogentembedded.com> <56E8D720.7000508@lechnology.com>
Message-ID: <56E944D1.9000907@cogentembedded.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello.

On 3/16/2016 6:46 AM, David Lechner wrote:

>>     No, this register is shared b/w MUSB and OHCI. The proper thing to
>> do is to write the PHY driver and let it control this shared register.

> OK. I've started working on this. I am looking at using struct usb_phy,
> however, enum usb_phy_type only has USB_PHY_TYPE_UNDEFINED, USB_PHY_TYPE_USB2,
> and USB_PHY_TYPE_USB3. Would it be acceptable to use USB_PHY_TYPE_UNDEFINED
> for the ohci since it is USB 1.1? Or perhaps I should use the more generic
> struct phy for that one?

    No new USB PHY drivers accepted, look at drivers/phy/ instead please.

MBR, Sergei
