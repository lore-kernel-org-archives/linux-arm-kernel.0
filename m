From: b.brezillon@overkiz.com (boris brezillon)
Date: Mon, 12 Aug 2013 22:46:38 +0200
Subject: [PATCH] usb: gadget: at91_udc: add usb_clk for transition to
 common clk framework
In-Reply-To: <20130812180851.GF27954@radagast>
References: <1375337885-2684-1-git-send-email-b.brezillon@overkiz.com>
 <5208E881.3030205@atmel.com> <20130812180851.GF27954@radagast>
Message-ID: <520949AE.6080207@overkiz.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Felipe

On 12/08/2013 20:08, Felipe Balbi wrote:
> On Mon, Aug 12, 2013 at 03:52:01PM +0200, Nicolas Ferre wrote:
>> On 01/08/2013 08:18, Boris BREZILLON :
>>> The AT91 PMC (Power Management Controller) provides an USB clock used by
>>> USB Full Speed host (ohci) and USB Full Speed device (udc).
>>> The usb drivers (ohci and udc) must configure this clock to 48Mhz.
>>> This configuration was formely done in mach-at91/clock.c, but this
>>> implementation will be removed when moving to common clk framework.
>>>
>>> This patch adds support for usb clock retrieval and configuration, and is
>>> backward compatible with the current at91 clk implementation (if usb clk
>>> is not found, it does not configure/enable it).
>>>
>>> Signed-off-by: Boris BREZILLON <b.brezillon@overkiz.com>
>> Acked-by: Nicolas Ferre <nicolas.ferre@atmel.com>
> I don't have the original, where is it ? Was it not Cced to linux-usb ?
> Can someone resend with Nicolas' Acked-by in place ?
>
This mail was sent to linux-usb at vger.kernel.org and to you (balbi at ti.com).
It may have been filtered.

Anyway, you asked me to rework the 2nd version (which I did).

I think it's better to review the 3rd one 
(https://lkml.org/lkml/2013/8/2/102).

Best Regards,

Boris
