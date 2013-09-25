From: slapdau@yahoo.com.au (Craig McGeachie)
Date: Wed, 25 Sep 2013 18:00:53 +1200
Subject: [PATCH] irq: bcm2835: Re-implement the hardware IRQ handler.
In-Reply-To: <52410949.8070403@wwwdotorg.org>
References: <1379751251-2799-1-git-send-email-slapdau@yahoo.com.au>
 <1379755112-19446-1-git-send-email-slapdau@yahoo.com.au>
 <52410949.8070403@wwwdotorg.org>
Message-ID: <52427C15.6010204@yahoo.com.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 09/24/2013 03:38 PM, Stephen Warren wrote:
>> +#define BAD_IRQ_NUM	-1
>
> That should be 0; Using -1 for invalid IRQ is deprecated.

Could you please point me to something that describes this? I can't find 
anything that limits the internal representations used by the driver for 
an interrupt controller.  That, and the design of 
include/linux/irqdomain.h and kernel/irq/irqdomain.c implies that a 
0-based hwirq numbering scheme is the natural order of things.

Cheers,
Craig.
