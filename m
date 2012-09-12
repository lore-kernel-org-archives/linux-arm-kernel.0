From: shubhrajyoti@ti.com (Shubhrajyoti)
Date: Wed, 12 Sep 2012 11:55:39 +0530
Subject: [PATCHv7 20/23] i2c: omap: switch to threaded IRQ support
In-Reply-To: <20120911215112.GA27031@pengutronix.de>
References: <1347356538-23835-1-git-send-email-shubhrajyoti@ti.com>
 <1347356538-23835-21-git-send-email-shubhrajyoti@ti.com>
 <20120911215112.GA27031@pengutronix.de>
Message-ID: <50502AE3.7040300@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 12 September 2012 03:21 AM, Wolfram Sang wrote:
>> -omap_i2c_isr(int this_irq, void *dev_id)
>> > +omap_i2c_isr(int irq, void *dev_id)
>> >  {
>> >  	struct omap_i2c_dev *dev = dev_id;
>> > +	irqreturn_t ret = IRQ_HANDLED;
> Shouldn't that be IRQ_NONE?
Actually we are processing it so I thought it to be ok.
Also a similar discussion.
 
http://lists.infradead.org/pipermail/linux-arm-kernel/2012-June/104422.html
