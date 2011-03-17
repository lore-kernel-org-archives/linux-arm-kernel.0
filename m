From: avictor.za@gmail.com (avictor.za at gmail.com)
Date: Thu, 17 Mar 2011 10:43:09 +0200
Subject: [PATCHv2 3/9] macb: unify at91 and avr32 platform data
In-Reply-To: <87vczkmy94.fsf@macbook.be.48ers.dk>
References: <1300184096-13937-1-git-send-email-jamie@jamieiles.com>
	<1300184096-13937-4-git-send-email-jamie@jamieiles.com>
	<87vczkmy94.fsf@macbook.be.48ers.dk>
Message-ID: <AANLkTi=TiRnc0ceosH-P7fN7wKrLZE0MCJHQ30gM_Q9b@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

hi,

> ?Jamie> Both at91 and avr32 defines its own platform data structure for
> ?Jamie> the macb driver and both share common structures though at91
> ?Jamie> includes a currently unused phy_irq_pin. ?Create a common
> ?Jamie> eth_platform_data for macb that both at91 and avr32 can use. ?In
> ?Jamie> future we can use this to support other architectures that use the
> ?Jamie> same IP block with the macb driver.
>
> How about at the same time renaming it to something a bit less generic
> like macb_platform_data?

The AT91RM9200 uses the same platform_data structure, but has a
different Ethernet peripheral (ie, not the MACB)

The phy_irq_pin is used in the AT91RM9200 ethernet driver.
(drivers/net/arm/at91_ether.c)


Regards,
  Andrew Victor
