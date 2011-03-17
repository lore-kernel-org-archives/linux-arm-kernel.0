From: jamie@jamieiles.com (Jamie Iles)
Date: Thu, 17 Mar 2011 09:34:03 +0000
Subject: [PATCHv2 3/9] macb: unify at91 and avr32 platform data
In-Reply-To: <87wrjyksnm.fsf@macbook.be.48ers.dk>
References: <1300184096-13937-1-git-send-email-jamie@jamieiles.com>
	<1300184096-13937-4-git-send-email-jamie@jamieiles.com>
	<87vczkmy94.fsf@macbook.be.48ers.dk>
	<AANLkTi=TiRnc0ceosH-P7fN7wKrLZE0MCJHQ30gM_Q9b@mail.gmail.com>
	<871v26m8tf.fsf@macbook.be.48ers.dk>
	<20110317085835.GC29758@n2100.arm.linux.org.uk>
	<87wrjyksnm.fsf@macbook.be.48ers.dk>
Message-ID: <20110317093403.GA15396@pulham.picochip.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Mar 17, 2011 at 10:22:53AM +0100, Peter Korsgaard wrote:
> >>>>> "Russell" == Russell King <- ARM Linux <linux@arm.linux.org.uk>> writes:
> 
> Hi,
> 
>  >> That should probably be cleaned up as well then. Sharing platform_data
>  >> structures between unrelated drivers seems like quite a mess to me.
> 
>  Russell> Why should every driver have a separate platform data structure?
>  Russell> Is it right to end up with thousands of unique data structures each
>  Russell> specific to a particular driver?  To me, that sounds like a headache
>  Russell> waiting to happen.
> 
> Well, the point of the platform data is to provide driver specific
> (E.G. not generic) data to the driver, so in general it will be
> different for different hardware.
> 
> The current situation with 2 different structure defination depending on
> arch, macro magic and 1 of these structures also used for a 2nd driver
> isn't optimal.
> 
> But ok, I don't feel strongly about struct macb_platform_data also being
> used for the old at91_ether driver, but it shouldn't be called
> eth_platform_data as it isn't really a generic structure.

Ok, I'll rename to macb_platform_data and update at91_ether to use that 
with a comment describing that we're sharing the platform data with 
macb.  At least that gets rid of the preprocessor stuff in board.h for 
at91 too.

Jamie
