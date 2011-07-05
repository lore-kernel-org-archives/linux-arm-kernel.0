From: matthieu.castet@parrot.com (Matthieu CASTET)
Date: Tue, 5 Jul 2011 12:12:54 +0200
Subject: [PATCH 2/3] at91-ohci: support overcurrent notification
In-Reply-To: <1309856728-8265-2-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1309856728-8265-1-git-send-email-thomas.petazzoni@free-electrons.com>
	<1309856728-8265-2-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <4E12E3A6.3040902@parrot.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Thomas Petazzoni a ?crit :
> Several USB power switches (AIC1526 or MIC2026) have a digital output
> that is used to notify that an overcurrent situation is taking
> place. This digital outputs are typically connected to GPIO inputs of
> the processor and can be used to be notified of those overcurrent
> situations.
> 
> Therefore, we add a new overcurrent_pin[] array in the at91_usbh_data
> structure so that boards can tell the AT91 OHCI driver which pins are
> used for the overcurrent notification. The AT91 OHCI driver simply
> registers an interrupt handler which will log the entry and exit of an
> overcurrent situation in the kernel logs.
>
Why don't you forward the overcurrent notification to the usb stack ?
A printk is quite useless.



Matthieu
