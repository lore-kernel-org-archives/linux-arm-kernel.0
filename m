From: jacmet@sunsite.dk (Peter Korsgaard)
Date: Thu, 17 Mar 2011 09:48:28 +0100
Subject: [PATCHv2 3/9] macb: unify at91 and avr32 platform data
In-Reply-To: <AANLkTi=TiRnc0ceosH-P7fN7wKrLZE0MCJHQ30gM_Q9b@mail.gmail.com>
	(avictor's message of "Thu, 17 Mar 2011 10:43:09 +0200")
References: <1300184096-13937-1-git-send-email-jamie@jamieiles.com>
	<1300184096-13937-4-git-send-email-jamie@jamieiles.com>
	<87vczkmy94.fsf@macbook.be.48ers.dk>
	<AANLkTi=TiRnc0ceosH-P7fN7wKrLZE0MCJHQ30gM_Q9b@mail.gmail.com>
Message-ID: <871v26m8tf.fsf@macbook.be.48ers.dk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

>>>>> "avictor" == avictor za at gmail com <avictor.za@gmail.com> writes:

Hi,

 >> How about at the same time renaming it to something a bit less
 >> generic like macb_platform_data?

 avictor> The AT91RM9200 uses the same platform_data structure, but has a
 avictor> different Ethernet peripheral (ie, not the MACB)

 avictor> The phy_irq_pin is used in the AT91RM9200 ethernet driver.
 avictor> (drivers/net/arm/at91_ether.c)

That should probably be cleaned up as well then. Sharing platform_data
structures between unrelated drivers seems like quite a mess to me.

-- 
Bye, Peter Korsgaard
