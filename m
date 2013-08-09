From: alexander.shishkin@linux.intel.com (Alexander Shishkin)
Date: Fri, 09 Aug 2013 17:42:07 +0300
Subject: [PATCH 3/3] usb: host: delete chipidea dependency
In-Reply-To: <Pine.LNX.4.44L0.1308091034330.1405-100000@iolanthe.rowland.org>
References: <Pine.LNX.4.44L0.1308091034330.1405-100000@iolanthe.rowland.org>
Message-ID: <87vc3f9b9c.fsf@ashishki-desk.ger.corp.intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Alan Stern <stern@rowland.harvard.edu> writes:

> On Fri, 9 Aug 2013, Alexander Shishkin wrote:
>
>> Peter Chen <peter.chen@freescale.com> writes:
>> 
>> > Now, chipidea host has already depended on USB_EHCI_HCD
>> >
>> > Signed-off-by: Peter Chen <peter.chen@freescale.com>
>> 
>> Alan, what do you think?
>> 
>> > ---
>> >  drivers/usb/host/Kconfig |    4 ++--
>> >  1 files changed, 2 insertions(+), 2 deletions(-)
>> >
>> > diff --git a/drivers/usb/host/Kconfig b/drivers/usb/host/Kconfig
>> > index cf521d6..b548554 100644
>> > --- a/drivers/usb/host/Kconfig
>> > +++ b/drivers/usb/host/Kconfig
>> > @@ -63,7 +63,7 @@ config USB_EHCI_HCD
>> >  
>> >  config USB_EHCI_ROOT_HUB_TT
>> >  	bool "Root Hub Transaction Translators"
>> > -	depends on USB_EHCI_HCD || USB_CHIPIDEA_HOST
>> > +	depends on USB_EHCI_HCD
>> >  	---help---
>> >  	  Some EHCI chips have vendor-specific extensions to integrate
>> >  	  transaction translators, so that no OHCI or UHCI companion
>> > @@ -75,7 +75,7 @@ config USB_EHCI_ROOT_HUB_TT
>> >  
>> >  config USB_EHCI_TT_NEWSCHED
>> >  	bool "Improved Transaction Translator scheduling"
>> > -	depends on USB_EHCI_HCD || USB_CHIPIDEA_HOST
>> > +	depends on USB_EHCI_HCD
>> >  	default y
>> >  	---help---
>> >  	  This changes the periodic scheduling code to fill more of the low
>> > -- 
>> > 1.7.0.4
>
> I approve.  Getting rid of dependencies is good.

Can I have you acked-by and take this patch to my tree?

Thanks,
--
Alex
