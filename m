From: HartleyS@visionengravers.com (Hartley Sweeten)
Date: Mon, 14 Oct 2013 21:07:18 +0000
Subject: [PATCH 05/11] USB: OHCI: Properly handle ohci-ep93xx suspend
In-Reply-To: <Pine.LNX.4.44L0.1310141647140.6851-100000@netrider.rowland.org>
References: <DC148C5AA1CEBA4E87973D432B1C2D8817DABD8C@P3PWEX4MB008.ex4.secureserver.net>
 <Pine.LNX.4.44L0.1310141647140.6851-100000@netrider.rowland.org>
Message-ID: <DC148C5AA1CEBA4E87973D432B1C2D8817DABF0B@P3PWEX4MB008.ex4.secureserver.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday, October 14, 2013 1:50 PM, Alan Stern wrote:
> On Mon, 14 Oct 2013, Hartley Sweeten wrote:
>> As an alternative to this patch, I have successfully used the ohci-platform
>> driver on the ep93xx. This does move a bit of glue code into the ep93xx
>> core (arch/arm/mach-ep93xx/core.c) but it removes the ohci-ep93xx glue
>> driver completely.
>> 
>> I can post a patch for this shortly if you would like.
>
> That would be great!  It would save me the trouble of fixing 
> Manjanuth's patch and it would remove a source file too!

The only thing I'm not sure about use where to enable the
USB_OHCI_HCD_PLATFORM driver for ARCH_EP93XX.

Right now the ohci-ep93xx glue driver is enabled automatically
when USB_OHCI_HCD is enabled due to the ifdefery. I can add
a new config option similar to the other users of
USB_OHCI_HCD_PLATFORM but I was wondering if there is a
cleaner way.

Regards,
Hartley
