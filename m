From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 17 Mar 2011 08:58:35 +0000
Subject: [PATCHv2 3/9] macb: unify at91 and avr32 platform data
In-Reply-To: <871v26m8tf.fsf@macbook.be.48ers.dk>
References: <1300184096-13937-1-git-send-email-jamie@jamieiles.com>
	<1300184096-13937-4-git-send-email-jamie@jamieiles.com>
	<87vczkmy94.fsf@macbook.be.48ers.dk>
	<AANLkTi=TiRnc0ceosH-P7fN7wKrLZE0MCJHQ30gM_Q9b@mail.gmail.com>
	<871v26m8tf.fsf@macbook.be.48ers.dk>
Message-ID: <20110317085835.GC29758@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Mar 17, 2011 at 09:48:28AM +0100, Peter Korsgaard wrote:
> >>>>> "avictor" == avictor za at gmail com <avictor.za@gmail.com> writes:
> 
> Hi,
> 
>  >> How about at the same time renaming it to something a bit less
>  >> generic like macb_platform_data?
> 
>  avictor> The AT91RM9200 uses the same platform_data structure, but has a
>  avictor> different Ethernet peripheral (ie, not the MACB)
> 
>  avictor> The phy_irq_pin is used in the AT91RM9200 ethernet driver.
>  avictor> (drivers/net/arm/at91_ether.c)
> 
> That should probably be cleaned up as well then. Sharing platform_data
> structures between unrelated drivers seems like quite a mess to me.

Why should every driver have a separate platform data structure?
Is it right to end up with thousands of unique data structures each
specific to a particular driver?  To me, that sounds like a headache
waiting to happen.
