From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 18 Mar 2011 15:41:18 +0000
Subject: [PATCHv2 3/9] macb: unify at91 and avr32 platform data
In-Reply-To: <20110317215101.GC2927@pulham.picochip.com>
References: <1300184096-13937-1-git-send-email-jamie@jamieiles.com>
	<1300184096-13937-4-git-send-email-jamie@jamieiles.com>
	<87vczkmy94.fsf@macbook.be.48ers.dk>
	<AANLkTi=TiRnc0ceosH-P7fN7wKrLZE0MCJHQ30gM_Q9b@mail.gmail.com>
	<871v26m8tf.fsf@macbook.be.48ers.dk>
	<20110317085835.GC29758@n2100.arm.linux.org.uk>
	<87wrjyksnm.fsf@macbook.be.48ers.dk>
	<20110317093403.GA15396@pulham.picochip.com>
	<20110317215101.GC2927@pulham.picochip.com>
Message-ID: <20110318154118.GQ29758@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Mar 17, 2011 at 09:51:01PM +0000, Jamie Iles wrote:
> On Thu, Mar 17, 2011 at 09:34:03AM +0000, Jamie Iles wrote:
> > Ok, I'll rename to macb_platform_data and update at91_ether to use 
> > that with a comment describing that we're sharing the platform data 
> > with macb.  At least that gets rid of the preprocessor stuff in 
> > board.h for at91 too.
> 
> So here's the updated patch with changes to the at91_ether driver to 
> share the data with macb.
> 
> Russell, are you happy to take this series?  If so, how would you prefer 
> it, in the patch system or as a git pull?

As Nicolas Ferre is listed in MAINTAINERS as being responsible for the
MACB driver, I think he should at last Ack these patches first.

I'm also concious of the fact that Linus complains if my tree contains
changes for drivers/ stuff as well as ARM stuff, so I'm nervous about
taking it as-is.  So, I'd rather see drivers stuff separated as much
as possible from the arch updates.

I'm also concious that this has become ready for potentially merging
during the merge window, and therefore hasn't had previous exposure
in linux-next, and so should wait until the next merge window.  I do
feel that I'm going to be yelled at for saying that... but I'm sure
I'll also be yelled at if I did take it.
